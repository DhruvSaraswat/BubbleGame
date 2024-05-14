//
//  RequestTests.swift
//  BubbleGameTests
//
//  Created by Dhruv Saraswat on 15/05/24.
//

import XCTest
@testable import BubbleGame

final class RequestTests: XCTestCase {

    func test_authenticate() {
        let username = UnitTestsUtility.generateRandomString(domain: .alphanumeric, ofLength: 10)
        let password = UnitTestsUtility.generateRandomString(domain: .alphanumeric, ofLength: 10)

        let sut = Request.authenticate(username: username, password: password)

        XCTAssertEqual(sut.scheme, "http")
        XCTAssertEqual(sut.baseURL, "test.sensibol.com")
        XCTAssertEqual(sut.path, "/authenticate")
        XCTAssertNil(sut.port)
        XCTAssertNil(sut.headers)
        XCTAssertEqual(sut.query, "login={\"username\":\"\(username)\",\"password\":\"\(password)\"}")
        XCTAssertEqual(sut.method, HTTPMethod.post)
        XCTAssertNil(sut.requestBody)
    }

    func test_getLevelDetails() {
        let randomInt = Int.random(in: 1..<100)

        let sut = Request.getLevelDetails(level: randomInt)

        XCTAssertEqual(sut.scheme, "http")
        XCTAssertEqual(sut.baseURL, "test.sensibol.com")
        XCTAssertEqual(sut.path, "/leveldetails")
        XCTAssertNil(sut.port)
        XCTAssertNil(sut.headers)
        XCTAssertEqual(sut.query, "level=\(randomInt)")
        XCTAssertEqual(sut.method, HTTPMethod.get)
        XCTAssertNil(sut.requestBody)
    }

    func test_saveScore() {
        let randomInt = Int.random(in: 1..<100)
        let randomSessionID = UnitTestsUtility.generateRandomString(domain: .alphanumeric, ofLength: 10)
        let randomUsername = UnitTestsUtility.generateRandomString(domain: .alphanumeric, ofLength: 10)

        let sut = Request.saveScore(score: randomInt, sessionID: randomSessionID, username: randomUsername)

        XCTAssertEqual(sut.scheme, "http")
        XCTAssertEqual(sut.baseURL, "test.sensibol.com")
        XCTAssertEqual(sut.path, "/savescore")
        XCTAssertNil(sut.port)
        XCTAssertNil(sut.headers)
        XCTAssertEqual(sut.query, "score=\(randomInt)&sessionID=\(randomSessionID)&username=\(randomUsername)")
        XCTAssertEqual(sut.method, HTTPMethod.post)
        XCTAssertNil(sut.requestBody)
    }

}
