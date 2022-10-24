//
//  CustomButtonBG.swift
//  Peter002_2
//
//  Created by Dong on 2022/10/23.
//

import SwiftUI

struct CustomButtonBG: View {
    
    var iconColor: Color = .yellow
    var textColor: Color = Color.white
    var iconName: String = "checkmark.circle"
    var text: String = "確認"
    
    var body: some View {
        
        Text(text)
            .font(.callout.bold())
            .foregroundColor(textColor)
            .kerning(2.0)
            .minimumScaleFactor(0.4) 
            .padding(.leading ,30)
            .frame(width: 110, height: 32)
            .background {
                Capsule()
                    .fill(iconColor.opacity(0.65))
                    .frame(width: 110, height: 32)
                    .overlay(alignment: .leading){
                        Image(systemName: iconName)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 36 ,height: 37)
                            .shadow(color: .black.opacity(0.26), radius: 0.6, x: 0.6, y: 0.6)
                            .shadow(color: .black.opacity(0.16), radius: 1, x: 0.8, y: 0.8)
                            .background {
                                iconColor.clipShape(Circle())
                            }
                    }
                    .shadow(color: iconColor.opacity(0.85), radius: 0.6, x: 0.2, y: 0.6)
                    .shadow(color: iconColor.opacity(0.85), radius: 1, x: 0.2, y: 1)
                    .shadow(color: .black.opacity(0.66), radius: 0.6, x: 0.6, y: 0.6)
            }
    }
}

struct CustomButtonBG_Previews: PreviewProvider {
    static var previews: some View {
        CustomButtonBG()
    }
}
