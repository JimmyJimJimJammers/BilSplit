//
//  ItemsWindow.swift
//  BilSplit
//
//  Created by James McCarthy on 4/1/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation
import UIKit

class ItemsWindow: UITableViewController
{
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("here\n")
        print(finalReceipt.total)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /*var editableItemsList : [EditableItem];
    override init()
    {
        editableItemsList = [];
        super.init();
    }
    init(itemList: [EditableItem])
    {
        editableItemsList = ViewControllerStartScreen.getReceipt();
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.editableItemsList.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        var editItem : EditableItem;
        
        editItem = editableItemsList[indexPath.row];
        
        cell.textLabel?.text = editItem.ItemName;
        
        
        return cell;
    }//*/
}