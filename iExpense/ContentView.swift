//
//  ContentView.swift
//  iExpense
//
//  Created by Woodrow Martyr on 24/1/2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingAddExpense = false
    @State private var selectedType = "All"
    @State private var sortOrder = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]
    var filterTypes = ["Business", "Personal", "All"]
    
    var body: some View {
        NavigationStack {
            ExpensesView(selectType: selectedType, sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem {
                    Menu("Filter", systemImage: "filter") {
                        Picker("Type", selection: $selectedType) {
                            ForEach(filterTypes, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                ToolbarItem {
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by name")
                                .tag([
                                    SortDescriptor(\Expense.name),
                                    SortDescriptor(\Expense.amount)
                                ])
                            Text("Sort by amount")
                                .tag([
                                    SortDescriptor(\Expense.amount),
                                    SortDescriptor(\Expense.name)
                                ])
                        }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add Expense", systemImage: "plus") {
                        showingAddExpense.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView()
            }
        }
    }
}

#Preview {
    ContentView()
}
