//
//  SwiftTacToeApp.swift
//  SwiftTacToe
//
//  Created by shaun on 10/10/21.
//

import SwiftUI

@main
struct SwiftTacToeApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(GameModel())
        }
    }
}
