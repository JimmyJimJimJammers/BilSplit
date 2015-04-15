//
//  Item.swift
//  BilSplit
//
//  Created by Miguel Hummel on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation

class Item {
    var price: Double
    var quantity: Int
    var name: String
    
    init() {
        self.quantity = 1
        self.price = 0.0
        self.name = ""
    }
}