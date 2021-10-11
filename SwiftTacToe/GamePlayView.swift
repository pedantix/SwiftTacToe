//
//  GamePlayView.swift
//  SwiftTacToe
//
//  Created by shaun on 10/10/21.
//

import SwiftUI

private let strokeStyle = StrokeStyle(lineWidth: 5, lineCap: .round)

private struct XView: View {
    var body: some View {
        GeometryReader { geo in
            Path { path in
                let fivePercent = (geo.size.width + geo.size.height) / 2 * 0.05
                let top = fivePercent
                let leading = fivePercent
                let bottom = geo.size.height - fivePercent
                let trailing = geo.size.width - fivePercent

                path.move(to: .init(x: leading, y: top))
                path.addLine(to: .init(x: trailing, y: bottom))

                path.move(to: .init(x: trailing, y: top))
                path.addLine(to: .init(x: leading, y: bottom))

            }
            .strokedPath(strokeStyle)
            .foregroundColor(.primary)
        }
    }
}

private struct OView: View {
    var body: some View {
        GeometryReader { geo in
            let fivePercent = (geo.size.width + geo.size.height) / 2 * 0.05
            Circle()
               .stroke(.primary ,style: strokeStyle)
               .padding(fivePercent)
        }
    }
}

private struct GameMoveView: View {
    @EnvironmentObject var gameModel: GameModel
    let maybeMove: PlayerMove?
    let gameMove: GameMove

    var body: some View {
        switch maybeMove {
        case .player1:
            XView()
        case .player2:
            OView()
        case .none:
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    guard gameModel.gameState != .endGame else { return }
                    gameModel.makeMove(gameMove)
                }
        }
    }
}


struct GamePlayView: View {
    @EnvironmentObject var game: GameModel

    var body: some View {
        SquareView { dimension in
            VStack {
                rowOfMoves(game.gameBoardState[0..<3], gameMoves: [.topLeft, .topMiddle, .topRight])
                rowOfMoves(game.gameBoardState[3..<6], gameMoves: [.middleLeft, .middleMiddle, .middleRight])
                rowOfMoves(game.gameBoardState[6..<9], gameMoves: [.bottomLeft, .bottomMiddle, .bottomRight])
            }
        }
    }

    private func rowOfMoves(_ moves: ArraySlice<PlayerMove?>, gameMoves: [GameMove]) -> some View {
        let moves = Array(moves)
        return HStack {
            ForEach([0, 1, 2], id: \.self) { idx in
                GameMoveView(maybeMove: moves[idx], gameMove: gameMoves[idx])

            }
        }
    }
}

struct GamePlayView_Previews: PreviewProvider {
    static var previews: some View {
        let game = GameModel()
        game.makeMove(.topRight)
        game.makeMove(.middleMiddle)
        game.makeMove(.bottomRight)
        game.makeMove(.middleRight)
        game.makeMove(.middleLeft)
        game.undo()
        game.undo()

        return Group {
            ZStack {
                GamePlayView()
                GameBoard()
            }.padding().previewInterfaceOrientation(.portrait)
        }.environmentObject(game)
    }
}
