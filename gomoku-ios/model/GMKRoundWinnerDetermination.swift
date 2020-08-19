//
//  GMKRoundWinnerDetermination.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/19.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

enum GMKRoundWinnerDetermination {
    case notYet
    case determined(color: GMKPieceColor)
    case draw
    
    var isFinal: Bool {
        get {
            switch self {
            case .notYet:
                return false
            case .determined(color: _), .draw:
                return true
            }
        }
    }
    
    private func or(other: Self) -> Self {
        if self.isFinal {
            return self
        } else {
            return other
        }
    }
    
    static func any(_ partialDeterminations: [Self]) -> Self {
        var result: Self = .notYet
        for d in partialDeterminations {
            result = result.or(other: d)
        }
        return result
    }
}
