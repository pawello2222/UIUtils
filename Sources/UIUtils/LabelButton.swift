//
//  LabelButton.swift
//  UIUtils
//
//  Created by Pawel on 20/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct LabelButton<Label>: View where Label: View {
    private let imageName: String?
    private let imageSize: CGFloat
    private let color: Color
    private let label: () -> Label

    public init(
        imageName: String? = nil,
        imageSize: CGFloat = 32,
        color: Color = .clear,
        label: @escaping () -> Label
    ) {
        self.imageName = imageName
        self.imageSize = imageSize
        self.color = color
        self.label = label
    }

    public init(
        imageName: String? = nil,
        imageSize: CGFloat = 32,
        color: Color = .clear,
        label: @autoclosure @escaping () -> Label
    ) {
        self.init(imageName: imageName, imageSize: imageSize, color: color, label: label)
    }

    public init(
        text: String,
        imageName: String? = nil,
        imageSize: CGFloat = 32,
        color: Color = .clear
    ) where Label == Text {
        self.init(imageName: imageName, imageSize: imageSize, color: color) {
            Text(text)
        }
    }

    public var body: some View {
        HStack {
            if let imageName = imageName {
                RoundedRectangle(cornerRadius: 5)
                    .fill(color)
                    .frame(width: imageSize, height: imageSize)
                    .overlay(
                        Image(systemName: imageName)
                            .foregroundColor(.white)
                    )
                    .padding(.trailing, 2)
            }
            label()
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .imageScale(.small)
                .font(Font.body.weight(.semibold))
                .foregroundColor(Color(.darkGray))
        }
        .contentShape(Rectangle())
    }
}
