//
//  GoalsView.swift
//  FinancePlanner
//
//  Created by Fr1gat3 on 16.09.2025.
//

import SwiftUI

// Enum для керування станом табів "Active" / "Completed"
enum GoalStatus: String, CaseIterable {
    case active = "Active"
    case completed = "Completed"
}

struct GoalsView: View {
    // Стан для відстеження обраної вкладки
    @State private var selectedTab: GoalStatus = .active

    var body: some View {
        // NavigationView для відображення заголовка
        NavigationView {
            // ZStack дозволяє розмістити кнопку поверх списку
            ZStack(alignment: .bottomTrailing) {
                VStack {
                    // --- ПЕРЕМИКАЧ (PICKER) ---
                    Picker("Status", selection: $selectedTab) {
                        ForEach(GoalStatus.allCases, id: \.self) { status in
                            Text(status.rawValue).tag(status)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()

                    // --- ВІДОБРАЖЕННЯ КОНТЕНТУ ---
                    if selectedTab == .active {
                        ActiveGoalsListView()
                    } else {
                        CompletedGoalsPlaceholderView()
                    }
                }
                
                // --- ПЛАВАЮЧА КНОПКА "ADD" ---
                FloatingActionButton()
            }
            .navigationTitle("Goals")
            .background(Color(UIColor.systemGray6))
        }
    }
}


// MARK: - Reusable Components

// --- Список активних цілей ---
private struct ActiveGoalsListView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                GoalDetailCard(
                    iconName: "BussinesIcon",
                    title: "Business Goals",
                    currentAmount: 450,
                    totalAmount: 800,
                    dueDate: "Due: 25 Dec 2025",
                    color: .blue
                )
                
                GoalDetailCard(
                    iconName: "HeartIcon",
                    title: "Charity",
                    currentAmount: 820,
                    totalAmount: 1000,
                    dueDate: "Due: 28 Dec 2025",
                    color: .pink
                )
                
                // --- НОВА СЕКЦІЯ "PRO TIPS" ---
                ProTipsSection()
                    .padding(.top, 24) // Додаємо відступ зверху
            }
            .padding(.horizontal)
        }
    }
}

// --- Картка для детального відображення цілі ---
private struct GoalDetailCard: View {
    let iconName: String
    let title: String
    let currentAmount: Double
    let totalAmount: Double
    let dueDate: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Image(iconName)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(12)
                .background(color.opacity(0.1))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title).font(.headline).fontWeight(.bold)
                ProgressView(value: currentAmount, total: totalAmount).progressViewStyle(LinearProgressViewStyle(tint: color))
                HStack {
                    Text(String(format: "$%.0f", currentAmount)).font(.subheadline).foregroundColor(color).fontWeight(.bold)
                    Spacer()
                    Text(String(format: "$%.0f", totalAmount)).font(.subheadline).foregroundColor(.gray)
                }
                Text(dueDate).font(.caption).foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
}

// --- НОВА СЕКЦІЯ З ПОРАДАМИ ---
private struct ProTipsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Pro tips")
                .font(.title2)
                .fontWeight(.bold)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    TipCardView(
                        iconName: "sparkles",
                        title: "Save Small, Win Big",
                        description: "Set up automatic daily savings of just $1."
                    )
                    TipCardView(
                        iconName: "target",
                        title: "Set Clear Goals",
                        description: "A specific goal is more motivating to achieve."
                    )
                }
            }
        }
    }
}

// --- НОВА КАРТКА ДЛЯ ОДНІЄЇ ПОРАДИ ---
private struct TipCardView: View {
    let iconName: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(.blue)
                .padding(12)
                .background(Color.blue.opacity(0.1))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(description)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .frame(width: 280) // Задаємо ширину, щоб картки були однакові
    }
}


// --- Заглушка для виконаних цілей ---
private struct CompletedGoalsPlaceholderView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "checkmark.circle.fill").font(.system(size: 60)).foregroundColor(.green)
            Text("No Completed Goals Yet").font(.title2).fontWeight(.bold).padding(.top)
            Text("Once you complete a goal, it will appear here.").font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.center).padding(.horizontal)
            Spacer()
        }
    }
}

// --- Плаваюча кнопка ---
private struct FloatingActionButton: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "plus")
                .font(.title.weight(.semibold))
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 5, y: 5)
        }
        .padding()
    }
}


// --- PREVIEW ---
#Preview {
    GoalsView()
}
