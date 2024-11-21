//
//  LoginView.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = "Jerry"
    @State private var password: String = "Jerry123"
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("login")
                .font(.largeTitle)
                .bold()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if let errorMessage = authViewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }

            HStack {
                Button(action: {
                    Task {
                        await authViewModel.login(username: username, password: password)
                    }
                }) {
                    Text("login")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    Task {
                        await authViewModel.loginWithBioMetric()
                    }
                }) {
                    Text("biometricLogin")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
    }
}
