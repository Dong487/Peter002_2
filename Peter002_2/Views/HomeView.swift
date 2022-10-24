//
//  HomeView.swift
//  Peter002_1
//
//  Created by Dong on 2022/10/20.
//

import SwiftUI
import Sliders

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    init(){
        // 自定義 Picker 顏色 (被選定時 、 未選定時)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.accentBrown.opacity(0.55)) // 選項 背景色 (選定時)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color(.gray).opacity(0.35)) // 選項背景色 (沒被選)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor(Color.white)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected) // 選定時字體顏色
        
        let attributes2: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor(Color.theme.textColor)
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes2, for: .normal) // 沒被選定時 字體顏色
        
    }
    
    var body: some View {
        ZStack {
            Color.theme.background.ignoresSafeArea()
            
            VStack(spacing: 16){
                
                titleView
                
                orderView
                
                buttonView
                
                // 漢堡圖片 + 店員
                burgerView
                    .background(
                        manImageView
                    )
                
            } // Vstack (尾)
            .padding(.horizontal)
            .frame(width: getRect().width, height: getRect().height)
            .foregroundColor(Color.theme.textColor)
            
        } // ZStack (尾)
        .frame(width: getRect().width, height: getRect().height)
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView {
    
    private var titleView: some View{
        HStack{
            Image("BURGERS")
                .resizable()
                .scaledToFit()
                .frame(height: 60)
            
            Text("BURGERS")
                .font(.largeTitle.bold())
                .foregroundColor(.red)
                .shadow(color: .white.opacity(0.85), radius: 0.5, x: -1.2, y: -1)
                .shadow(color: .black.opacity(0.75), radius: 0.7, x: 1, y: 1)
                .shadow(color: .black.opacity(0.55), radius: 1, x: 1, y: 1)
            
            Image("BURGERS")
                .resizable()
                .scaledToFit()
                .frame(height: 60)
        }
        .frame(width: 350 ,height: 50)
    }
    
    private var orderView: some View{
        VStack{
            HStack(spacing: 20){
                
                Text("訂購人 :")
                
                TextField("", text: $viewModel.name, prompt: Text("請輸入你的名字").foregroundColor(.gray)) // prompt 可自訂 題示字和顏色
                    .padding(.horizontal)
                    .background(.white.opacity(0.65))
                    .frame(width: 180)
                
                
                
                Image(systemName: viewModel.name.count >= 2 ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .font(.headline)
                    .foregroundColor(viewModel.name.count >= 2 ? .green : .red)
                
                Spacer()
            }
            .frame(height: 30)
            
            
            HStack(spacing: 20){
                
                Text("肉品")
                
                Picker(selection: $viewModel.selectedMeat) {
                    ForEach(viewModel.meats.indices ,id: \.self){ index in
                        Text(viewModel.meats[index])
                            .tag(viewModel.meats[index])
                    }
                } label: {
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer()
            }
            
            HStack(spacing: 20){
                Text("蔬菜")
                
                Picker(selection: $viewModel.selectedVegetable) {
                    ForEach(viewModel.vegetables.indices ,id: \.self) { index in
                        Text(viewModel.vegetables[index])
                        //                            .foregroundColor(.white)
                        //                            .background(.green.opacity(0.75))
                            .tag(viewModel.vegetables[index])
                    }
                } label: {
                    // 可省略 (不會顯示)
                }
                .tint(.white)
                .pickerStyle(MenuPickerStyle())
                .background(.green.opacity(0.75))
                .cornerRadius(8)
                
                Spacer()
            }
            
            .frame(height: 40)
            
            HStack(spacing: 50){
                Toggle(isOn: $viewModel.pepper, label: {
                    Text("胡椒")
                })
                .frame(width: 100)
                
                Toggle(isOn: $viewModel.eggs, label: {
                    Text("加蛋")
                })
                .frame(width: 100)
                
                Spacer()
            }
            .frame(height: 40)
            .toggleStyle(SwitchToggleStyle(tint: Color(#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))))
            
            HStack{
                Text("Size")
                
                Text("(小)")
                    .font(.caption)
                
                ValueSlider(value: $viewModel.size, in: -2...2, step: 1)
                    .valueSliderStyle(
                        HorizontalValueSliderStyle(
                            track:
                                HorizontalValueTrack(view: Capsule().foregroundColor(.yellow)
                                                    )
                                .background(Capsule().foregroundColor(.green.opacity(0.25)))
                                .frame(height: 15),
                            thumb: Image("burger").resizable(),
                            thumbSize: CGSize(width: 50, height: 50)
                        )
                        
                    )
                    .frame(width: 220 ,height: 50) // 不給 會跑版
                
                Text("(大)")
                
                Spacer()
                
            }
        }
        .disabled(viewModel.showScaleEffect ? true : false)
    }
    
    private var buttonView: some View {
        HStack{
            Button {
                guard !viewModel.showScaleEffect else {
                    viewModel.reset()
                    return
                }
                viewModel.makeBurgers()
            } label: {
                CustomButtonBG(
                    iconColor: viewModel.name.count < 2 ? .gray : viewModel.showScaleEffect ? .pink.opacity(0.76) : .purple.opacity(0.66),
                    textColor: Color.white,
                    iconName: viewModel.buttonText == "確認" ? "checkmark.circle" : "arrow.uturn.left.circle",
                    text: viewModel.buttonText)
                
            }
            .disabled(viewModel.name.count >= 2 ? false : true)
            
            Spacer()
        }
    }
    
    private var burgerView: some View{
        VStack(spacing: -95){
            ForEach(viewModel.imageName.indices ,id: \.self){ index in
                Image(viewModel.imageName[index])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220)
                    .offset(y: viewModel.sequence[index] ? 0 : -getRect().height) // 落下位移
                    .offset(y: index == 0 ? 15 : 0 ) // 微調
                    .offset(y: viewModel.imageName[index] == "bunBottom" ? -15 : 0 ) // 微調
                    .animation(.spring(
                        response: 0.2,
                        dampingFraction: 0.8,
                        blendDuration: 0.1),
                               value: viewModel.sequence[index])
                    .zIndex(-Double(index)) // 越慢落下蓋在越上面
            }
            
        }
        
        .frame(height: 300)
        .scaleEffect(viewModel.showScaleEffect ? 1 + viewModel.size * 0.1 : 1)
        .overlay{
            Image("pepper")
                .resizable()
                .scaledToFit()
                .frame(width: 130)
                .opacity(viewModel.pepper && viewModel.pepperAnimation ? 1 : 0)
                .rotationEffect(Angle(degrees: 235))
                .offset(x: 95,y: -75) // 調整位置
                .offset(x: viewModel.pepper && viewModel.pepperAnimation ? 0 : 35 ,
                        y: viewModel.pepper && viewModel.pepperAnimation ? 0 : -35) // 灑胡椒動畫位移
        }
    }
    
    private var manImageView: some View{
        Image("man")
            .resizable()
            .scaledToFit()
            .frame(height: viewModel.manScaleEffect ? 100 : 300)
            .overlay(alignment: .topLeading){
                Text(!viewModel.manScaleEffect ? "歡迎光臨" : viewModel.showScaleEffect && viewModel.manScaleEffect ? "\(viewModel.name) , 您的餐點好瞜" : "餐點製作中...")
                    .foregroundColor(.white)
                    .padding(.vertical ,6)
                    .padding(.horizontal)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.theme.accentRed.opacity(0.35))
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.white)
                                    .shadow(color: Color.theme.accentRed, radius: 0.6, x: -0.4, y: -0.4)
                            )
                    )
                    .shadow(color: Color.theme.textColor.opacity(0.6), radius: 1, x: 1, y: 1)
                    .shadow(color: Color.theme.textColor.opacity(0.6), radius: 1, x: 1.2, y: 1/2)
                    .frame(width: 150)
                    .offset(x: viewModel.manScaleEffect ?  -140 : -90)
                
            }
            .offset(x: viewModel.manScaleEffect ? 150 : 0)
            .offset(y: viewModel.manScaleEffect ? -150 : 0)
    }
}



extension View{
    
    func getRect() -> CGRect{
        UIScreen.main.bounds
    }
}
