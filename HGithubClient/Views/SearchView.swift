//
//  SearchView.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var viewModel = SearchViewModel()
    
    init(viewModel: SearchViewModel = SearchViewModel()) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            searchView
            
            Spacer()
            
            switch viewModel.uiState {
            case .loading:
                ProgressView("searching")
            case .success:
                searchResultView
            case .failure:
                let message = localizedString("loadingFailed")
                ErrorView(title: localizedString("searchFailed"), message: message) {
                    Task {
                        await viewModel.search()
                    }
                }
            }
        }
        .navigationTitle("search")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.search()
        }
    }
}

extension SearchView {
    var searchView: some View {
        HStack {
            TextField(viewModel.placeHolder, text: $viewModel.searchQuery)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button(action: {
                Task {
                    await viewModel.search()
                }
            }) {
                Text(localizedString("search"))
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.primaryButtonColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    var searchResultView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(viewModel.repositories.indices, id: \.self) { index in
                    let repo = viewModel.repositories[index]

                    Link(destination: URL(string: repo.html_url)!) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(repo.name)
                                .font(.headline)

                            if let description = repo.description {
                                Text(description)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 10)
                        .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())

                    if index < viewModel.repositories.count - 1 {
                        Divider()
                    }
                }
            }
            .padding()
        }
    }
}
