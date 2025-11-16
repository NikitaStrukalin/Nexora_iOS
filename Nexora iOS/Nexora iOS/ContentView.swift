//
//  ContentView.swift
//  Nexora iOS
//
//  Created by Никита Струкалин on 15.11.2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var ShowKit: Bool = false
    @State private var ShowSettings: Bool = false
    @State private var ShowTabs: Bool = false
    @State private var currentURL: String = "https://www.google.com"
    @State private var SearchText: String = ""
    @State private var SearchEngine: String = "Google"
    @State private var hideCookies = false
    
    var body: some View {
        if ShowKit {
            WebView(searchText: SearchText, displayedURL: $currentURL)
            
            Button(formatURL(currentURL)) {
                UIPasteboard.general.string = currentURL
            }
            .buttonStyle(.glass)
        }
        
        if ShowKit == false {
            VStack() {
                Button("⚙️") {
                    
                }
                .frame(width: 40)
                .buttonStyle(.glassProminent)
                .padding(.top, -340)
                .padding(.leading, 300)
                
                Button("🗂") {
                    
                }
                .frame(width: 40)
                .padding(.top, -346)
                .padding(.leading, -170)
                .buttonStyle(.glassProminent)
                
                Text("Nexora")
                    .font(.system(size: 50))
                    .frame(height: 2)
                    .fontWeight(.bold)
                    .padding(.top, -40)
                
                TextField("Введите запрос...", text: $SearchText)
                    .font(.system(size: 18))
                    .padding(5)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(5)
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    .frame(width: 300, height: 50)
                
                Button("Поиск🔎"){
                    ShowKit = true
                }
                .buttonStyle(.glassProminent)
                .frame(height: 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(colorScheme == .dark ? .black : .yellow.opacity(0.2))
        }
    }
    private func formatURL(_ url: String) -> String {
           // Если URL пустой, возвращаем заглушку
           guard !url.isEmpty else { return "Нет ссылки" }
           
           // Если это Google поиск, показываем запрос
           if url.contains("google.com/search") {
               if let queryRange = url.range(of: "q=") {
                   let query = String(url[queryRange.upperBound...])
                   if let endIndex = query.firstIndex(of: "&") {
                       let searchQuery = String(query[..<endIndex])
                       let decodedQuery = searchQuery.removingPercentEncoding ?? searchQuery
                       return "Поиск: \(decodedQuery)"
                   } else {
                       let decodedQuery = query.removingPercentEncoding ?? query
                       return "Поиск: \(decodedQuery)"
                   }
               }
           }
           
           // Для обычных URL показываем домен и путь
           if let urlComponents = URL(string: url) {
               let host = urlComponents.host ?? ""
               let path = urlComponents.path
               
               if path.isEmpty || path == "/" {
                   return host
               } else {
                   // Обрезаем длинный путь
                   if path.count > 15 {
                       return host + path.prefix(15) + "..."
                   } else {
                       return host + path
                   }
               }
           }
           
           return url
       }
}

#Preview {
    ContentView()
}
