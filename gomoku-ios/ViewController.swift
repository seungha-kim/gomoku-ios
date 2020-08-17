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
    lazy var myTestView = MyTestView()
    lazy var boardView = GMKBoardView()

    var round = GMKRound()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        round.delegate = self
        setupViews()
    }
    
    func setupViews() {
        boardView.delegate = self
        view.addSubview(boardView)
        boardView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.equalTo(self.view.safeAreaLayoutGuide)
            make.right.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension ViewController: GMKBoardViewDelegate {
    func gomokuBoardReceivedMove(at pos: GMKCellPos) {
        round.tryMove(at: pos)
    }
}

extension ViewController: GMKRoundDelegate {
    func roundUpdated(with event: GMKRoundEvent) {
        switch event {
        case .cellFilled(pos: let pos, color: let color):
            boardView.updateCell(pos: pos, state: .filled(color: color))
        default:
            print("TODO: debug log")
        }
    }
}
