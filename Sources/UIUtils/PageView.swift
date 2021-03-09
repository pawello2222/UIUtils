//
//  PageView.swift
//  UIUtils
//
//  Created by Pawel on 09/03/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
public struct PageView<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    @Binding private var selection: SelectionValue
    private let indexDisplayMode: PageTabViewStyle.IndexDisplayMode
    private let indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode
    private let content: () -> Content

    public init(
        selection: Binding<SelectionValue>,
        indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic,
        indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode = .automatic,
        @ViewBuilder content: @escaping () -> Content
    ) {
        _selection = selection
        self.indexDisplayMode = indexDisplayMode
        self.indexBackgroundDisplayMode = indexBackgroundDisplayMode
        self.content = content
    }

    public var body: some View {
        TabView(selection: $selection) {
            content()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: indexDisplayMode))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: indexBackgroundDisplayMode))
    }
}

@available(iOS 14.0, *)
extension PageView where SelectionValue == Int {
    public init(
        indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic,
        indexBackgroundDisplayMode: PageIndexViewStyle.BackgroundDisplayMode = .automatic,
        @ViewBuilder content: @escaping () -> Content
    ) {
        _selection = .constant(0)
        self.indexDisplayMode = indexDisplayMode
        self.indexBackgroundDisplayMode = indexBackgroundDisplayMode
        self.content = content
    }
}
