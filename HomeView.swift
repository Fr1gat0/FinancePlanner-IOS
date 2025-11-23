//
//  HomeView.swift
//  FinancePlanner
//
//  Created by Fr1gat3 on 14.09.2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            // Встановлюємо фоновий колір для всього екрану
            Color(UIColor.systemGray6).edgesIgnoringSafeArea(.all)

            // Весь контент, який можна прокручувати
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // --- ВЕРХНЯ ПАНЕЛЬ: ПРИВІТАННЯ ТА ІКОНКА ---
                    HeaderView()
                    
                    // --- КАРТКА ЗАГАЛЬНОГО БАЛАНСУ ---
                    TotalBalanceCard()
                    
                    // --- СЕКЦІЯ "GOALS" (ЦІЛІ) ---
                    // Саме тут студент бачить свій прогрес у накопиченні
                    GoalsSection()
                    
                    // --- СЕКЦІЯ "RECENT TRANSACTIONS" ---
                    RecentTransactionsSection()
                    
                }
                .padding()
            }
        }
    }
}

// MARK: - Reusable Components (Допоміжні View)

// --- Верхня панель з привітанням ---
struct HeaderView: View {
    var body: some View {
        HStack {
            HStack(spacing: 16) {
                Image("Photo") // Ваше фото профілю
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                
                VStack(alignment: .leading) {
                    Text("Hello,")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("Fr1gat3")
                        .font(.headline)
                        .fontWeight(.bold)
                }
            }
            Spacer()
            Image(systemName: "bell.fill")
                .font(.title2)
                .foregroundColor(.gray)
        }
    }
}

// --- Картка з загальним балансом ---
struct TotalBalanceCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Total Balance")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))
                Spacer()
                Image(systemName: "eye.slash.fill")
                    .foregroundColor(.white.opacity(0.8))
            }
            Text("$14,568.00")
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.white)
            Text("+12% from last month")
                .font(.footnote)
                .foregroundColor(.white.opacity(0.8))
        }
        .padding(20)
        .background(Color.blue)
        .cornerRadius(25)
    }
}

// --- Секція з цілями (Бізнес та Благодійність) ---
struct GoalsSection: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Goals")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button("See all") {}
                    .font(.headline)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    GoalCardView(iconName: "BussinesIcon", title: "Business", currentAmount: 450, totalAmount: 800)
                    GoalCardView(iconName: "HeartIcon", title: "Charity", currentAmount: 820, totalAmount: 1000, color: .pink)
                }
            }
        }
    }
}

// --- Картка для однієї цілі ---
struct GoalCardView: View {
    var iconName: String
    var title: String
    var currentAmount: Double
    var totalAmount: Double
    var color: Color = .blue

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(iconName)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(8)
                .background(color.opacity(0.1))
                .cornerRadius(12)
            
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
            
            ProgressView(value: currentAmount, total: totalAmount)
                .progressViewStyle(LinearProgressViewStyle(tint: color))
            
            HStack {
                Text(String(format: "$%.0f", currentAmount))
                    .foregroundColor(color)
                    .fontWeight(.bold)
                Spacer()
                Text(String(format: "$%.0f", totalAmount))
                    .foregroundColor(.gray)
            }
            .font(.footnote)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .frame(width: 180)
    }
}

// --- Секція з останніми транзакціями ---
struct RecentTransactionsSection: View {
    var body: some View {
        VStack {
            HStack {
                Text("Recent Transactions")
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                Button("See all") {}
                    .font(.headline)
            }
            .padding(.bottom, 10)
            
            VStack(spacing: 15) {
                TransactionRowView(iconName: "HeartIcon", title: "Donation", subtitle: "Charity", amount: -25, timestamp: "Today, 12:45 PM")
                TransactionRowView(iconName: "BussinesIcon", title: "Business", subtitle: "Freelance", amount: 1500, timestamp: "Yesterday, 3:30 PM")
            }
        }
    }
}

// --- Рядок для однієї транзакції ---
struct TransactionRowView: View {
    var iconName: String
    var title: String
    var subtitle: String
    var amount: Double
    var timestamp: String

    var body: some View {
        HStack(spacing: 15) {
            Image(iconName)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            
            VStack(alignment: .leading) {
                Text(title).fontWeight(.bold)
                Text(subtitle).font(.caption).foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(String(format: "%@$%.2f", amount > 0 ? "+" : "", amount))
                    .fontWeight(.bold)
                    .foregroundColor(amount > 0 ? .green : .primary)
                Text(timestamp).font(.caption).foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
    }
}

// --- PREVIEW ---
#Preview {
    HomeView()
}
