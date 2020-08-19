//
//  GMKRoundRuleBasicImpl.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/19.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

private enum InterimResult {
    case notFound
    case straight(color: GMKPieceColor, count: Int)
}

private struct BasicWalker {
    var interimResult: InterimResult = .notFound
    mutating func checkCell(cellState: GMKCellState) -> GMKRoundWinnerDetermination {
        switch (interimResult, cellState) {
        case (.notFound, .filled(color: let color)):
            interimResult = .straight(color: color, count: 1)
        case (.straight(color: let prevColor, count: let count), .filled(color: let nextColor)):
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
        } else {
            return .notYet
        }
    }
}

class GMKRoundRuleBasicImpl: GMKRoundRule {
    func determineWinner(table: GMKTable) -> GMKRoundWinnerDetermination {
        // TODO: 대각선 로직
        let anyDetermined = GMKRoundWinnerDetermination.any([
            determineWinnerByHorizontalView(table: table),
            determienWinnerByVerticalView(table: table)
        ])
        
        if anyDetermined.isFinal {
            return anyDetermined
        } else if table.filledCellCount < table.cellCount {
            return .notYet
        } else {
            return .draw
        }
    }
    
    private func determineWinnerByHorizontalView(table: GMKTable) -> GMKRoundWinnerDetermination {
        for row in 0..<table.rowCount {
            var walker = BasicWalker()
            for col in 0..<table.colCount {
                let cellState = table.getState(at: GMKCellPos(row: row, col: col))
                let determination = walker.checkCell(cellState: cellState)
                if determination.isFinal {
                    return determination
                }
            }
        }
        return .notYet
    }
    
    private func determienWinnerByVerticalView(table: GMKTable) -> GMKRoundWinnerDetermination {
        for col in 0..<table.colCount {
            var walker = BasicWalker()
            for row in 0..<table.rowCount {
                let cellState = table.getState(at: GMKCellPos(row: row, col: col))
                let determination = walker.checkCell(cellState: cellState)
                if determination.isFinal {
                    return determination
                }
            }
        }
        return .notYet
    }
}
