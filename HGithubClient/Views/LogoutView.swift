//
//  LogoutView.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//

import SwiftUI
struct LogoutSheet: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var authViewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text(localizedString("confirmLogout"))
                .font(.headline)

            HStack(spacing: 20) {
                Button("cancel") {
                    isPresented = false
                }
                .buttonStyle(SheetButtonStyle(
                    backgroundColor: Color.gray.opacity(0.2),
                    foregroundColor: Color.primary
                ))

                Button("logout") {
                    Task {
                        await authViewModel.logout()
                    }
                    isPresented = false
                }
                .buttonStyle(SheetButtonStyle(
                    backgroundColor: Color.red.opacity(0.8),
                    foregroundColor: .white
                ))
            }
            .padding()
        }
        .padding()
    }
}
