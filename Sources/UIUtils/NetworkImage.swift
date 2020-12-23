//
//  NetworkImage.swift
//  UIUtils
//
//  Created by Pawel on 23/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import Combine
import SwiftUI

@available(iOS 14.0, *)
public struct NetworkImage: View {
    @StateObject private var viewModel = ViewModel()

    private let url: URL?

    public init(url: URL?) {
        self.url = url
    }

    public var body: some View {
        Group {
            if let data = viewModel.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
            } else if viewModel.isLoading {
                ProgressView()
            } else {
                Image(systemName: "photo")
            }
        }
        .onAppear {
            viewModel.loadImage(from: url)
        }
    }
}

@available(iOS 14.0, *)
public extension NetworkImage {
    class ViewModel: ObservableObject {
        @Published public var imageData: Data?
        @Published public var isLoading = false

        private static let cache = NSCache<NSURL, NSData>()

        private var cancellables = Set<AnyCancellable>()

        public func loadImage(from url: URL?) {
            isLoading = true
            guard let url = url else {
                isLoading = false
                return
            }
            if let data = Self.cache.object(forKey: url as NSURL) {
                imageData = data as Data
                isLoading = false
                return
            }
            URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in
                    if let data = $0 {
                        Self.cache.setObject(data as NSData, forKey: url as NSURL)
                        self?.imageData = data
                    }
                    self?.isLoading = false
                }
                .store(in: &cancellables)
        }
    }
}
