//
//  ExpensesView.swift
//  iExpense
//
//  Created by Woodrow Martyr on 5/8/2024.
//

import SwiftData
import SwiftUI

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]
    
    var body: some View {
        List {
            ForEach(expenses) { expense in
                NavigationLink(value: expense) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(expense.name)
                                .font(.headline)
                            Text(expense.type)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        Text(expense.amount,format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
            }
            .onDelete(perform: removeExpense)
        }
    }

    init(selectType: String, sortOrder: [SortDescriptor<Expense>]) {
        _expenses = Query(filter: #Predicate<Expense> { expense in
            selectType == "All" ? true : expense.type == selectType
        }, sort:sortOrder)
    }

    func removeExpense(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpensesView(selectType: "All", sortOrder: [SortDescriptor(\Expense.name)])
        .modelContainer(for: Expense.self)
}
