//
//  GMKRoundRule.swift
//  gomoku-ios
//
//  Created by Kim Seungha on 2020/08/19.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import Foundation

protocol GMKRoundRule {
    func determineWinner(table: GMKTable) -> GMKRoundWinnerDetermination
}
