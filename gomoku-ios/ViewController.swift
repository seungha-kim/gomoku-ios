//
//  ViewController.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/17.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    lazy var gameView = GMKOfflineDualGameView()
    var round: GMKRound!

    override func viewDidLoad() {
        super.viewDidLoad()
        resetModel()
        setupViews()
    }
    
    func setupViews() {
        view = gameView
        gameView.boardView.delegate = self
        gameView.delegate = self
    }

    private func resetModel() {
        round = GMKRound(rule: GMKRoundRuleBasicImpl())
        round.delegate = self
    }
    
    private func resetView() {
        gameView.boardView.reset()
    }
}

extension ViewController: GMKBoardViewDelegate {
    func gomokuBoardReceivedMove(at pos: GMKCellPos) {
        round.tryMove(at: pos)
    }
}

extension ViewController: GMKRoundDelegate {
    func roundStarted() {
        resetView()
    }
    
    func roundFinished(with determination: GMKRoundWinnerDetermination) {
        print(determination)
    }
    
    func roundUpdated(with event: GMKRoundEvent) {
        switch event {
        case .cellFilled(pos: let pos, color: let color):
            gameView.boardView.updateCell(pos: pos, state: .filled(color: color))
        default:
            print("TODO: debug log")
        }
    }
}

extension ViewController: GMKOfflineDualGameViewDelegate {
    func gameViewReceivedStartAction() {
        resetModel()
        round.start()
    }
}
