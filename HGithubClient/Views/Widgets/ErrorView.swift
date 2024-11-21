//
//  ErrorView.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/20.
//

import SwiftUI

struct ErrorView: View {
    let title: String
    let message: String
    let onTryAgain: (() -> Void)?

    var body: some View {
        VStack(spacing: 20) {
            Text(localizedString(title))
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Text(localizedString(message))
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            if onTryAgain != nil {
                Button(action: {
                    onTryAgain?()
                }) {
                    Text(localizedString("tryAgain"))
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.primaryButtonColor)
                        .foregroundColor(Color.onPrimaryButtonColor)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
        }
        .padding()
    }
}

struct EErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(
            title: "Something went wrong",
            message: "We couldn't complete your request. Please try again later.",
            onTryAgain: {
                print("Try Again tapped")
            }
        )
    }
}
