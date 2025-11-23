//
//  ChatView.swift
//  FinancePlanner
//
//  Created by Fr1gat3 on 16.09.2025.
//

import SwiftUI

// MARK: - Message Data Model
struct Message: Identifiable, Equatable {
    let id = UUID()
    let text: String
    let isFromUser: Bool
}

// MARK: - Chat View
struct ChatView: View {
    @State private var messages: [Message] = [
        Message(text: "Hello! I'm your financial assistant. How can I help you today?", isFromUser: false)
    ]
    @State private var userInput: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // --- Верхня панель ---
            AIChatHeaderView()
            
            // --- Область для повідомлень ---
            ScrollViewReader { scrollViewProxy in
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(messages) { message in
                            MessageBubble(message: message)
                                .id(message.id)
                        }
                    }
                    .padding()
                }
                .onChange(of: messages) { // <-- НОВИЙ, ПРАВИЛЬНИЙ СИНТАКСИС
                    // Автоматично прокручуємо до останнього повідомлення
                    if let lastMessage = messages.last {
                        withAnimation {
                            scrollViewProxy.scrollTo(lastMessage.id, anchor: .bottom)
                        }
                    }
                }
            }
            
            // --- Поле вводу та кнопка "Send" ---
            InputBar(userInput: $userInput, onSend: sendMessage)
        }
        .background(Color(UIColor.systemGray6))
        .navigationBarHidden(true)
    }
    
    private func sendMessage() {
        guard !userInput.isEmpty else { return }
        
        let userMessage = Message(text: userInput, isFromUser: true)
        messages.append(userMessage)
        userInput = ""
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let aiResponse = Message(text: "This is a simulated AI response. I've received your message: '\(userMessage.text)'", isFromUser: false)
            messages.append(aiResponse)
        }
    }
}


// MARK: - Reusable Components

private struct AIChatHeaderView: View {
    var body: some View {
        HStack {
            Text("AI Assistant")
                .font(.title2)
                .fontWeight(.bold)
            Spacer()
            Image("AiAssistantIcon")
                .resizable()
                .renderingMode(.template)
                .foregroundColor(.blue)
                .frame(width: 28, height: 28)
        }
        .padding()
        .background(Color.white)
        .shadow(radius: 1)
    }
}

private struct MessageBubble: View {
    let message: Message
    
    var body: some View {
        HStack {
            if message.isFromUser {
                Spacer()
            }
            
            Text(message.text)
                .padding(12)
                .background(message.isFromUser ? Color.blue : Color.white)
                .foregroundColor(message.isFromUser ? .white : .primary)
                .cornerRadius(20)
            
            if !message.isFromUser {
                Spacer()
            }
        }
    }
}

private struct InputBar: View {
    @Binding var userInput: String
    let onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("Ask something...", text: $userInput)
                .padding(12)
                .background(Color.white)
                .cornerRadius(25)
            
            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.blue)
            }
            .disabled(userInput.isEmpty)
        }
        .padding()
        .background(Color(UIColor.systemGray5))
    }
}


// MARK: - Preview
#Preview {
    ChatView()
}
