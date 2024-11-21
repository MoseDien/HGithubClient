//
//  AuthViewModelTests.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

import XCTest
@testable import HGithubClient

final class AuthViewModelTests: XCTestCase {
    let viewModel = AuthViewModel()
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testLoginSuccess() async {
        let expectedUsername = "Jerry"
        let expectedPassword = "Jerry123"

        await viewModel.login(username: expectedUsername, password: expectedPassword)

        XCTAssertTrue(viewModel.isLoggedIn)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.username, expectedUsername)
        XCTAssertEqual(viewModel.uiState, .success)
    }

    func testLoginFailure() async {
        let invalidUsername = "Jerry"
        let invalidPassword = "123"

        await viewModel.login(username: invalidUsername, password: invalidPassword)

        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertEqual(viewModel.errorMessage, localizedString("invalideUsernameOrPassword"))
        XCTAssertEqual(viewModel.username, "")
        XCTAssertEqual(viewModel.uiState, .failure)
    }

    func testLogout() async {
        await viewModel.login(username: "Jerry", password: "Jerry123")
        await viewModel.logout()

        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertEqual(viewModel.username, "")
        XCTAssertEqual(viewModel.errorMessage, "")
    }
}
