//
//  ContentView.swift
//  Nexora iOS
//
//  Created by Никита Струкалин on 15.11.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var SearchText: String = ""
    @State private var SearchEngine: String = "Google"
    
    var body: some View {
        VStack() {
            Button("⚙️") {
                
            }
            .frame(width: 40)
            .buttonStyle(.glassProminent)
            .padding(.top, -340)
            .padding(.leading, 300)
            
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
                
            }
            .buttonStyle(.glassProminent)
            .frame(height: 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.yellow.opacity(0.2))
    }
    
}

#Preview {
    ContentView()
}
