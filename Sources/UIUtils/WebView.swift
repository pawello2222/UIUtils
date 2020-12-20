//
//  WebView.swift
//  UIUtils
//
//  Created by Pawel on 20/12/2020.
//  Copyright © 2020 Pawel Wiszenko. All rights reserved.
//

import SwiftUI
import WebKit

@available(iOS 13.0, *)
public struct WebView: UIViewRepresentable {
    @ObservedObject private var viewModel: ViewModel

    private let webView = WKWebView()

    public init(link: String, blockOutgoingRequests: Bool = false) {
        viewModel = ViewModel(link: link, blockOutgoingRequests: blockOutgoingRequests)
    }

    public func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        self.webView.navigationDelegate = context.coordinator
        if let url = URL(string: viewModel.link) {
            self.webView.load(URLRequest(url: url))
        }
        return self.webView
    }

    public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        return
    }

    public func makeCoordinator() -> WebView.Coordinator {
        .init(viewModel)
    }
}

@available(iOS 13.0, *)
public extension WebView {
    class Coordinator: NSObject, WKNavigationDelegate {
        private var viewModel: ViewModel

        public init(_ viewModel: ViewModel) {
            self.viewModel = viewModel
        }

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            viewModel.didFinishLoading = true
        }

        public func webView(
            _ webView: WKWebView,
            decidePolicyFor navigationAction: WKNavigationAction,
            decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
        ) {
            guard viewModel.blockOutgoingRequests else {
                decisionHandler(.allow)
                return
            }
            if let url = navigationAction.request.url {
                if url.absoluteString.contains(viewModel.link) {
                    decisionHandler(.allow)
                    return
                }
            }
            decisionHandler(.cancel)
        }
    }
}

@available(iOS 13.0, *)
public extension WebView {
    class ViewModel: ObservableObject {
        @Published public var link: String
        @Published public var blockOutgoingRequests: Bool
        @Published public var didFinishLoading = false

        public init(link: String, blockOutgoingRequests: Bool = false) {
            self.link = link
            self.blockOutgoingRequests = blockOutgoingRequests
        }
    }
}
