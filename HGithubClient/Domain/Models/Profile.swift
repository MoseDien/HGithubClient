//
//  Profile.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

struct Profile {
    let username: String
    let nickname: String?
    let email: String?
    let avatarUrl: String?
    let bio: String?
    let followers: Int?
    let following: Int?
    let repositories: Int?
    let starred: Int?
    let winningStars: Int?
    
    init(username: String,
         nickname: String? = nil,
         email: String? = nil,
         avatarUrl: String? = nil,
         bio: String? = nil,
         followers: Int? = nil,
         following: Int? = nil,
         repositories: Int? = nil,
         starred: Int? = nil,
         winningStars: Int? = nil) {
        self.username = username
        self.nickname = nickname
        self.email = email
        self.avatarUrl = avatarUrl
        self.bio = bio
        self.followers = followers
        self.following = following
        self.repositories = repositories
        self.starred = starred
        self.winningStars = winningStars
    }
}
