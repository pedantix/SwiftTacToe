//
//  GameModelTests.swift
//  SwiftTacToeTests
//
//  Created by shaun on 10/10/21.
//


import XCTest
@testable import SwiftTacToe

class GameModelTests: XCTestCase {
    private var gameModel: GameModel!

    override func setUpWithError() throws {
        gameModel = .init()
    }

    func testMakeMoveToVictory_HorizontalTop() {
        // Set 1
        XCTAssertEqual(gameModel.gameTurn, .player1)
        XCTAssertEqual(gameModel.gameState, .readyToStart)
        gameModel.makeMove(.topLeft)
        XCTAssertEqual(gameModel.gameTurn, .player2)
        XCTAssertEqual(gameModel.gameState, .inPlay)
        gameModel.makeMove(.middleLeft)

        // Set 2
        XCTAssertEqual(gameModel.gameTurn, .player1)
        XCTAssertEqual(gameModel.gameState, .inPlay)
        gameModel.makeMove(.topMiddle)
        XCTAssertEqual(gameModel.gameTurn, .player2)
        XCTAssertEqual(gameModel.gameState, .inPlay)
        gameModel.makeMove(.middleMiddle)

        // Set 3
        XCTAssertEqual(gameModel.gameTurn, .player1)
        XCTAssertEqual(gameModel.gameState, .inPlay)
        gameModel.makeMove(.topRight)
        XCTAssertEqual(gameModel.gameTurn, .player2)
        XCTAssertEqual(gameModel.gameState, .endGame)
    }

    // Test Duplicate Move
    func testDuplicateMoves() {
        XCTAssertEqual(gameModel.gameTurn, .player1)
        XCTAssertEqual(gameModel.gameState, .readyToStart)
        gameModel.makeMove(.topLeft)
        XCTAssertEqual(gameModel.gameTurn, .player2)
        XCTAssertEqual(gameModel.gameState, .inPlay)
        XCTAssertTrue(gameModel.isLastMoveValid)
        gameModel.makeMove(.topLeft)
        XCTAssertEqual(gameModel.gameTurn, .player2)
        XCTAssertEqual(gameModel.gameState, .inPlay)
        XCTAssertFalse(gameModel.isLastMoveValid)
        gameModel.makeMove(.topRight)
        XCTAssertEqual(gameModel.gameTurn, .player1)
        XCTAssertEqual(gameModel.gameState, .inPlay)
        XCTAssertTrue(gameModel.isLastMoveValid)
    }

    func testUndo() {
        XCTAssertEqual(gameModel.gameTurn, .player1)
        XCTAssertEqual(gameModel.gameState, .readyToStart)
        gameModel.makeMove(.topLeft)
        XCTAssertEqual(gameModel.gameTurn, .player2)
        XCTAssertEqual(gameModel.gameState, .inPlay)
        gameModel.undo()
        XCTAssertEqual(gameModel.gameTurn, .player1)
        XCTAssertEqual(gameModel.gameState, .readyToStart)
    }

    func testReset() {
        gameModel.makeMove(.topRight)
        XCTAssertEqual(gameModel.gameTurn, .player2)
        XCTAssertEqual(gameModel.gameState, .inPlay)
        gameModel.reset()
        XCTAssertEqual(gameModel.gameTurn, .player1)
        XCTAssertEqual(gameModel.gameState, .readyToStart)
    }

    func testGameBoardState() {
        XCTAssertEqual(gameModel.gameBoardState, [.none, .none, .none,
                                                  .none, .none, .none,
                                                  .none, .none, .none])

        gameModel.makeMove(.topRight)

        XCTAssertEqual(gameModel.gameBoardState, [.none, .none, .player1,
                                                  .none, .none, .none,
                                                  .none, .none, .none])

        gameModel.makeMove(.middleMiddle)

        XCTAssertEqual(gameModel.gameBoardState, [.none, .none, .player1,
                                                  .none, .player2, .none,
                                                  .none, .none, .none])
        gameModel.makeMove(.bottomRight)

        XCTAssertEqual(gameModel.gameBoardState, [.none, .none, .player1,
                                                  .none, .player2, .none,
                                                  .none, .none, .player1])
        gameModel.makeMove(.middleRight)

        XCTAssertEqual(gameModel.gameBoardState, [.none, .none, .player1,
                                                  .none, .player2, .player2,
                                                  .none, .none, .player1])
    }

    func testDrawOutcome() {
        gameModel.makeMove(.topLeft)
        gameModel.makeMove(.middleMiddle)
        gameModel.makeMove(.topMiddle)
        gameModel.makeMove(.topRight)
        gameModel.makeMove(.bottomLeft)
        gameModel.makeMove(.middleLeft)
        gameModel.makeMove(.middleRight)
        gameModel.makeMove(.bottomMiddle)
        gameModel.makeMove(.bottomRight)

        XCTAssertEqual(gameModel.gameBoardState, [.player1, .player1, .player2,
                                                  .player2, .player2, .player1,
                                                  .player1, .player2, .player1])

        XCTAssertEqual(gameModel.gameState, .draw)
    }

    func testShouldResetProperly() {
        gameModel.reset()

        testDrawOutcome()
    }
}
