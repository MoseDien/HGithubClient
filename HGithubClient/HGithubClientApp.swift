//
//  HGithubClientApp.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//

import SwiftUI

@main
struct HGithubClientApp: App {
    @StateObject private var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoggedIn {
                HomeView()
                    .environmentObject(authViewModel)
            } else {
                HomeView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
