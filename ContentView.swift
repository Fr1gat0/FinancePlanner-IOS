//
//  ContentView.swift
//  FinancePlanner
//
//  Created by Fr1gat3 on 14.09.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    
    // 1. Стан для нового NavigationStack. Ми будемо додавати сюди маршрути.
    @State private var navigationPath = [String]()

    var body: some View {
        // 2. ЗАМІНЮЄМО NavigationView на NavigationStack
        NavigationStack(path: $navigationPath) {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // ... (код логотипу, заголовків, полів вводу - без змін) ...
                    Image("Smile").resizable().scaledToFit().frame(width: 120, height: 120).padding(.top, 40).padding(.bottom, 20)
                    Text("Join FinanceHub").font(.largeTitle).fontWeight(.bold)
                    Text("Start your Financial journey today").font(.subheadline).foregroundColor(.gray).padding(.bottom, 30)
                    HStack {
                        Image(systemName: "envelope").foregroundColor(.gray).padding(.leading)
                        TextField("Enter your email", text: $email).padding(.vertical).keyboardType(.emailAddress).textInputAutocapitalization(.never)
                    }.background(Color(.systemGray6)).cornerRadius(28).padding(.horizontal)
                    HStack {
                        Image(systemName: "lock").foregroundColor(.gray).padding(.leading)
                        SecureField("Enter your password", text: $password).padding(.vertical)
                        Image(systemName: "eye.slash").foregroundColor(.gray).padding(.trailing)
                    }.background(Color(.systemGray6)).cornerRadius(28).padding(.horizontal)
                    HStack {
                        Spacer()
                        Button("Forgot Password?") {}.font(.footnote).padding(.horizontal)
                    }

                    // --- ОНОВЛЕНА КНОПКА "Sign In" ---
                    Button(action: {
                        isLoading = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isLoading = false
                            // ПОВНІСТЮ ЗАМІНЮЄМО стек навігації на головний екран.
                            navigationPath = ["HomeView"] // <-- ОСЬ ЦЕЙ РЯДОК
                        }
                    }) {
                        if isLoading {
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Sign In").font(.headline).foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(28)
                    .disabled(isLoading)
                    .padding(.horizontal)
                    
                    // ... (код "Or sign in with" та соц. кнопок - без змін) ...
                    HStack {
                        VStack { Divider().background(Color.gray) }
                        Text("Or sign in with").font(.footnote).foregroundColor(.gray).padding(.horizontal, 5)
                        VStack { Divider().background(Color.gray) }
                    }.padding(.horizontal).padding(.top, 20)
                    HStack(spacing: 20) {
                        Button(action: { }) { Image("google_logo").resizable().scaledToFit().frame(width: 24, height: 24).padding() }.frame(maxWidth: .infinity).background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                        Button(action: { }) { Image(systemName: "apple.logo").resizable().scaledToFit().frame(width: 24, height: 24).foregroundColor(.primary).padding() }.frame(maxWidth: .infinity).background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    }.padding(.horizontal)
                    Spacer()
                    
                    // --- ОНОВЛЕНЕ ПОСИЛАННЯ "Sign Up" ---
                    HStack {
                        Text("Don't have an account?")
                        // 4. Тепер посилання просто вказує "значення" маршруту
                        NavigationLink("Sign Up", value: "SignUpView")
                    }
                    .padding(.bottom).padding(.top, 20)
                }
            }
            // 5. Цей модифікатор вказує, який View відкривати для якого маршруту
            .navigationDestination(for: String.self) { route in
                if route == "SignUpView" {
                    SignUpView(navigationPath: $navigationPath)
                } else if route == "HomeView" { // Залишаємо назву маршруту, але міняємо View
                    MainTabView()
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
