//
//  GithubSearchResponse.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//


struct GithubSearchResponse: Decodable {
    let items: [Repository]
}
