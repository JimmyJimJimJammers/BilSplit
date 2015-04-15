//
//  Receipt.swift
//  BilSplit
//
//  Created by Miguel Hummel on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation

class Receipt {
    var items: [Item]
    var total: Double
    var tax: Double
    
    init() {
        self.items = []
        self.total = 0.0
        self.tax = 0.0
    }
}