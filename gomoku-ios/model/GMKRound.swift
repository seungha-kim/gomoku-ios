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
    
    var state: GMKRoundState = .beforeStart
    private var table: GMKTable
    private let rule: GMKRoundRule
    var filledCellCount: Int {
        get {
            table.filledCellCount
        }
    }
    init(rule: GMKRoundRule) {
        self.rule = rule
        table = GMKTable(edgeLength: Self.EDGE_LENGTH)
    }
    
    func start() {
        state = .onGame(currentTurnColor: .black)
        delegate?.roundStarted()
    }
    
    func tryMove(at pos: GMKCellPos) {
        guard case .onGame(currentTurnColor: let currentTurnColor) = state else { return }
        let cellState = table.getState(at: pos)
        guard cellState.isEmpty else { return }
        table.setState(at: pos, state: .filled(color: currentTurnColor))
        delegate?.roundUpdated(with: .cellFilled(pos: pos, color: currentTurnColor))
        let determination = rule.determineWinner(table: table)
        if determination.isFinal {
            delegate?.roundFinished(with: determination)
            state = .finished(determination: determination)
        } else {
            state = .onGame(currentTurnColor: currentTurnColor.opposite)
        }
    }
}

protocol GMKRoundDelegate: class {
    func roundStarted()
    func roundUpdated(with event: GMKRoundEvent)
    func roundFinished(with determination: GMKRoundWinnerDetermination)
}
