//
//  SoundManager.swift
//  Peter002_2
//
//  Created by Dong on 2022/10/22.
//

import Foundation
import SwiftUI
import AVKit

// 灑胡椒聲音
class SoundManager {
     
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    // 持續時間
    func playSound(seconds: Double){
        
        guard let url = Bundle.main.url(forResource: "sound1", withExtension: ".mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds){
                self.player?.stop()
            }
            
            
        } catch let error{
            print("播放聲音 發生錯誤: \(error.localizedDescription)")
        }
    }
}
