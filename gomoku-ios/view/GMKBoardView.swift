//
//  GomokuBoard.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/17.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import UIKit
import SnapKit

class GMKBoardView: UIView, UIViewConfiguration {
    static let COL_COUNT: Int = 15
    static let ROW_COUNT: Int = 15
    static var COL_COUNT_F: CGFloat {
        get {
            CGFloat(COL_COUNT)
        }
    }
    static var ROW_COUNT_F: CGFloat {
        get {
            CGFloat(ROW_COUNT)
        }
    }
    
    var verticalLines = [CAShapeLayer]()
    var horizontalLines = [CAShapeLayer]()
    var pieceLayers = [GMKCellPos: CAShapeLayer]()
    weak var delegate: GMKBoardViewDelegate?
    
    var cellWidth: CGFloat {
        get {
            bounds.width / (Self.COL_COUNT_F + 1)
        }
    }
    
    var cellHeight: CGFloat {
        get {
            bounds.height / (Self.ROW_COUNT_F + 1)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAll()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAll()
    }
    
    func configureView() {
        backgroundColor = .brown
        initializeLines()
        initializePieces()
    }
    
    func configureConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        self.snp.makeConstraints { (make) in
            make.height.equalTo(self.snp.width)
        }
    }
    
    func configureActions() {
        let tapGestureRecognizer = UITapGestureRecognizer()
        addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(handleTap))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutLines()
        layoutPieces()
    }
    
    func updateCell(pos: GMKCellPos, state: GMKCellState) {
        let pieceLayer = pieceLayers[pos]
        if case .filled(color: let color) = state {
            switch color {
            case .black:
                pieceLayer?.fillColor = UIColor.black.cgColor
            case .white:
                pieceLayer?.fillColor = UIColor.white.cgColor
            }
        }
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let pos = getPos(from: sender.location(in: self))
        delegate?.gomokuBoardReceivedMove(at: GMKCellPos(row: pos.row, col: pos.col))
    }
    
    private func initializeLines() {
        for _ in 0..<Self.COL_COUNT {
            let lineLayer = CAShapeLayer()
            lineLayer.strokeColor = UIColor.red.cgColor
            layer.addSublayer(lineLayer)
            verticalLines.append(lineLayer)
        }
        for _ in 0..<Self.ROW_COUNT {
            let lineLayer = CAShapeLayer()
            lineLayer.strokeColor = UIColor.blue.cgColor
            layer.addSublayer(lineLayer)
            horizontalLines.append(lineLayer)
        }
    }
    
    private func initializePieces() {
        for row in 0..<Self.ROW_COUNT {
            for col in 0..<Self.COL_COUNT {
                let pieceLayer = CAShapeLayer()
                pieceLayer.fillColor = UIColor(white: 0, alpha: 0).cgColor
                layer.addSublayer(pieceLayer)
                
                pieceLayers[GMKCellPos(row: row, col: col)] = pieceLayer
            }
        }
    }
    
    private func layoutLines() {
        let cellWidth = self.cellWidth
        let cellHeight = self.cellHeight
        for (i, lineLayer) in verticalLines.enumerated() {
            let i = CGFloat(i)
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: cellWidth * (i + 1), y: cellHeight))
            linePath.addLine(to: CGPoint(x: cellWidth * (i + 1), y: cellHeight * Self.ROW_COUNT_F))
            lineLayer.path = linePath.cgPath
        }
        for (i, lineLayer) in horizontalLines.enumerated() {
            let i = CGFloat(i)
            let linePath = UIBezierPath()
            linePath.move(to: CGPoint(x: cellWidth, y: cellHeight * (i + 1)))
            linePath.addLine(to: CGPoint(x: cellWidth * Self.COL_COUNT_F, y: cellHeight * (i + 1)))
            lineLayer.path = linePath.cgPath
        }
    }
    
    private func layoutPieces() {
        let cellWidth = self.cellWidth
        let cellHeight = self.cellHeight
        let radius = min(cellWidth, cellHeight) * 0.8
        for row in 0..<Self.ROW_COUNT {
            for col in 0..<Self.COL_COUNT {
                let pieceLayer = pieceLayers[GMKCellPos(row: row, col: col)]!
                pieceLayer.path = UIBezierPath(ovalIn: CGRect(x: 0 - radius / 2, y: 0 - radius / 2, width: radius, height: radius)).cgPath
                pieceLayer.position = CGPoint(x: cellHeight * CGFloat(col + 1), y: cellWidth * CGFloat(row + 1))
                layer.addSublayer(pieceLayer)
                pieceLayers[GMKCellPos(row: row, col: col)] = pieceLayer
            }
        }
    }
    
    private func getPos(from point: CGPoint) -> GMKCellPos {
        let cellWidth = self.cellWidth
        let cellHeight = self.cellHeight
        let halfWidth = cellWidth / 2
        let halfHeight = cellHeight / 2
        var col = 0
        var row = 0
        for _ in 0..<(Self.COL_COUNT - 1) {
            let rightSideOfCell = halfWidth + cellWidth * CGFloat(col + 1)
            if point.x < rightSideOfCell {
                break
            }
            col += 1
        }
        for _ in 0..<(Self.ROW_COUNT - 1) {
            let bottomSideOfCell = halfHeight + cellHeight * CGFloat(row + 1)
            if point.y < bottomSideOfCell {
                break
            }
            row += 1
        }
        return GMKCellPos(row: row, col: col)
    }
}

protocol GMKBoardViewDelegate: class {
    func gomokuBoardReceivedMove(at pos: GMKCellPos)
}
