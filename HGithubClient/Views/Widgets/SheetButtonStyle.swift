//
//  SheetButtonStyle.swift
//  HGithubClient
//
//  Created by Bell Dien on 2024/11/21.
//

import SwiftUI

struct SheetButtonStyle: ButtonStyle {
    let backgroundColor: Color
    let foregroundColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(8)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}
