//
//  APIService.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

protocol APIService {
    func fetchTrending() async throws -> [Repository]
    func search(query: String) async throws -> [Repository]
}

