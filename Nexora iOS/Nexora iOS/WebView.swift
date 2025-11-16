//
//  WebView.swift
//  Nexora iOS
//
//  Created by Никита Струклин on 15.11.2025.
//

import SwiftUI
import WebKit

public struct WebView: View {
    let searchText: String
    @State private var currentURL: String = "https://www.google.com"
    @Binding var displayedURL: String // Добавляем binding для передачи URL обратно
    
    public init(searchText: String, displayedURL: Binding<String>) {
        self.searchText = searchText
        self._displayedURL = displayedURL
    }
    
    public var body: some View {
        WebViewRepresentable(url: $currentURL, displayedURL: $displayedURL)
            .onAppear {
                loadURL()
            }
            .onChange(of: searchText) {
                loadURL()
            }
    }
    
    private func loadURL() {
        if searchText.isEmpty {
            currentURL = "https://www.google.com"
        } else {
            let encodedQuery = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            currentURL = "https://www.google.com/search?q=\(encodedQuery)"
        }
        displayedURL = currentURL // Обновляем отображаемый URL
    }
}

struct WebViewRepresentable: UIViewRepresentable {
    @Binding var url: String
    @Binding var displayedURL: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let urlObject = URL(string: url) else { return }
        let request = URLRequest(url: urlObject)
        webView.load(request)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewRepresentable
        
        init(_ parent: WebViewRepresentable) {
            self.parent = parent
        }
        
        // Отслеживаем изменения URL при навигации
        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            if let currentURL = webView.url?.absoluteString {
                parent.displayedURL = currentURL
            }
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            if let currentURL = webView.url?.absoluteString {
                parent.displayedURL = currentURL
            }
        }
    }
}
