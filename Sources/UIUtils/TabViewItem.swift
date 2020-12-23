//
//  TabViewItem.swift
//  UIUtils
//
//  Created by Pawel on 23/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct TabViewItem<SelectionValue>: ViewModifier where SelectionValue: Hashable {
    @Binding private var selectedIndex: SelectionValue
    private let index: SelectionValue
    private let text: String
    private let imageName: String

    public init(selectedIndex: Binding<SelectionValue>, index: SelectionValue, text: String, imageName: String) {
        self._selectedIndex = selectedIndex
        self.index = index
        self.text = text
        self.imageName = imageName
    }

    public func body(content: Content) -> some View {
        content
            .tabItem {
                image
                Text(text)
            }
            .tag(index)
    }

    private var image: some View {
        guard selectedIndex == index else {
            return Image(systemName: imageName)
        }
        let imageName = self.imageName + ".fill"
        if let uiImage = UIImage(systemName: imageName) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: self.imageName)
    }
}

@available(iOS 13.0, *)
public extension View {
    func tabItem<Selection>(
        selectedIndex: Binding<Selection>,
        index: Selection,
        text: String,
        imageName: String
    ) -> some View where Selection: Hashable {
        modifier(TabViewItem(selectedIndex: selectedIndex, index: index, text: text, imageName: imageName))
    }
}
