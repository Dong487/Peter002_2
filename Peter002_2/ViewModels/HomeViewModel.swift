//
//  HomeViewModel.swift
//  Peter002_2
//
//  Created by Dong on 2022/10/20.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject{
    // Name
    @Published var name: String = ""
    
    // 肉 (預設beef)
    @Published var selectedMeat = "beef"{
        willSet{
            changeSelected(from: selectedMeat, to: newValue)
        }
    }
    let meats: [String] = [
        "beef" , "fish" , "chicken" , "bacon"
    ]
    
    // 菜 (預設 lettuce)
    @Published var selectedVegetable : String = "lettuce"{
        willSet{
            changeSelected(from: selectedVegetable, to: newValue)
        }
    }
    let vegetables: [String] = [
        "lettuce" , "beefTomato" , "cabbage"
    ]

    //  (數量要跟 imageName.count 的初始數量一樣 也可以改init給值 )
    @Published var sequence: [Bool] = Array(repeating: false, count: 4)

    // 排序 [上 -> 下]
    @Published var imageName: [String] = [ "bunTop" , "lettuce" , "beef" , "bunBottom"]{
        willSet{
            guard imageName.count != newValue.count else { return }
            sequence = Array(repeating: false, count: newValue.count) // if (+ -) 蛋
        } 
    }
    
    @Published var pepper: Bool = false
    @Published var pepperAnimation: Bool = false
    @Published var eggs: Bool = true
    
    @Published var size: Double = 0.0
    
    // 漢堡的縮放 (也可以當作 整個流程完成的判斷)
    @Published var showScaleEffect: Bool = false
    @Published var manScaleEffect: Bool = false
    
    @Published var buttonText: String = "確認"
    
    
    
    func changeSelected(from old: String ,to new: String){
        if let index = imageName.firstIndex(of: old){
            imageName[index] = new
        }
        print("OLD: \(old)")
        print("New: \(new)")
    }
    
    func makeBurgers(){
        buttonText = "重置"
        withAnimation(.easeInOut){
            manScaleEffect = true
        }
        if eggs {
            imageName.insert("eggs", at: 1)
        }
        let totalTime = Double(sequence.count) * 0.2
        
        // 落下順序
        for index in sequence.indices{
            if pepper &&  index == 0{
                DispatchQueue.main.asyncAfter(deadline: .now() + totalTime ){
                    withAnimation(.easeInOut(duration: 0.26).repeatCount(3)){
                        self.pepperAnimation = true
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + totalTime + 2){
                    self.sequence[index] = true
                }
                continue
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + (totalTime - 0.2 * Double(index))){
                self.sequence[index] = true
            }

        }
      
        // 縮放動畫 (delay時間根據 有沒有胡椒而有差異)
        if pepper {
            scaleEffectAnimation(delayTime: totalTime + 3)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2){
                SoundManager.instance.playSound(seconds: 1)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8){
                withAnimation(.easeOut){
                    self.pepperAnimation = false
                    
                }
            }
        } else {
            scaleEffectAnimation(delayTime: totalTime + 1)
        }
    }
     
    func scaleEffectAnimation(delayTime: Double){
        withAnimation(.spring(  response: 1,
                                dampingFraction: 0.8,
                                blendDuration: 1.0).delay(delayTime)){
            showScaleEffect = true
        }
    }
    
    func reset(){
        name = ""
        buttonText = "確認"
        selectedMeat = "beef"
        selectedVegetable = "lettuce"
        pepper = false
        pepperAnimation = false
        size = 0.0
        imageName = [ "bunTop" , "lettuce" , "beef" , "bunBottom" ]
        sequence = Array(repeating: false, count: 4)
        showScaleEffect = false
        manScaleEffect = false
    }
}
