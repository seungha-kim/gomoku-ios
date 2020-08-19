//
//  GMKTable.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/19.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

class GMKTable {
    let edgeLength: Int
    var filledCellCount = 0
    var cellCount: Int {
        get {
            edgeLength * edgeLength
        }
    }
    
    private var table: [[GMKCellState]]
    
    init(edgeLength: Int) {
        self.edgeLength = edgeLength
        table = Array(repeating: Array(repeating: .empty, count: edgeLength), count: edgeLength)
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
