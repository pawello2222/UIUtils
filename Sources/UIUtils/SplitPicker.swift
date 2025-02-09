//
//  SplitPicker.swift
//  UIUtils
//
//  Created by Pawel on 20/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

@available(iOS 14.0, *)
public struct PickerItem<
    Selection: Hashable,
    Short: Hashable & LosslessStringConvertible,
    Long: Hashable & LosslessStringConvertible
>: Hashable {
    public let selection: Selection
    public let short: Short
    public let long: Long

    public init(selection: Selection, short: Short, long: Long) {
        self.selection = selection
        self.short = short
        self.long = long
    }
}

// MARK: - Split Picker

@available(iOS 14.0, *)
public struct SplitPicker<
    Label: View,
    Selection: Hashable,
    ShortValue: Hashable & LosslessStringConvertible,
    LongValue: Hashable & LosslessStringConvertible
>: View {
    public typealias Item = PickerItem<Selection, ShortValue, LongValue>

    @State private var isLinkActive = false
    @Binding private var selection: Selection
    private let items: [Item]
    private var showMultiLabels: Bool
    private var multiLabelWidth: CGFloat
    private let label: () -> Label

    public init(
        selection: Binding<Selection>,
        items: [Item],
        showMultiLabels: Bool = false,
        multiLabelWidth: CGFloat = 50,
        label: @escaping () -> Label
    ) {
        _selection = selection
        self.items = items
        self.showMultiLabels = showMultiLabels
        self.multiLabelWidth = multiLabelWidth
        self.label = label
    }

    public var body: some View {
        NavigationLink(destination: selectionView, isActive: $isLinkActive) {
            HStack {
                label()
                Spacer()
                if let selectedItem = selectedItem {
                    Text(String(selectedItem.short))
                        .foregroundColor(Color.secondary)
                }
            }
        }
    }
}

// MARK: - Data

@available(iOS 14.0, *)
extension SplitPicker {
    private var selectedItem: Item? {
        items.first { selection == $0.selection }
    }
}

// MARK: - Selection View

@available(iOS 14.0, *)
extension SplitPicker {
    private var selectionView: some View {
        Form {
            ForEach(items, id: \.self) {
                itemView(item: $0)
            }
        }
    }
}

// MARK: - Item View

@available(iOS 14.0, *)
extension SplitPicker {
    private func itemView(item: Item) -> some View {
        Button {
            selection = item.selection
            isLinkActive = false
        } label: {
            HStack {
                if showMultiLabels {
                    itemMultiLabelView(item: item)
                } else {
                    itemLabelView(item: item)
                }
                Spacer()
                if item == selectedItem {
                    Image(systemName: "checkmark")
                        .font(Font.body.weight(.semibold))
                        .foregroundColor(.accentColor)
                }
            }
            .contentShape(Rectangle())
        }
    }
}

// MARK: - Item Label View

@available(iOS 14.0, *)
extension SplitPicker {
    private func itemLabelView(item: Item) -> some View {
        HStack {
            Text(String(item.long))
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

@available(iOS 14.0, *)
extension SplitPicker {
    private func itemMultiLabelView(item: Item) -> some View {
        HStack {
            HStack {
                Text(String(item.short))
                    .foregroundColor(.primary)
                Spacer()
            }
            .frame(maxWidth: multiLabelWidth)
            Text(String(item.long))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
