//
//  GMKRoundWinnerDetermination.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/19.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

enum GMKRoundWinnerDetermination {
    case notYet
    case determined(color: GMKPieceColor)
    case draw
}
