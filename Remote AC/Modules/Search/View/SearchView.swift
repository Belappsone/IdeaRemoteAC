import SwiftUI
import PopupView

struct SearchView: View {
    
    @ObservedObject private var viewModel = SearchViewModel()
   
    var body: some View {
        ZStack {
            Color.bgMain
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    ButtonImage(image: .settingsBackIcon, size: 40) {
                        
                    }
                    
                    Spacer()
                    
                    ButtonImage(image: .infoIcon, size: 40) {
                        viewModel.showInfo.toggle()
                    }
                }
                .overlay {
                    Text("Affordable air conditioners")
                        .foregroundStyle(.black)
                        .font(.system(size: 17, weight: .semibold))
                        .minimumScaleFactor(0.5)
                        .padding(.horizontal, 45)
                }
                .padding(.horizontal)
                
                if !viewModel.showLoading {
                    if viewModel.selectedItem != nil {
                        ScrollView {
                            Text("Connected")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.labelsSecondary.opacity(0.3))
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 8)
                            
                            SearchItemView(item: viewModel.selectedItem ?? .init(name: "Wrong")) {}
                            
                            Text("Found devices")
                                .font(.system(size: 15, weight: .semibold))
                                .foregroundStyle(.labelsSecondary.opacity(0.3))
                                .multilineTextAlignment(.center)
                                .padding(.top, 24)
                                .padding(.bottom, 8)
                            
                            VStack {
                                ForEach(viewModel.editingModel) { model in
                                    SearchItemView(item: model) {
                                        var selectedModel = model
                                        selectedModel.selected = true
                                        viewModel.selectedItem = selectedModel
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
                                        var selectedModel = model
                                        selectedModel.selected = true
                                        viewModel.selectedItem = selectedModel
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top)
                        }
                    }
                    
                    Spacer()
                    
                    GradientButton(text: "Repeat search", size: 50) {
                        viewModel.showLoading = true
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    
                } else {
                    
                    Spacer()
                    
                    RoundedRectangle(cornerRadius: 0)
                        .frame(width: 163, height: 163)
                    
                    Spacer()
                    
                    Text("50%")
                        .foregroundStyle(.black)
                        .font(.system(size: 28, weight: .bold))
                    
                    Text("Device Search...")
                        .foregroundStyle(.labelsSecondary.opacity(0.6))
                        .font(.system(size: 17, weight: .regular))
                        .padding(.top, -8)
                        .padding(.bottom)
                }
            }
            
            if viewModel.showInfo {
                Color.bgSheet.opacity(0.3)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            viewModel.searchItems()
        }
        .popup(isPresented: $viewModel.showInfo) {
            InstructionView()
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
