//
//  ContentView.swift
//  iExpense
//
//  Created by Woodrow Martyr on 24/1/2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(item.type)
                                        .foregroundStyle(.white)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(.white)
                            }
                            .listRowBackground(item.amount > 10 ? (item.amount > 100 ? Color.red : Color.blue) : Color.green)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                .headerProminence(.increased)
            }
            List {
                Section("Business") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack {
                                    Text(item.name)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(item.type)
                                        .foregroundStyle(.white)
                                }
                                Spacer()
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundStyle(.white)
                            }
                            .listRowBackground(item.amount > 10 ? (item.amount > 100 ? Color.red : Color.blue) : Color.green)
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                .headerProminence(.increased)
            }
            NavigationLink("Add Expense") {
                AddView(expenses: expenses)
            }
            .navigationTitle("iExpense")
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
