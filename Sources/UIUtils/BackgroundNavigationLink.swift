//
//  BackgroundNavigationLink.swift
//  UIUtils
//
//  Created by Pawel on 20/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

/// Creates a hidden NavigationLink and optionally executes an action
@available(iOS 13.0, *)
public struct BackgroundNavigationLink<Destination, Content>: View where Destination: View, Content: View {
    @State private var linkActive = false

    private let destination: () -> Destination
    private let action: (() -> Void)?
    private let content: () -> Content

    public init(
        destination: @escaping () -> Destination,
        action: (() -> Void)? = nil,
        content: @escaping () -> Content
    ) {
        self.destination = destination
        self.action = action
        self.content = content
    }

    public init(
        destination: @autoclosure @escaping () -> Destination,
        action: (() -> Void)? = nil,
        content: @escaping () -> Content
    ) {
        self.init(destination: destination, action: action, content: content)
    }

    public init(
        destination: @autoclosure @escaping () -> Destination,
        action: (() -> Void)? = nil,
        content: @autoclosure @escaping () -> Content
    ) {
        self.init(destination: destination, action: action, content: content)
    }

    public var body: some View {
        Button(action: buttonAction, label: content)
            .background(NavigationLink("", destination: destination(), isActive: $linkActive).hidden())
    }

    private func buttonAction() {
        action?()
        linkActive = true
    }
}
