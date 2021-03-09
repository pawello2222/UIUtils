//
//  ToastMessageView.swift
//  UIUtils
//
//  Created by Pawel on 23/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct ToastMessage: Equatable {
    public var header: String
    public var text: String
    public var style: Style

    public init(header: String = "", text: String, style: Style = .info) {
        self.header = header
        self.text = text
        self.style = style
    }
}

@available(iOS 13.0, *)
extension ToastMessage {
    public enum Style {
        case error
        case info
        case success
        case warning
    }
}

@available(iOS 13.0, *)
public struct ToastMessageView: View {
    private let message: ToastMessage

    public init(message: ToastMessage) {
        self.message = message
    }

    public var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(message.text)
                        .fontWeight(.medium)
                        .font(.callout)
                        .foregroundColor(textColor)
                }
                .padding()
            }
            .fixedSize(horizontal: false, vertical: true)
            Spacer()
        }
        .transition(.move(edge: .top))
        .animation(.spring())
    }
}

@available(iOS 13.0, *)
extension ToastMessageView {
    public var backgroundColor: Color {
        switch message.style {
        case .info: return .gray
        case .success: return .green
        case .warning: return .yellow
        case .error: return .red
        }
    }
}

@available(iOS 13.0, *)
extension ToastMessageView {
    public var textColor: Color {
        switch message.style {
        case .info: return .black
        case .success: return .white
        case .warning: return .black
        case .error: return .white
        }
    }
}
