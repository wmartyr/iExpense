//
//  Expense.swift
//  iExpense
//
//  Created by Woodrow Martyr on 28/7/2024.
//

import Foundation
import SwiftData

@Model
class Expense {
    var name: String
    var type: String
    var amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
}
