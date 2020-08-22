//
//  gomoku_iosTests.swift
//  gomoku-iosTests
//
//  Created by Kim Seungha on 2020/08/23.
//  Copyright © 2020 Kim Seungha. All rights reserved.
//

import XCTest

@testable import gomoku_ios

class gomoku_iosTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWin() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let moves: [(Int, Int)] = [
            (0, 0),
            (0, 1),
            (1, 1),
            (1, 2),
            (2, 2),
            (2, 3),
            (3, 3),
            (3, 4),
            (4, 4),
        ]
        let round = GMKRound(rule: GMKRoundRuleBasicImpl())
        round.start()
        for (row, col) in moves {
            round.tryMove(at: GMKCellPos(row: row, col: col))
        }
        if round.filledCellCount == 9,
            case .finished(determination: let determination) = round.state,
            case .determined(color: .black) = determination {
            // success
        } else {
            XCTFail("Round should finish with black winner")
        }
    }
}
