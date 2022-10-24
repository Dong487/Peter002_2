//
//  Color.swift
//  Peter002_2
//
//  Created by Dong on 2022/10/20.
//

import Foundation
import SwiftUI

extension Color {
    
    static let theme = ColorTheme()
}

struct ColorTheme{
    
    let background = Color(red: 245 / 255, green: 235 / 255, blue: 220 / 255)
    let textColor = Color(red: 44 / 255 , green: 44 / 255 ,blue: 44 / 255)
    let accentBrown = Color(red: 159 / 255, green: 111 / 255, blue: 51 / 255)
    let accentRed = Color(red: 156 / 255, green: 62 / 255, blue: 58 / 255)
}
