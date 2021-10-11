//
//  GameControls.swift
//  SwiftTacToe
//
//  Created by shaun on 10/11/21.
//

import SwiftUI

struct GameControlsView: View {
    @EnvironmentObject var gameModel: GameModel

    var body: some View {
        VStack {
            Spacer()
            switch gameModel.gameState {
            case .readyToStart:
                Text("Ready To Start")
            case .inPlay:
                undoButton
                Spacer()
                resetButton
            case .endGame:
                Text("Winner \(winningPlayer)").font(.callout.weight(.heavy))
                Spacer()
                undoButton
                Spacer()
                resetButton
            }
            Spacer()
        }
    }

    private var winningPlayer: String {
        switch gameModel.gameTurn {
        case .player1:
            return "Player 2"
        case .player2:
            return "Player 1"
        }
    }

    private var undoButton: some View {
        Button(action: gameModel.undo) {
            Text("Undo")
        }
    }

    private var resetButton: some View {
        Button(action: gameModel.reset) {
            Text("Reset")
        }
    }
}

struct GameControls_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameModel()
        game.makeMove(.topRight)
        return Group {
            GameControlsView().environmentObject(GameModel())
            GameControlsView().environmentObject(game)
        }
    }
}
