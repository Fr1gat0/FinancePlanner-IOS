//
//  SignUpView.swift
//  FinancePlanner
//
//  Created by Fr1gat3 on 15.09.2025.
//

import SwiftUI

struct SignUpView: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    
    // 1. Новий, сучасний спосіб закрити екран
    @Environment(\.dismiss) var dismiss
    
    // 2. Приймаємо `navigationPath` від попереднього екрану
    @Binding var navigationPath: [String]

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // ... (код заголовків та полів вводу - без змін) ...
                Text("Create Account").font(.largeTitle).fontWeight(.bold).padding(.top, 40)
                Text("Start your Financial journey today").font(.subheadline).foregroundColor(.gray).padding(.bottom, 30)
                HStack {
                    Image(systemName: "person").foregroundColor(.gray).padding(.leading)
                    TextField("Enter your full name", text: $fullName).padding(.vertical)
                }.background(Color(.systemGray6)).cornerRadius(28).padding(.horizontal)
                HStack {
                    Image(systemName: "envelope").foregroundColor(.gray).padding(.leading)
                    TextField("Enter your email", text: $email).padding(.vertical).keyboardType(.emailAddress).textInputAutocapitalization(.never)
                }.background(Color(.systemGray6)).cornerRadius(28).padding(.horizontal)
                HStack {
                    Image(systemName: "lock").foregroundColor(.gray).padding(.leading)
                    SecureField("Enter your password", text: $password).padding(.vertical)
                    Image(systemName: "eye.slash").foregroundColor(.gray).padding(.trailing)
                }.background(Color(.systemGray6)).cornerRadius(28).padding(.horizontal)
                
                // --- ОНОВЛЕНА КНОПКА "Sign Up" ---
                Button(action: {
                    isLoading = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isLoading = false
                        // 3. ПОВНІСТЮ ЗАМІНЮЄМО стек навігації на головний екран.
                        // Це не дасть користувачу повернутись назад на екран логіну.
                        navigationPath = ["HomeView"]
                    }
                }) {
                    if isLoading {
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text("Sign Up").font(.headline).foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(28)
                .disabled(isLoading)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // ... (решта коду - без змін) ...
                HStack {
                    VStack { Divider().background(Color.gray) }
                    Text("Or sign up with").font(.footnote).foregroundColor(.gray).padding(.horizontal, 5)
                    VStack { Divider().background(Color.gray) }
                }.padding(.horizontal).padding(.top, 20)
                HStack(spacing: 20) {
                    Button(action: { }) { Image("google_logo").resizable().scaledToFit().frame(width: 24, height: 24).padding() }.frame(maxWidth: .infinity).background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                    Button(action: { }) { Image(systemName: "apple.logo").resizable().scaledToFit().frame(width: 24, height: 24).foregroundColor(.primary).padding() }.frame(maxWidth: .infinity).background(RoundedRectangle(cornerRadius: 16).stroke(Color.gray.opacity(0.5), lineWidth: 1))
                }.padding(.horizontal)
                Spacer()
                
                // --- ОНОВЛЕНА КНОПКА "Sign In" (повернутись назад) ---
                HStack {
                    Text("Already have an account?")
                    Button("Sign In") {
                        // 4. Викликаємо дію закриття
                        dismiss()
                    }
                }
                .padding(.bottom).padding(.top, 20)
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

// У Preview тепер потрібно передати "фейковий" шлях, щоб він не видавав помилку

#Preview {
    // Створюємо "фейковий" постійний біндінг,
    // щоб попередній перегляд міг працювати.
    SignUpView(navigationPath: .constant([]))
}
