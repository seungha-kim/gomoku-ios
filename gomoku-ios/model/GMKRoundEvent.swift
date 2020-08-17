//
//  GMKGameRoundProgressEvent.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/17.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

enum GMKRoundEvent {
    case cellFilled(pos: GMKCellPos, color: GMKPieceColor)
    case roundFinished(winner: GMKPieceColor?) // 무승부 가능
}
