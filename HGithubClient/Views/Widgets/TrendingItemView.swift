//
//  TrendingItemView.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

import SwiftUI

struct TrendingItemView: View {
    let repository: Repository

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: repository.owner.avatar_url)) { image in
                image.resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }

            Text(repository.name)
                .font(.headline)
                .lineLimit(1)

            Text(repository.description ?? "No description provided.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(2)

            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text("\(repository.stargazers_count)")
            }
            .font(.caption)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .frame(width: 200)
    }
}
