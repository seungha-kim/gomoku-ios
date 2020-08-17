//
//  GMKPieceColor.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/17.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

enum GMKPieceColor {
    case black
    case white
    
    var opposite: Self {
        get {
            switch self {
            case .black:
                return .white
            case .white:
                return .black
            }
        }
    }
    
    mutating func toggle() {
        self = self.opposite
    }
}

