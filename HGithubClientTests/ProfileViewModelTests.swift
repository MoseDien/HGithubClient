//
//  ProfileViewModelTests.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

import XCTest
@testable import HGithubClient

final class ProfileViewModelTests: XCTestCase {
    let viewModel = ProfileViewModel()
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    @MainActor
    func testFetchProfile() async {
        await viewModel.fetch()
        XCTAssertNotNil(viewModel.profile)
        XCTAssertEqual(viewModel.uiState, .success)
    }
}
