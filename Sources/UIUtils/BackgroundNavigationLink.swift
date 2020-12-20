//
//  BackgroundNavigationLink.swift
//  UIUtils
//
//  Created by Pawel on 20/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct BackgroundNavigationLink<Destination, Content>: View where Destination: View, Content: View {
    @State private var linkActive = false

    private let destination: () -> Destination
    private let content: () -> Content

    public init(destination: @escaping () -> Destination, content: @escaping () -> Content) {
        self.destination = destination
        self.content = content
    }

    public var body: some View {
        Button(action: action, label: content)
            .background(NavigationLink("", destination: destination(), isActive: $linkActive))
    }

    private func action() {
        linkActive = true
    }
}
