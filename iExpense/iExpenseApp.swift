//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Woodrow Martyr on 24/1/2024.
//

import SwiftData
import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}

