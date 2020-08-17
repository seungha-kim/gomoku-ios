//
//  GMKGame.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/17.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

class GMKRound {
    static let COL_COUNT: Int = 15
    static let ROW_COUNT: Int = 15
    
    weak var delegate: GMKRoundDelegate?
    
    private var table: [[GMKCellState]]
    private var currentPieceColor: GMKPieceColor = .black
    
    init() {
        table = Array(repeating: Array(repeating: .empty, count: Self.COL_COUNT), count: Self.ROW_COUNT)
    }
    
    func tryMove(at pos: GMKCellPos) {
        guard table[pos.row][pos.col] == .empty else { return }
        
        table[pos.row][pos.col] = .filled(color: currentPieceColor)
        delegate?.roundUpdated(with: .cellFilled(pos: pos, color: currentPieceColor))
        currentPieceColor.toggle()
    }
}

protocol GMKRoundDelegate: class {
    func roundUpdated(with event: GMKRoundEvent)
}
