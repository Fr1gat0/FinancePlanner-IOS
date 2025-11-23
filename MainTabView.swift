//
//  MainTabView.swift
//  FinancePlanner
//
//  Created by Fr1gat3 on 15.09.2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // --- Перша вкладка: Home ---
            HomeView()
                .tabItem {
                    Image("HomeIcon")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("Home")
                }
            
            // --- Друга вкладка: Chat ---
            ChatView() // <-- Назва має бути ChatView
                .tabItem {
                    Image("ChatIcon")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("Chat")
                }

            // --- Третя вкладка: Goals ---
            GoalsView()
                .tabItem {
                    Image("BusinessGoalsIcon")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text("Goals")
                }
            
            // --- Четверта вкладка: Settings ---
            SettingsView()
                .tabItem {
                    Image("SettingsIcon")
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .offset(y: 1.5)
                    Text("Settings")
                }
        }
        .tint(.blue)
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

#Preview {
    MainTabView()
}
