//
//  GameBoard.swift
//  SwiftTacToe
//
//  Created by shaun on 10/10/21.
//

import SwiftUI

struct GameBoard: View {
    @ViewBuilder
    var body: some View {
        SquareView { dimension in
            Path { path in
                // Divide the board in dimensions
                [dimension / 3, 2 * dimension / 3].forEach { startPoint in
                    // draw the horizontal lines
                    path.move(to: .init(x: startPoint, y: 0))
                    path.addLine(to: .init(x: startPoint, y: dimension))
                    // draw the vertrical lines
                    path.move(to: .init(x: 0, y: startPoint))
                    path.addLine(to: .init(x: dimension, y: startPoint))
                }
            }
            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))

        }
    }
}

struct GameBoard_Previews: PreviewProvider {
    static var previews: some View {
        GameBoard()
    }
}
