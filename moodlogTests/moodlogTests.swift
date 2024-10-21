//
//  moodlogTests.swift
//  moodlogTests
//
//  Created by Kartik Saraf on 14/10/24.
//

import Testing
@testable import moodlog

struct moodlogTests {

    @Test func testIntegerAddition() throws {
           // Given
           let a = 3
           let b = 5
           
           // When
           let result = a + b
           let expected = 8
           
           // Then
        #expect(Bool(result == expected))
       }

}
