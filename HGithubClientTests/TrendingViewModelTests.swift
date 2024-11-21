//
//  TrendingViewModelTests.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

import XCTest
@testable import HGithubClient

class TrendingViewModelTests: XCTestCase {
    typealias Owner = Repository.Owner
    
    var viewModel: TrendingViewModel!
    var mockAPIService: MockAPIService!
    let repository1 = Repository(id: 0, name: "itemy", description: "itemy", stargazers_count: 1, html_url: "https://www.y.com", owner: Owner(login: "y1", avatar_url: ""))
    let repository2 = Repository(id: 1, name: "itemz", description: "itemz", stargazers_count: 1, html_url: "https://www.z.com", owner: Owner(login: "z1", avatar_url: ""))

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = TrendingViewModel(apiService: mockAPIService)
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }

    func testSearchSuccess() async {
        mockAPIService.set(trending: [repository1, repository2], search: [], failed: false)
        await viewModel.fetch()

        XCTAssertEqual(viewModel.repositories.count, 2)
        XCTAssertEqual(viewModel.uiState, .success)
    }

    func testSearchFailure() async {
        mockAPIService.set(trending: [repository1, repository2], search: [], failed: true)
        await viewModel.fetch()

        XCTAssertEqual(viewModel.uiState, .failure)
    }
}
