import Foundation
import Adapty

final class AdaptyManager {
    static let shared = AdaptyManager()
    
    // MARK: Properties
    
    static var isSubscribeAdaptyActive = false
    var generalPaywall: GeneralPaywall?
    var paywalls: [PaywallObject: AdaptyPaywallModel] = [:]
    
    // MARK: Init
    
    private init() {}
    
    // MARK: Setup
    
    func configure() async {
        do {
            let config = Adapty.Configuration
                .builder(withAPIKey: AppConfig.adaptyKey)
            
            try await Adapty.activate(with: config.build())
            
            await loadGeneralPaywall()
            await AdaptyReviewingState.replacementPaywall()
        } catch {
            print("error config")
        }
    }
    
    // MARK: Methods
    
    private func loadGeneralPaywall() async  {
        do {
            let paywall = try await Adapty.getPaywall(placementId: "general_placement")
            await getPaywalls(paywall: paywall)
        } catch {
            print("error general paywall")
        }
    }
    
    private func getPaywalls(paywall: AdaptyPaywall) async {
        guard let remoteConfig = paywall.remoteConfig?.dictionary else { return }
        generalPaywall = GeneralPaywall.createGeneralPaywall(data: remoteConfig)
        
        for placement in generalPaywall?.placementsId ?? [] {
            do {
                let currentPaywall = try await Adapty.getPaywall(placementId: placement)
                let currentProduct = try await Adapty.getPaywallProducts(paywall: currentPaywall)
                
                guard let paywallName = currentPaywall.name.components(separatedBy: "-").first?.lowercased() else { return }
                let paywallObject = PaywallObject(placement: currentPaywall.placementId, typeName: paywallName)
                self.paywalls[paywallObject] = AdaptyPaywallModel(remoteConfig: currentPaywall.remoteConfig?.dictionary ?? [:], products: currentProduct)
            } catch {
                print("paywall not loaded")
            }
        }
    }
    
    func checkSubscription() async {
        do {
            let profile = try await Adapty.getProfile()
            let isSubscribe = profile.accessLevels["premium"]?.isActive ?? false
            AdaptyManager.isSubscribeAdaptyActive = isSubscribe
        } catch {
            AdaptyManager.isSubscribeAdaptyActive = false
            print(error)
        }
    }
    
    func purchases(product: AdaptyPaywallProduct) async -> AdaptyPurchaseState {
        do {
            _ = try await Adapty.makePurchase(product: product)
            _ = await checkSubscription()
            return .success
        } catch let error as AdaptyError {
            return error.adaptyErrorCode == .paymentCancelled ? .cancel : .error
        } catch {
            return .error
        }
    }
    
    
    func restore() async -> AdaptyPurchaseState {
        do {
            _ = try await Adapty.restorePurchases()
            return .success
        } catch {
            return .error
        }
    }
}

extension AdaptyManager {
    static func getCurrentProduct(for placement: AdaptyPlacment) -> [AdaptyPaywallProduct] {
        return AdaptyManager.shared.paywalls.first(where: {$0.key.placement == placement.rawValue})?.value.products ?? []
    }
    
    static func getCurrentPaywall(for placement: AdaptyPlacment) -> String {
        guard let paywall = AdaptyManager.shared.paywalls.first(where: { $0.key.placement == placement.rawValue }) else { return "" }
        return paywall.key.typeName
    }
    
    static func getGlobalRemoteSettings<T>(key: PaywallKeys) -> T {
        let value = AdaptyManager.shared.generalPaywall?.globalSettings.first(where: {$0.key == key.rawValue})?.value as? T
        return value ?? AdaptyManager.catchNilRemoteConfigValue()
    }
    
    static func getRemoteValue<T>(for placement: AdaptyPlacment, key : PaywallKeys) -> T{
        return AdaptyManager.getRemoteConfigValue(for: placement.rawValue, key: key)
    }
    
    static private func getRemoteConfigValue<T>(for placement: String, key: PaywallKeys) -> T {
        guard let remoteConfig = AdaptyManager.shared.paywalls.first(where: {$0.key.placement == placement})?.value.remoteConfig else {
            return AdaptyManager.catchNilRemoteConfigValue()
        }
        if let dictValue = remoteConfig[key.rawValue] as? [String:T] {
            return AdaptyManager.getLocalizedRemoteConfig(from: dictValue) ?? AdaptyManager.catchNilRemoteConfigValue()
        } else {
            return remoteConfig[key.rawValue] as? T ?? AdaptyManager.catchNilRemoteConfigValue()
        }
    }
    
    static func formattedText(for product: AdaptyProduct, text: String, needX2Price: Bool = false) -> String {
        return text
            .replacingOccurrences(of: "%price%", with: price(for: product,needX2: needX2Price))
            .replacingOccurrences(of: "%period%", with: period(for: product))
    }
    
    static func price(for product: AdaptyProduct, needX2: Bool = false) -> String {
        let needX2: Double = needX2 == true ? 2 : 1
        return String(format: "\(product.skProduct.priceLocale.currencySymbol ?? "")%.2f", product.skProduct.price.doubleValue * needX2)
    }
    
    static func priceDay(for product: AdaptyProduct) -> String {
        return String(format: "\(product.skProduct.priceLocale.currencySymbol ?? "")%.2f", product.skProduct.price.doubleValue / 7)
    }
    
    static func priceMonth(for product: AdaptyProduct) -> String {
        return String(format: "\(product.skProduct.priceLocale.currencySymbol ?? "")%.2f", product.skProduct.price.doubleValue / 12)
    }
    
    static func priceWeek(for product: AdaptyProduct) -> String {
        return String(format: "\(product.skProduct.priceLocale.currencySymbol ?? "")%.2f", product.skProduct.price.doubleValue / 4)
    }
    
    static func priceYear(for product: AdaptyProduct) -> String {
        return String(format: "\(product.skProduct.priceLocale.currencySymbol ?? "")%.2f", (product.skProduct.price.doubleValue / 12) / 4)
    }
    
    static func periodWith(for product: AdaptyProduct) -> String {
        switch product.skProduct.subscriptionPeriod?.unit {
        case .week:
            return "Weekly".localizable
        case .month:
            return "Monthly".localizable
        case .year:
            return "Yearly".localizable
        case .day:
            guard let numberPeriod = product.skProduct.subscriptionPeriod?.numberOfUnits else { return ""}
            if (numberPeriod % 7) == 0 {
                return "Weekly".localizable
            } else {
                return "Daily".localizable
            }
        default:
            return ""
        }
    }
    
    static func period(for product: AdaptyProduct) -> String {
        switch product.skProduct.subscriptionPeriod?.unit {
        case .week:
            return "week".localizable
        case .month:
            return "month".localizable
        case .year:
            return "year".localizable
        case .day:
            guard let numberPeriod = product.skProduct.subscriptionPeriod?.numberOfUnits else { return ""}
            if (numberPeriod % 7) == 0 {
                return "week".localizable
            } else {
                return "day".localizable
            }
        default:
            return ""
        }
    }
    
    static private func getLocalizedRemoteConfig<T>(from data:[String:T]) -> T? {
        let locale = Locale.current.language.languageCode?.identifier
        
        let supportLocals = data.first(where: { $0.key.components(separatedBy: "-").first == locale })
        if locale == "zh-Hant" {
            return data.first(where: { "zh" == $0.key })?.value as? T
        }  else if supportLocals == nil {
            return data.first(where: { "en" == $0.key })?.value as? T
        } else {
            return data.first(where: { $0.key.components(separatedBy: "-").first == locale})?.value as? T
        }
    }
    
    static private func catchNilRemoteConfigValue<T>() -> T {
        if let optionalType = T.self as? ExpressibleByNilLiteral.Type {
            return optionalType.init(nilLiteral: ()) as! T
        } else if let defaultValue = 0 as? T {
            return defaultValue
        } else if let defaultValue = 0.0 as? T {
            return defaultValue
        } else if let defaultValue = false as? T {
            return defaultValue
        } else if let defaultValue = "" as? T {
            return defaultValue
        } else {
            fatalError("Unsupported type: \(T.self)")
        }
    }
}
