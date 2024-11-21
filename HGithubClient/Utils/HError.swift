//
//  HError.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

enum HError: Error {
    case networkError(message: String)
    case invalidInput(reason: String)
    case unknownError
    case biometricFailed
}
