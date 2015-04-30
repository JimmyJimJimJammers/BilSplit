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
    var numAssigned: Int;
    
    init(itemName: String, price: Double, quantity: Int, assigned: Int)
    {
        ItemName = itemName;
        Price = price;
        Quantity = quantity;
        numAssigned = assigned;
    }
    init()
    {
        ItemName = "NULL";
        Price = 0.0;
        Quantity = 0;
        numAssigned = 0;
    }
    func printItem()
    {
        print(ItemName);
        print(": ");
        print(String(format: "$%.2f" , Price));
        print(" ");
        print(String(numAssigned));
        print("/");
        print(String(Quantity));
        print("\n");
        
    }
}