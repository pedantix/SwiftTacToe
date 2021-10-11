//
//  SquareView.swift
//  SwiftTacToe
//
//  Created by shaun on 10/10/21.
//

import SwiftUI

struct SquareView<Content: View>: View {
    let content: (CGFloat) -> Content

    var body: some View {
        GeometryReader { geometry in
            let squareDimension = min(geometry.size.height, geometry.size.width)
            content(squareDimension)
                .frame(width: squareDimension, height: squareDimension)
        }
    }
}
