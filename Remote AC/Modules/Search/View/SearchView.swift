import SwiftUI
import PopupView

struct SearchView: View {
    
    @EnvironmentObject var router: AppRouter
    @ObservedObject private var viewModel = SearchViewModel()
   
    var body: some View {
        ZStack {
            Color.bgMain
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    ButtonImage(image: .settingsBackIcon, size: 40) {
                        router.pop()
                    }
                    
                    Spacer()
                    
                    ButtonImage(image: .infoIcon, size: 40) {
                        viewModel.showInfo.toggle()
                    }
                }
                .overlay {
                    Text("Affordable air conditioners".localizable)
                        .foregroundStyle(.black)
                        .font(.system(size: 17, weight: .semibold))
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 45)
                }
                .padding(.horizontal)
                
                if !viewModel.showLoading {
                    if viewModel.selectedItem != nil {
                        ScrollView {
                            Text("Connected".localizable)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.labelsSecondary.opacity(0.3))
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 8)
                            
                            SearchItemView(item: viewModel.selectedItem ?? .init(name: "Wrong")) {}
                            
                            Text("Found devices".localizable)
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.labelsSecondary.opacity(0.3))
                                .multilineTextAlignment(.center)
                                .padding(.top, 24)
                                .padding(.bottom, 8)
                            
                            VStack {
                                ForEach(viewModel.editingModel) { model in
                                    SearchItemView(item: model) {
                                        if model.name == viewModel.wifiName {
                                            var selectedModel = model
                                            selectedModel.selected = true
                                            viewModel.selectedItem = selectedModel
                                        } else {
                                            viewModel.showError = true
                                        }
                                    }
                                }
                            }
                            
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    } else {
                        ScrollView {
                            VStack {
                                ForEach(viewModel.model) { model in
                                    SearchItemView(item: model) {
                                        if model.name == viewModel.wifiName {
                                            var selectedModel = model
                                            selectedModel.selected = true
                                            viewModel.selectedItem = selectedModel
                                        } else {
                                            viewModel.errorModelIndex = Int.random(in: 0..<ErrorsSheetModel.defaultModel.count)
                                            viewModel.showError = true
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        }
                    }
                    
                    Spacer()
                    
                    GradientButton(text: "Repeat search".localizable, size: 50) {
                        viewModel.retrySearch()
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                } else {
                    
                    Spacer()
                    
                    Image(.splashIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 163, height: 163)
                    
                    Spacer()
                    
                    Text("\(viewModel.currentTime)%")
                        .foregroundStyle(.black)
                        .font(.system(size: 28, weight: .bold))
                    
                    Text("Device Search...".localizable)
                        .foregroundStyle(.labelsSecondary.opacity(0.6))
                        .font(.system(size: 17, weight: .regular))
                        .padding(.top, -8)
                        .padding(.bottom)
                }
            }
            
            if viewModel.showInfo || viewModel.showError {
                Color.bgSheet.opacity(0.3)
                    .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.searchItems()
            viewModel.closeSearch = {
                router.pop()
            }
        }
        .popup(isPresented: $viewModel.showInfo) {
            InstructionView()
        } customize: {
            $0
                .type(.toast)
                .displayMode(.sheet)
        }
        .popup(isPresented: $viewModel.showError) {
            ErrorsSheetView(model: viewModel.errorModel)
        } customize: {
            $0
                .type(.toast)
                .displayMode(.sheet)
        }
    }
}

#Preview {
    SearchView()
}
