//
//  SettingsView.swift
//  FinancePlanner
//
//  Created by Fr1gat3 on 16.09.2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            // Form - ідеальний контейнер для екранів налаштувань
            Form {
                // --- СЕКЦІЯ 1: ІНФОРМАЦІЯ ПРО КОРИСТУВАЧА ---
                Section {
                    UserInfoView()
                }
                
                // --- СЕКЦІЯ 2: ЗАГАЛЬНІ НАЛАШТУВАННЯ ---
                Section(header: Text("General")) {
                    SettingsRow(iconName: "IconMyProfile", title: "My Profile", iconColor: .blue)
                    SettingsRow(iconName: "IconLanguage", title: "Language", iconColor: .orange)
                    SettingsRow(iconName: "IconAppearance", title: "Appearance", iconColor: .purple)
                }
                
                // --- СЕКЦІЯ 3: БЕЗПЕКА ---
                Section(header: Text("Security")) {
                    SettingsRow(iconName: "IconPrivacy", title: "Privacy Policy", iconColor: .red)
                    SettingsRow(iconName: "IconNotifications", title: "Notifications", iconColor: .green)
                }
                
                // --- СЕКЦІЯ 4: ПРО ДОДАТОК ---
                Section(header: Text("About")) {
                    SettingsRow(iconName: "IconFAQ", title: "FAQ", iconColor: .yellow)
                    SettingsRow(iconName: "IconAsk", title: "Contact Us", iconColor: .mint)
                }
                
                // --- СЕКЦІЯ 5: КНОПКА ВИХОДУ ---
                Section {
                    SignOutButton()
                }
            }
            .navigationTitle("Settings")
        }
    }
}

// MARK: - Reusable Components

// --- Верхня секція з інформацією про користувача ---
private struct UserInfoView: View {
    var body: some View {
        HStack(spacing: 16) {
            Image("Photo") // Ваше фото профілю
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Fr1gat3")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("frigate@example.com")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

// --- Рядок для одного налаштування ---
private struct SettingsRow: View {
    let iconName: String
    let title: String
    let iconColor: Color
    
    var body: some View {
        // NavigationLink, щоб показати, що на рядок можна натиснути
        NavigationLink(destination: Text("\(title) Screen")) {
            HStack(spacing: 16) {
                Image(iconName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 22, height: 22)
                    .padding(6)
                    .background(iconColor)
                    .cornerRadius(8)
                
                Text(title)
            }
        }
    }
}

// --- Кнопка виходу з акаунту ---
private struct SignOutButton: View {
    var body: some View {
        Button(action: {
            // Дія для виходу з акаунту
        }) {
            HStack(spacing: 16) {
                Image("SignOutOfAccountIcon")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(.white)
                    .frame(width: 22, height: 22)
                    .padding(6)
                    .background(Color.red)
                    .cornerRadius(8)
                
                Text("Sign Out of Account")
                    .foregroundColor(.red) // Червоний колір для тексту
            }
        }
    }
}


// --- PREVIEW ---
#Preview {
    SettingsView()
}
