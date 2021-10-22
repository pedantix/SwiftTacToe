//
//  GameModel.swift
//  SwiftTacToe
//
//  Created by shaun on 10/10/21.
//

import Foundation

enum PlayerMove: Int, Equatable, Identifiable {
    var id: RawValue { rawValue }

    case player1
    case player2
}

enum GameMove: Int, Equatable {
    case topLeft, topMiddle, topRight
    case middleLeft, middleMiddle, middleRight
    case bottomLeft, bottomMiddle, bottomRight
}

private let winningSets: [Set<GameMove>] = [
    // Horizontal
    [.topRight, .topMiddle, .topLeft],
    [.middleLeft, .middleMiddle, .middleRight],
    [.bottomLeft, .bottomMiddle, .bottomRight],
    // Vertrical
    [.topLeft, .middleLeft, .bottomLeft],
    [.topRight, .middleRight, .bottomRight],
    [.topMiddle, .middleMiddle, .bottomMiddle],
    // Diagnol
    [.topLeft, .middleMiddle, .bottomRight],
    [.bottomLeft, .middleMiddle, .topRight]
]


enum GameState {
    case readyToStart
    case inPlay
    case endGame
    case draw
}

class GameModel: ObservableObject {
    public static let squareCount = 9

    @Published private var gameStack: UniqueStack<GameMove> = UniqueStack(capacity: GameModel.squareCount)
    @Published private(set) var gameState = GameState.readyToStart
    @Published private(set) var isLastMoveValid = true


    var gameTurn: PlayerMove {
        return gameStack.count % 2 == 0 ? .player1 : .player2
    }

    /// Returns an array of 9 `SquareState`
    var gameBoardState: [PlayerMove?] {
        var gameSquares = [PlayerMove?](repeating: .none, count: GameModel.squareCount)
        var player1Moves = Set<GameMove>()
        var player2Moves = Set<GameMove>()

        for idxMove in gameStack.arrayCopy.enumerated() {
            if idxMove.offset % 2 == 0 {
                player1Moves.insert(idxMove.element)
            } else {
                player2Moves.insert(idxMove.element)
            }
        }

        for move in player1Moves {
            gameSquares[move.rawValue] = .player1
        }

        for move in player2Moves {
            gameSquares[move.rawValue] = .player2
        }

        return gameSquares
    }

    func makeMove(_ move: GameMove) {
        isLastMoveValid = true

        // Check if move is legal
        do {
            try gameStack.push(move)
        } catch {
            isLastMoveValid = false
            return
        }

        // Evaluate game state
        evaluateGameState()
    }


    private func evaluateGameState() {
        if gameStack.peek() == .none {
            gameState = .readyToStart
        } else {
            gameState = .inPlay
        }

        // Score Game for winner end if there is
        var currentPlayerMoves = Set<GameMove>()
        for idxMove in gameStack.arrayCopy.reversed().enumerated() {
            if idxMove.offset % 2 == 0 {
                currentPlayerMoves.insert(idxMove.element)
            }
        }

        for winningSet in winningSets {
            if currentPlayerMoves.isSuperset(of: winningSet) {
                gameState = .endGame
                return
            }
        }

        if gameStack.isFull {
            gameState = .draw
            return
        }
    }

    func undo() {
        _ = try? gameStack.pop()
        evaluateGameState()
    }

    /// Reset the game back to the original state
    func reset() {
        gameStack = .init()
        gameState = .readyToStart
    }
}
