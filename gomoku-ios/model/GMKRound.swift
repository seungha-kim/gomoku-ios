//
//  GMKGame.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/17.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

class GMKRound {
    static let EDGE_LENGTH: Int = 15
    
    weak var delegate: GMKRoundDelegate?
    
    private var table: GMKTable
    private var currentTurnColor: GMKPieceColor = .black
    private let rule: GMKRoundRule
    
    init(rule: GMKRoundRule) {
        self.rule = rule
        table = GMKTable(edgeLength: Self.EDGE_LENGTH)
    }
    
    func tryMove(at pos: GMKCellPos) {
        let cellState = table.getState(at: pos)
        guard cellState.isEmpty else { return }
        
        table.setState(at: pos, state: .filled(color: currentTurnColor))
        delegate?.roundUpdated(with: .cellFilled(pos: pos, color: currentTurnColor))
        currentTurnColor.toggle()
        print(rule.determineWinner(table: table))
    }
}

protocol GMKRoundDelegate: class {
    func roundUpdated(with event: GMKRoundEvent)
}
