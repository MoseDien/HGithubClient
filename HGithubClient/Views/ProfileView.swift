//
//  ProfileView.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @StateObject var viewModel = ProfileViewModel()
    @State private var avatarImage: UIImage?
    @State private var isPickerPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            switch viewModel.uiState {
            case .loading:
                loading
            case .success:
                content
            case .failure:
                errorView
            }
            Spacer()
        }
        .task {
            await viewModel.fetch()
        }
        .navigationTitle(localizedString("profile"))
        .padding()
    }
    
    var content: some View {
        VStack(spacing: 20) {
            VStack(alignment: .center, spacing: 10) {
                avatarView
                Text("\(viewModel.profile?.username ?? "--")")
                    .font(.title2)
                    .bold()
                Divider()
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text(localizedString("repositories"))
                        Text("\(viewModel.profile?.repositories ?? 0)")
                    }
                    HStack {
                        Text(localizedString("winningStars"))
                        Text("\(viewModel.profile?.winningStars ?? 0)")
                    }
                    Divider()
                    HStack {
                        Text(localizedString("followers"))
                        Text("\(viewModel.profile?.followers ?? 0)")
                    }
                    HStack {
                        Text(localizedString("following"))
                        Text("\(viewModel.profile?.following ?? 0)")
                    }
                }
            }
            Button(action: {
                Task {
                    await viewModel.fetch()
                }
            }) {
                Text(localizedString("refreshData"))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryButtonColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
}

private let avatarSize: CGFloat = 100
extension ProfileView {
    var avatarView: some View {
        VStack {
            if let avatarImage = avatarImage {
                Image(uiImage: avatarImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 3))
                    .shadow(radius: 5)
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: avatarSize, height: avatarSize)
                    .clipShape(Circle())
            }
            let title: String = avatarImage == nil ? localizedString("addAvatar") : localizedString("changeAvatar")
            Button(title) {
                isPickerPresented = true
            }
            .padding()
            .sheet(isPresented: $isPickerPresented) {
                ImagePicker(selectedImage: $avatarImage)
            }
        }
        .padding()
    }
    
    // shimmer loading - add any length we want to show
    var loading: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("UsernamePlaceHoler")
                .font(.title2)
                .bold()
            Divider()
            Text("RepositoriesPlaceHoler")
            Text("StarsPlaceHoler")
            Divider()
            Text("FollowersPlaceHoler")
            Text("FollowingPlaceHoler")
        }
        .redacted(reason: .placeholder)
    }
    
    var errorView: some View {
        ErrorView(title: localizedString("failedToLoad"), message: localizedString("anErrorOccurred")) {
            Task {
                await viewModel.fetch()
            }
        }
    }
}
