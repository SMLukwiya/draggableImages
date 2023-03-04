//
//  ImageModel.swift
//  GraggableImage
//
//  Created by m1 on 04/03/2023.
//

import Foundation
import  SwiftUI

struct ImageModel: Identifiable {
    let id = UUID()
    let name: String
    let color: Color
    let zIndex: Double
    
    init(name: String, color: Color, zIndex: Double) {
        self.name = name
        self.color = color
        self.zIndex = zIndex
    }
    
    init(name: String, color: Color) {
        self.name = name
        self.color = color
        self.zIndex = 0
    }
    
    init(name: String) {
        let colors:  [Color] = [.indigo, .blue, .green, .cyan, .yellow, .black, .gray, .purple  ]
        self.name = name
        self.color = colors.randomElement() ?? .indigo
        self.zIndex = 0
    }
}
