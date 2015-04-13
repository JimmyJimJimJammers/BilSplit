//
//  ItemsWindow.swift
//  BilSplit
//
//  Created by James McCarthy on 4/1/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation
import UIKit
//UIViewController
class ItemsWindow: UIViewController, UITableViewDataSource, UITableViewDelegate//, UITableViewController
{
    @IBOutlet weak var EditItemsTable: UITableView!
    
    var editableItemsList : [EditableItem] = [];
    
    override func viewDidLoad()
    {
        super.viewDidLoad();
        //This should pull everything from the OCR into the editableItemsList array
        for var i = 0; i<finalReceipt.items.count; i++
        {
            editableItemsList.append(EditableItem(itemName: finalReceipt.items[i].name, price: finalReceipt.items[i].price, quantity: finalReceipt.items[i].quantity))
        }
        //self.editableItemsList = [EditableItem(itemName: "Buffalo Wings", price: 3.50, quantity: 2), EditableItem(itemName: "Chicken Fingers", price: 2.75, quantity: 1)];
        
        //EditItemsTable.dequeueReusableCellWithIdentifier()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.editableItemsList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: EditItemsCell = tableView.dequeueReusableCellWithIdentifier("EditItemCell", forIndexPath: indexPath) as! EditItemsCell
        var editItem : EditableItem;
        
        editItem = editableItemsList[indexPath.row];
        
        //cell.textLabel?.text = editItem.ItemName;
        cell.QuantityField.text = String(format: "%dx",editItem.Quantity);
        cell.ItemNameField.text = editItem.ItemName;
        cell.CostField.text = String(format: "$%.2f",editItem.Price);
        
        return cell;
    }
    
    
    
}