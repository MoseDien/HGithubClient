//
//  ProfileViewModel.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//

import Combine

class ProfileViewModel: ObservableObject {
    @Published var profile: Profile?
    @Published var uiState: ViewState = .loading

    @MainActor
    func fetch() async {
        uiState = .loading
        try? await Task.sleep(nanoseconds: 2_000_000_000)
        
        // use mock data
        profile = Profile(username: "Jerry",
                          nickname: "Deepwhite",
                          email: "Jerry@gmail.com",
                          avatarUrl: "https://avatars.githubusercontent.com/u/20842123?v=4",
                          bio: "iOS Developer",
                          followers: 456,
                          following: 123,
                          repositories: 45,
                          starred: 1867,
                          winningStars: 99)
        uiState = .success
    }
}
