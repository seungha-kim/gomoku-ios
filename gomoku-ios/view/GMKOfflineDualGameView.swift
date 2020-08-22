//
//  GMKOfflineDualGameView.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/20.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import UIKit
import SnapKit

class GMKOfflineDualGameView: UIView, UIViewConfiguration {
    var boardView = GMKBoardView()
    weak var delegate: GMKOfflineDualGameViewDelegate?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var boardSlot: UIView!
    @IBOutlet weak var startButton: UIButton!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAll()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAll()
    }
    
    func configureView() {
        Bundle.main.loadNibNamed("GMKOfflineDualGameView", owner: self, options: nil)
        addSubview(contentView)
        boardSlot.addSubview(boardView)
    }
    
    func configureConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
        boardView.snp.makeConstraints { (make) in
            make.edges.equalTo(boardSlot)
        }
    }
    
    func configureActions() {
        startButton.addTarget(self, action: #selector(handleStart), for: .touchUpInside)
    }
    
    @objc private func handleStart() {
        delegate?.gameViewReceivedStartAction()
    }
}

protocol GMKOfflineDualGameViewDelegate: class {
    func gameViewReceivedStartAction()
}
