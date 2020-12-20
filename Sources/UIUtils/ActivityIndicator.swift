//
//  BackgroundNavigationLink.swift
//  UIUtils
//
//  Created by Pawel on 21/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI

/// Taken from: https://stackoverflow.com/questions/56496638/activity-indicator-in-swiftui/59171234#59171234
@available(iOS 13.0, *)
public struct ActivityIndicator: View {
    @State private var isAnimating: Bool = false
    
    public init() {}

    public var body: some View {
        GeometryReader { geometry in
            ForEach(0 ..< 5) { index in
                circleGroup(geometrySize: geometry.size, index: index)
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            isAnimating = true
        }
    }
}

@available(iOS 13.0, *)
private extension ActivityIndicator {
    func circleGroup(geometrySize: CGSize, index: Int) -> some View {
        Group {
            circle(geometrySize: geometrySize, index: index)
        }
        .frame(width: geometrySize.width, height: geometrySize.height)
        .rotationEffect(!isAnimating ? .degrees(0) : .degrees(360))
        .animation(
            Animation
                .timingCurve(0.5, 0.15 + Double(index) / 5, 0.25, 1, duration: 1.5)
                .repeatForever(autoreverses: false),
            value: isAnimating
        )
    }

    func circle(geometrySize: CGSize, index: Int) -> some View {
        Circle()
            .frame(width: geometrySize.width / 5, height: geometrySize.height / 5)
            .scaleEffect(!isAnimating ? 1 - CGFloat(index) / 5 : 0.2 + CGFloat(index) / 5)
            .offset(y: geometrySize.width / 10 - geometrySize.height / 2)
    }
}
