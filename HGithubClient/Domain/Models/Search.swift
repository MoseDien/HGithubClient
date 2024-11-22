//
//  Search.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//
import Foundation

// swiftlint:disable identifier_name
struct Repository: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String?
    let stargazers_count: Int
    let html_url: String
    let owner: Owner

    struct Owner: Decodable {
        let login: String
        let avatar_url: String
    }
}
// swiftlint:enable identifier_name
