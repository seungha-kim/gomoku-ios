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
        let anyDetermined = GMKRoundWinnerDetermination.any([
            determineWinnerByHorizontalView(table: table),
            determineWinnerByVerticalView(table: table),
            // diagonal
            determineWinnerByUpperDiagonalView(table: table),
            determineWinnerByLowerDiagonalView(table: table),
            determineWinnerByMiddleDiagonalView(table: table),
            // anti-diagonal
            determineWinnerByUpperAntiDiagonalView(table: table),
            determineWinnerByLowerAntiDiagonalView(table: table),
            determineWinnerByMiddleAntiDiagonalView(table: table),
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
        for row in 0..<table.edgeLength {
            var walker = BasicWalker()
            for col in 0..<table.edgeLength {
                let cellState = table.getState(at: GMKCellPos(row: row, col: col))
                let determination = walker.checkCell(cellState: cellState)
                if determination.isFinal {
                    return determination
                }
            }
        }
        return .notYet
    }
    
    private func determineWinnerByVerticalView(table: GMKTable) -> GMKRoundWinnerDetermination {
        for col in 0..<table.edgeLength {
            var walker = BasicWalker()
            for row in 0..<table.edgeLength {
                let cellState = table.getState(at: GMKCellPos(row: row, col: col))
                let determination = walker.checkCell(cellState: cellState)
                if determination.isFinal {
                    return determination
                }
            }
        }
        return .notYet
    }
    
    // -***
    // --**
    // ---*
    // ----
    private func determineWinnerByUpperDiagonalView(table: GMKTable) -> GMKRoundWinnerDetermination {
        for lineLength in 1..<table.edgeLength {
            if lineLength < 5 {
                continue
            }
            var walker = BasicWalker()
            for i in 0..<lineLength {
                let row = i
                let col = table.edgeLength - lineLength + i
                let cellState = table.getState(at: GMKCellPos(row: row, col: col))
                let determination = walker.checkCell(cellState: cellState)
                if determination.isFinal {
                    return determination
                }
            }
        }
        return .notYet
    }
    
    // ----
    // *---
    // **--
    // ***-
    private func determineWinnerByLowerDiagonalView(table: GMKTable) -> GMKRoundWinnerDetermination {
        for lineLength in 1..<table.edgeLength {
            if lineLength < 5 {
                continue
            }
            var walker = BasicWalker()
            for i in 0..<lineLength {
                let row = table.edgeLength - 1 - i
                let col = lineLength - 1 - i
                let cellState = table.getState(at: GMKCellPos(row: row, col: col))
                let determination = walker.checkCell(cellState: cellState)
                if determination.isFinal {
                    return determination
                }
            }
        }
        return .notYet
    }
    
    // *---
    // -*--
    // --*-
    // ---*
    private func determineWinnerByMiddleDiagonalView(table: GMKTable) -> GMKRoundWinnerDetermination {
        var walker = BasicWalker()
        for i in 0..<table.edgeLength {
            let row = i
            let col = i
            let cellState = table.getState(at: GMKCellPos(row: row, col: col))
            let determination = walker.checkCell(cellState: cellState)
            if determination.isFinal {
                return determination
            }
        }
        return .notYet
    }
    
    // ***-
    // **--
    // *---
    // ----
    private func determineWinnerByUpperAntiDiagonalView(table: GMKTable) -> GMKRoundWinnerDetermination {
        for lineLength in 1..<table.edgeLength {
            if lineLength < 5 {
                continue
            }
            var walker = BasicWalker()
            for i in 0..<lineLength {
                let row = i
                let col = lineLength - 1 - i
                let cellState = table.getState(at: GMKCellPos(row: row, col: col))
                let determination = walker.checkCell(cellState: cellState)
                if determination.isFinal {
                    return determination
                }
            }
        }
        return .notYet
    }
    
    // ----
    // ---*
    // --**
    // -***
    private func determineWinnerByLowerAntiDiagonalView(table: GMKTable) -> GMKRoundWinnerDetermination {
        for lineLength in 1..<table.edgeLength {
            if lineLength < 5 {
                continue
            }
            var walker = BasicWalker()
            for i in 0..<lineLength {
                let row = table.edgeLength - 1 - i
                let col = table.edgeLength - lineLength + i
                let cellState = table.getState(at: GMKCellPos(row: row, col: col))
                let determination = walker.checkCell(cellState: cellState)
                if determination.isFinal {
                    return determination
                }
            }
        }
        return .notYet
    }
    
    // ---*
    // --*-
    // -*--
    // *---
    private func determineWinnerByMiddleAntiDiagonalView(table: GMKTable) -> GMKRoundWinnerDetermination {
        let edgeLength = table.edgeLength
        var walker = BasicWalker()
        for i in 0..<table.edgeLength {
            let row = edgeLength - 1 - i
            let col = i
            let cellState = table.getState(at: GMKCellPos(row: row, col: col))
            let determination = walker.checkCell(cellState: cellState)
            if determination.isFinal {
                return determination
            }
        }
        return .notYet
    }
}
