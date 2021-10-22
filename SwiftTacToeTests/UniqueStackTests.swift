//
//  UniqueStackTests.swift
//  SwiftTacToeTests
//
//  Created by shaun on 10/10/21.
//

import XCTest
@testable import SwiftTacToe

class SwiftTacToeTests: XCTestCase {

    private var stack: UniqueStack<Int>!

    override func setUpWithError() throws {
        stack = .init()
    }

    func testPush() throws {
        try stack.push(1)
        try stack.push(2)

        XCTAssertThrowsError(try stack.push(1), "must be unique") { error in
            XCTAssert(error as? UniqueStack<Int>.Errors == UniqueStack.Errors.duplicateElement)
        }
    }

    func testPeek() throws {
        try stack.push(1)
        try stack.push(2)
        XCTAssertEqual(stack.peek(), 2)
    }

    func testPop() throws {
        try stack.push(1)

        XCTAssertEqual(try stack.pop(), 1)

        XCTAssertThrowsError(try stack.pop(), "must not be empty") { error in
            XCTAssert(error as? UniqueStack<Int>.Errors == UniqueStack.Errors.emptyStack)
        }
    }

    func testShouldReturnFullWithNineElements() throws {
        try (1...8).forEach { number in
            try stack.push(number)
            XCTAssertEqual(false, stack.isFull)
        }
        try stack.push(9)
        XCTAssertEqual(true, stack.isFull)
    }
}
