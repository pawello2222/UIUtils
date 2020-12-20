//
//  LabelButton.swift
//  UIUtils
//
//  Created by Pawel on 20/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct LabelButton: View {
    private let text: String
    private let imageName: String?
    private let imageSize: CGFloat
    private let color: Color

    public init(
        text: String,
        imageName: String? = nil,
        imageSize: CGFloat = 32,
        color: Color = .clear
    ) {
        self.text = text
        self.imageName = imageName
        self.imageSize = imageSize
        self.color = color
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
            Text(text)
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
