//
//  TabViewItem.swift
//  UIUtils
//
//  Created by Pawel on 23/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct TabViewItem<Selection>: ViewModifier where Selection: Hashable {
    @Environment(\.tabSelection) private var tabSelection
    private let index: Selection
    private let text: String
    private let imageName: String

    public init(index: Selection, text: String, imageName: String) {
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
        guard tabSelection.wrappedValue == index as AnyHashable else {
            return Image(systemName: imageName)
        }
        let filledImageName = imageName + ".fill"
        if let uiImage = UIImage(systemName: filledImageName) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: imageName)
    }
}

@available(iOS 13.0, *)
extension View {
    public func tabItem<IndexValue>(
        index: IndexValue,
        text: String,
        imageName: String
    ) -> some View where IndexValue: Hashable {
        modifier(TabViewItem(index: index, text: text, imageName: imageName))
    }
}

@available(iOS 13.0, *)
extension View {
    public func tabSelection<Selection>(
        _ selection: Binding<Selection>
    ) -> some View where Selection: Hashable {
        environment(\.tabSelection, .init(
            get: {
                selection.wrappedValue as AnyHashable
            },
            set: {
                guard let value = $0 as? Selection else { return }
                selection.wrappedValue = value
            }
        ))
    }
}

@available(iOS 13.0, *)
extension EnvironmentValues {
    private struct TabSelectionKey: EnvironmentKey {
        static let defaultValue: Binding<AnyHashable> = .constant(0)
    }

    public var tabSelection: Binding<AnyHashable> {
        get { self[TabSelectionKey] }
        set { self[TabSelectionKey] = newValue }
    }
}
