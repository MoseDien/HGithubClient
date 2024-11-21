//
//  GiithubService.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

import Foundation

class GitHubAPIService: APIService {
    private let baseURL = "https://api.github.com"

    func fetchTrending() async throws -> [Repository] {
        let url = URL(string: "\(baseURL)/search/repositories?q=stars:>10000&sort=stars&order=desc")!
        return try await fetchData(url: url)
    }

    func search(query: String) async throws -> [Repository] {
        let url = URL(string: "\(baseURL)/search/repositories?q=\(query)")!
        return try await fetchData(url: url)
    }

    private func fetchData(url: URL) async throws -> [Repository] {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(GithubSearchResponse.self, from: data).items
    }
}
