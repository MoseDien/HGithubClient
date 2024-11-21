//
//  TrendingViewModel.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

import Combine
import Foundation

class TrendingViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
    @Published var uiState: ViewState = .loading

    private let apiService: APIService
    init(apiService: APIService = GitHubAPIService()) {
        self.apiService = apiService
    }
    
    @MainActor
    func fetch() async {
        uiState = .loading
        do {
            repositories = try await apiService.fetchTrending()
            uiState = .success
        } catch {
            uiState = .failure
        }
    }
}
