//
//  AuthViewModel.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//

import LocalAuthentication
import Combine

private let keyUser = "username"
private let keyPassword = "password"

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String? = nil
    @Published var username: String = ""
    @Published var uiState: ViewState = .loading

    private let validUser = User(username: "Jerry", password: "Jerry123")

    @MainActor
    func login(username: String, password: String) async {
        uiState = .loading
        // to simuluate a network request
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        
        if username == validUser.username && password == validUser.password {
            isLoggedIn = true
            errorMessage = nil
            self.username = username
            saveToStorage(username: username, password: password)
            uiState = .success
        } else {
            isLoggedIn = false
            errorMessage = localizedString("invalideUsernameOrPassword")
            self.username = ""
            uiState = .failure
        }
    }

    @MainActor
    func logout() async {
        isLoggedIn = false
        username = ""
        errorMessage = ""
    }
    
    @MainActor
    func loginWithBioMetric() async {
        let context = LAContext()
        let reason = localizedString("biometricLogin")
        
        let result = await withCheckedContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                continuation.resume(returning: success)
            }
        }

        if result {
            if let savedUsername = KeychainManager.retrieve(key: keyUser),
               let savedPassword = KeychainManager.retrieve(key: keyPassword) {
                await login(username: savedUsername, password: savedPassword)
            }
        } else {
            errorMessage = localizedString("biometricFailed")
        }
    }
    
    // save to keychain, we only need to allow one user to save
    private func saveToStorage(username: String, password: String) {
        if KeychainManager.save(key: keyUser, value: username) &&
            KeychainManager.save(key: keyPassword, value: password) {
        }
    }
}
