import SwiftUI

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
                
                mainConditionerView()
                    .padding(.bottom, 20)
                
                temperatureView()
                    .padding(.bottom, 20)
                
                fanSpeed()
                    .padding(.bottom, 20)
                
                otherView()
                
                Spacer()
                  
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    func navigationTitleView() -> some View {
        HStack {
            
            ButtonImage(image: .settingsIcon, size: 40) {
                router.showSettings()
            }
            
            Spacer()
            
            Button {
                
            } label: {
                HStack {
                    Image(.connectIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20)
                    
                    Text("Connect")
                        .foregroundStyle(.white)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(
                    LinearGradient(colors: [.gradientBlueFirst, .gradientBlueSecond], startPoint: .leading, endPoint: .trailing)
                )
                .clipShape(Capsule())
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
                            
                            ButtonTemperatureView(type: .minus) {
                                
                            }
                            
                            Spacer()
                            
                            VStack {
                                Text("22")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 67, weight: .bold))
                                    .padding(.top, -10)
                                
                                Text("Celsius")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundStyle(.labelsSecondary.opacity(0.6))
                                    .padding(.top, -34)
                            }
                            
                            Spacer()
                            
                            ButtonTemperatureView(type: .plus) {
                                
                            }
                            
                            Spacer()
                        }
                        .padding(.top, 30)
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Image(.ecoSelectedIcon)
                            
                            Spacer()
                            
                            Image(.swingHorizontalSelectedIcon)
                            
                            Spacer()
                            
                            Image(.swingVerticalSelectedIcon)
                            
                            Spacer()
                            
                            Image(.timerSelectedIcon)
                            
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
            TemperatureItemView(type: .cool, selected: viewModel.temperatureIndexSelected == 0 ? true : false) {
                viewModel.temperatureIndexSelected = 0
            }
            
            TemperatureItemView(type: .heat, selected: viewModel.temperatureIndexSelected == 1 ? true : false) {
                viewModel.temperatureIndexSelected = 1
            }
        }
        .padding(.horizontal)
    }
    
    func fanSpeed() -> some View {
        VStack(spacing: 8) {
            Text("Fan Speed")
                .foregroundStyle(.labelsSecondary.opacity(0.3))
                .font(.system(size: 20, weight: .semibold))
            
            HStack {
                FanSpeedItemView(type: .low, selected: viewModel.fanSpeedIndexSelected == 0 ? true : false) {
                    viewModel.fanSpeedIndexSelected = 0
                }
                
                FanSpeedItemView(type: .medium, selected: viewModel.fanSpeedIndexSelected == 1 ? true : false) {
                    viewModel.fanSpeedIndexSelected = 1
                }
                
                FanSpeedItemView(type: .high, selected: viewModel.fanSpeedIndexSelected == 2 ? true : false) {
                    viewModel.fanSpeedIndexSelected = 2
                }
            }
            
        }
        .padding(.horizontal)
    }
    
    func otherView() -> some View {
        VStack(spacing: 8) {
            Text("Other")
                .foregroundStyle(.labelsSecondary.opacity(0.3))
                .font(.system(size: 20, weight: .semibold))
                .padding(.bottom, 8)
            
            HStack {
                OtherButtonItemView(type: .eco) {
                    
                }
                
                OtherButtonItemView(type: .swing) {
                    
                }
                
                OtherButtonItemView(type: .timer) {
                    
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    HomeView()
}
