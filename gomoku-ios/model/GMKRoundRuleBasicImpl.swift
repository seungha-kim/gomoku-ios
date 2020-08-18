//
//  GMKRoundRuleBasicImpl.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/19.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

class GMKRoundRuleBasicImpl: GMKRoundRule {
    private enum InterimResult {
        case notFound
        case straight(color: GMKPieceColor, count: Int)
    }
    
    func determineWinner(table: GMKTable) -> GMKRoundWinnerDetermination {
        return determinWinnerAtHorizontalView(table: table)
        // TODO: 다른 방향 로직
    }
    
    private func determinWinnerAtHorizontalView(table: GMKTable) -> GMKRoundWinnerDetermination {
        var interimResult: InterimResult = .notFound
        var filledCount = 0
        for row in 0..<table.rowCount {
            for col in 0..<table.colCount {
                let cellState = table.getState(at: GMKCellPos(row: row, col: col))
                switch (interimResult, cellState) {
                case (.notFound, .filled(color: let color)):
                    filledCount += 1
                    interimResult = .straight(color: color, count: 1)
                case (.straight(color: let prevColor, count: let count), .filled(color: let nextColor)):
                    filledCount += 1
                    if prevColor == nextColor {
                        interimResult = .straight(color: nextColor, count: count + 1)
                    } else {
                        interimResult = .straight(color: nextColor, count: 1)
                    }
                case (_, .empty):
                    interimResult = .notFound
                }
                
                if case .straight(color: let color, count: let count) = interimResult, count >= 5 {
                    return .determined(color: color)
                }
            }
        }
        
        if filledCount < table.rowCount * table.colCount {
            return .notYet
        } else {
            return .draw
        }
    }
}
