//
//  UniqueStack.swift
//  SwiftTacToe
//
//  Created by shaun on 10/10/21.
//

import Foundation

/// A specialized data structure that allows for game state logic to be preserved easily and enforcing uniqueness rules

/// This stack throws an error `duplicateElement` when a non unique element is addded
struct UniqueStack<Element: Equatable> {
    enum Errors: Error {
        case emptyStack
        case duplicateElement
    }

    private var array = [Element]()

    /// Preview top element of the stack
    func peek() -> Element? {
        return array.last
    }

    /// Pushes an `Element` on to the top of the `Stack`
    mutating func push(_ ele: Element) throws {
        guard !array.contains(ele) else { throw Errors.duplicateElement }
        array.append(ele)
    }

    /// Pops an `Element` from the top of the `Stack`
    @discardableResult
    mutating func pop() throws -> Element? {
        guard let ele = array.popLast() else { throw Errors.emptyStack }
        return ele
    }

    /// A count of the members in the unique stack
    var count: Int {
        return array.count
    }

    /// An array of elements in the stack in the order they were added
    var arrayCopy: Array<Element> {
        return array
    }
}
