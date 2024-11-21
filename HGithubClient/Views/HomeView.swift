//
//  HomeView.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var showLogoutSheet = false
    @State private var showLogin = false
    @StateObject private var searchViewModel = SearchViewModel()
    @StateObject private var trendingViewModel = TrendingViewModel()

    var body: some View {
        NavigationView {
            VStack {
                searchView
                
                if authViewModel.isLoggedIn {
                    let message: String = localizedString("welcome") + ", " + authViewModel.username
                    Text(message)
                        .font(.title)
                        .padding()
                }

                treandingView
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    let profileView = ProfileView().environmentObject(authViewModel)
                    NavigationLink(destination: profileView) {
                        Text(localizedString("profile"))
                    }
                    .disabled(authViewModel.isLoggedIn == false)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if authViewModel.isLoggedIn {
                            showLogoutSheet = true
                        } else {
                            authViewModel.isLoggedIn = false
                            showLogin = true
                        }
                    }) {
                        Text(authViewModel.isLoggedIn ? "logout" : "login")
                    }
                }
            }
            .navigationTitle("home")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showLogoutSheet) {
                if #available(iOS 16.0, *) {
                    LogoutSheet(isPresented: $showLogoutSheet)
                        .presentationDetents([.medium])
                } else {
                    LogoutSheet(isPresented: $showLogoutSheet)
                }
                
            }
            .fullScreenCover(isPresented: $showLogin) {
                LoginView()
                    .environmentObject(authViewModel)
            }
            .task {
                await trendingViewModel.fetch()
            }
        }
    }
}

extension HomeView {
    var searchView: some View {
        HStack {
            let placeHolder: String = localizedString("searchPlaceholder")
            TextField(placeHolder, text: $searchViewModel.searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            NavigationLink {
                SearchView(viewModel: searchViewModel)
            } label: {
                Text(localizedString("search"))
            }
        }
        .padding()
    }
    
    @ViewBuilder
    var treandingView: some View {
        VStack {
            HStack{
                Text("trending")
                    .font(.title)
                    .padding()
                Spacer()
            }
            
            switch trendingViewModel.uiState {
            case .loading:
                ProgressView("loading")
                    .padding()
            case .success:
                trendingContent
            case .failure:
                let message = localizedString("loadingFailed")
                ErrorView(title: localizedString("failedToLoad"), message: message) {
                    Task {
                        await trendingViewModel.fetch()
                    }
                }
            }
        }
    }
    
    var trendingContent: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(trendingViewModel.repositories) { repo in
                    Link(destination: URL(string: repo.html_url)!) {
                        TrendingItemView(repository: repo)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
