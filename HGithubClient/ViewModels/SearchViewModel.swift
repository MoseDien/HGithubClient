//
//  SearchViewModel.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//

import Combine
import Foundation

class SearchViewModel: ObservableObject {
    let placeHolder: String = "Dify"
    @Published var searchQuery: String = ""
    @Published var repositories: [Repository] = []
    @Published var uiState: ViewState = .loading

    private let apiService: APIService
    init(apiService: APIService = GitHubAPIService()) {
        self.apiService = apiService
    }

    @MainActor
    func search() async {
        uiState = .loading
        if searchQuery.isEmpty {
            searchQuery = placeHolder
        }
        
        do {
            repositories = try await apiService.search(query: searchQuery)
            uiState = .success
        } catch {
            uiState = .failure
        }
    }
}
