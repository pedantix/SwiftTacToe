//
//  ContentView.swift
//  SwiftTacToe
//
//  Created by shaun on 10/10/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameModel: GameModel

    var body: some View {
        VStack {
            Spacer(minLength: 80)
            ZStack(alignment: .center) {
                GamePlayView()
                GameBoard()
            }.aspectRatio(1.0, contentMode: .fit)
            GameControlsView()
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GameModel())
    }
}
