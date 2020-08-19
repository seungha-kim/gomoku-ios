//
//  GMKTable.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/19.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

class GMKTable {
    let rowCount: Int
    let colCount: Int
    var filledCellCount = 0
    var cellCount: Int {
        get {
            rowCount * colCount
        }
    }
    private var table: [[GMKCellState]]
    
    init(rowCount: Int, colCount: Int) {
        self.rowCount = rowCount
        self.colCount = colCount
        table = Array(repeating: Array(repeating: .empty, count: colCount), count: rowCount)
    }
    
    func getState(at pos: GMKCellPos) -> GMKCellState {
        return table[pos.row][pos.col]
    }
    
    func setState(at pos: GMKCellPos, state: GMKCellState) {
        // TODO: 무르기
        guard getState(at: pos).isEmpty else { return }
        table[pos.row][pos.col] = state
        if case .filled(_) = state {
            filledCellCount += 1
        }
    }
}
