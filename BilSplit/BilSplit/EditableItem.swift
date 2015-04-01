//
//  EditableItem.swift
//  BilSplit
//
//  Created by James McCarthy on 4/1/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation

class EditableItem
{
    var ItemName: String;
    var Price: Double;
    var Quantity: Int;
    init(itemName: String, price: Double, quantity: Int)
    {
        ItemName = itemName;
        Price = price;
        Quantity = quantity;
    }
    init()
    {
        ItemName = "NULL";
        Price = 0.0;
        Quantity = 0;
    }
}