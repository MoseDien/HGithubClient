//
//  MockAPIService.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

import Foundation
@testable import HGithubClient

class MockAPIService: APIService {
    private var trendingItems: [Repository] = []
    private var searchItems: [Repository] = []
    private var failed: Bool = false
    
    func set(trending: [Repository], search: [Repository], failed: Bool) {
        self.trendingItems = trending
        self.searchItems = search
        self.failed = failed
    }

    func fetchTrending() async throws -> [Repository] {
        if failed {
            throw HError.unknownError
        } else {
            return trendingItems
        }
    }

    func search(query: String) async throws -> [Repository] {
        if failed {
            throw HError.invalidInput(reason: "404")
        } else {
            return searchItems
        }
    }
}


