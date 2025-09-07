import SwiftUI
import PopupView

struct HomeView: View {
    // MARK: Properties
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            Color.bgMain
                .ignoresSafeArea()
            
            VStack {
                navigationTitleView()
                    .padding(.bottom)
                
                ScrollView {
                    
                    mainConditionerView()
                        .padding(.bottom, 20)
                    
                    temperatureView()
                        .padding(.bottom, 20)
                    
                    fanSpeed()
                        .padding(.bottom, 20)
                    
                    otherView()
                }
                    
                TurnButtonView(type: viewModel.statusButton) {
                    viewModel.statusButton = viewModel.statusButton == .turnOn ? .turnOff : .turnOn
                    viewModel.isConnectedConditioner = viewModel.statusButton == .turnOn ? false : true
                }
                .padding(.horizontal)
                
                Spacer()
            }
            
            if viewModel.showSuperOffer || viewModel.showTimer {
                Color.bgSheet.opacity(0.3)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            AttManager.shared.config()
            viewModel.showPaywall = {
                router.showPaywall(type: .paywall)
            }
        }
        .onWillAppear {
            viewModel.checkState()
        }
        .navigationBarBackButtonHidden()
        .popup(isPresented: $viewModel.showSuperOffer) {
            SupperOfferView {
                viewModel.showSuperOffer = false
            } openAction: {
                router.showSuperOffer()
            }

        } customize: {
            $0
                .type(.toast)
                .displayMode(.sheet)
        }
        .popup(isPresented: $viewModel.showTimer) {
            SetupTimerView {
                viewModel.setupTimer = true
                viewModel.showTimer = false
            } closeAction: {
                viewModel.showTimer = false
            }
        } customize: {
            $0
                .type(.toast)
                .displayMode(.sheet)
                .closeOnTap(false)
        }
    }
    
    func navigationTitleView() -> some View {
        HStack {
            
            ButtonImage(image: .settingsIcon, size: 40) {
                router.showSettings()
            }
            
            Spacer()
            
            if viewModel.selectedName == "" {
                Button {
                    router.showSearch()
                } label: {
                    HStack {
                        Image(.connectIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20)
                        
                        Text("Connect".localizable)
                            .foregroundStyle(.white)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(
                        LinearGradient(colors: [.gradientBlueFirst, .gradientBlueSecond], startPoint: .leading, endPoint: .trailing)
                    )
                    .clipShape(Capsule())
                }
            } else {
                Button {
                    router.showSearch()
                } label: {
                    HStack {
                        Text(viewModel.selectedName)
                            .foregroundStyle(.black)
                            .font(.system(size: 17, weight: .semibold))
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 40)
                    .background(
                        LinearGradient(colors: [.white, .gradientWhite], startPoint: .top, endPoint: .bottom)
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.border.opacity(0.15), lineWidth: 1)
                    }
                    .clipShape(Capsule())
                }
            }
        }
        .padding(.horizontal, 12)
    }
    
    func mainConditionerView() -> some View {
        VStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.shadow(.inner(color: .black.opacity(0.22), radius: 10, y: 4)))
                .foregroundStyle(.fillsQuaternary.opacity(0.12))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white, lineWidth: 0.33)
                }
                .frame(height: 185)
                .overlay {
                    VStack {
                        HStack(alignment: .top) {
                            Spacer()
                            
                            ButtonTemperatureView(isConnect: $viewModel.isConnectedConditioner, type: .minus) {
                                viewModel.countTapped += 1
                                if viewModel.currentCelsium != 16 && viewModel.isConnectedConditioner {
                                    viewModel.currentCelsium -= 1
                                }
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text(viewModel.isConnectedConditioner ? "\(viewModel.currentCelsium)" : "- -")
                                    .foregroundStyle(.black.opacity(viewModel.isConnectedConditioner ? 1 : 0.2))
                                    .font(.system(size: 67, weight: .bold))
                                    .padding(.top, -10)
                                
                                Text("Celsius".localizable)
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(viewModel.isConnectedConditioner ? .labelsSecondary.opacity(0.6) : .black.opacity(0.2))
                                    .padding(.top, -34)
                            }
                            
                            Spacer()
                            
                            ButtonTemperatureView(isConnect: $viewModel.isConnectedConditioner, type: .plus) {
                                viewModel.countTapped += 1
                                if viewModel.currentCelsium != 30 && viewModel.isConnectedConditioner {
                                    viewModel.currentCelsium += 1
                                }
                                
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 30)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Image(.ecoSelectedIcon)
                                .opacity(!viewModel.isConnectedConditioner ? 0.2 : viewModel.ecoMode == .on ? 1 : 0.2)
                            
                            Spacer()
                            
                            Image(.swingHorizontalSelectedIcon)
                                .opacity(!viewModel.isConnectedConditioner ? 0.2 : viewModel.swingType == .horizontal ? 1 : 0.2)
                            
                            Spacer()
                            
                            Image(.swingVerticalSelectedIcon)
                                .opacity(!viewModel.isConnectedConditioner ? 0.2 : viewModel.swingType == .vertical ? 1 : 0.2)
                            
                            Spacer()
                            
                            Image(.timerSelectedIcon)
                                .opacity(!viewModel.isConnectedConditioner ? 0.2 : viewModel.setupTimer ? 1 : 0.2)
                            
                            Spacer()
                        }
                        .padding(.bottom)
                    }
                }
                
        }
        .padding(.horizontal)
    }
    
    func temperatureView() -> some View {
        HStack {
            TemperatureItemView(isConnect: $viewModel.isConnectedConditioner, type: .cool, selected: viewModel.temperatureIndexSelected == 0 ? true : false) {
                viewModel.temperatureIndexSelected = 0
                viewModel.countTapped += 1
            }
            
            TemperatureItemView(isConnect: $viewModel.isConnectedConditioner, type: .heat, selected: viewModel.temperatureIndexSelected == 1 ? true : false) {
                viewModel.temperatureIndexSelected = 1
                viewModel.countTapped += 1
            }
        }
        .padding(.horizontal)
    }
    
    func fanSpeed() -> some View {
        VStack(spacing: 8) {
            Text("Fan Speed".localizable)
                .foregroundStyle(.labelsSecondary.opacity(viewModel.isConnectedConditioner ? 0.3 : 0.2))
                .font(.system(size: 20, weight: .semibold))
            
            HStack {
                FanSpeedItemView(isConnect: $viewModel.isConnectedConditioner, type: .low, selected: viewModel.fanSpeedIndexSelected == 0 ? true : false) {
                    viewModel.fanSpeedIndexSelected = 0
                    viewModel.countTapped += 1
                }
                
                FanSpeedItemView(isConnect: $viewModel.isConnectedConditioner, type: .medium, selected: viewModel.fanSpeedIndexSelected == 1 ? true : false) {
                    viewModel.fanSpeedIndexSelected = 1
                    viewModel.countTapped += 1
                }
                
                FanSpeedItemView(isConnect: $viewModel.isConnectedConditioner, type: .high, selected: viewModel.fanSpeedIndexSelected == 2 ? true : false) {
                    viewModel.fanSpeedIndexSelected = 2
                    viewModel.countTapped += 1
                }
            }
            
        }
        .padding(.horizontal)
    }
    
    func otherView() -> some View {
        VStack(spacing: 8) {
            Text("Other".localizable)
                .foregroundStyle(.labelsSecondary.opacity(viewModel.isConnectedConditioner ? 0.3 : 0.2))
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 8)
            
            HStack {
                OtherButtonItemView(isConnect: $viewModel.isConnectedConditioner, type: .eco) {
                    viewModel.countTapped += 1
                    viewModel.ecoMode = viewModel.ecoMode == .on ? .off : .on
                }
                
                OtherButtonItemView(isConnect: $viewModel.isConnectedConditioner, type: .swing) {
                    viewModel.countTapped += 1
                    viewModel.swingType = viewModel.swingType == .horizontal ? .vertical : .horizontal
                }
                
                OtherButtonItemView(isConnect: $viewModel.isConnectedConditioner, type: .timer) {
                    viewModel.countTapped += 1
                    viewModel.showTimer.toggle()
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
}
