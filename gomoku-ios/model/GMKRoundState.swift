//
//  GMKRoundState.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/17.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

enum GMKRoundState {
    case beforeStart
    case onGame(currentTurnColor: GMKPieceColor)
    case finished(determination: GMKRoundWinnerDetermination)
}
