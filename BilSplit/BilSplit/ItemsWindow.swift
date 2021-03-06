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
class ItemsWindow: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate
{
    @IBOutlet weak var TaxField: UITextField!
    @IBOutlet weak var EditItemsTable: UITableView!
    
    var people: [Person] = [];
    var editableItemsList: [EditableItem] = []
    var colors: ColorPresets = ColorPresets();
    var historyList: [History] = [];
    var taxAmount: Double = 0;
    
    var totalItemsAssigned: Int = 0;
    var totalItems: Int = 0;
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard()
    {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad()
    {
        //for dismissing the keyboard when tapping elsewhere
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        
        
        super.viewDidLoad();
        //This should pull everything from the OCR into the editableItemsList array
        
        
        if (isEmpty(editableItemsList))
        {
            for var i = 0; i<finalReceipt.items.count; i++
            {
                editableItemsList.append(EditableItem(itemName: finalReceipt.items[i].name, price: finalReceipt.items[i].price, quantity: finalReceipt.items[i].quantity, assigned: 0));
            }
            
            /* need to populate tax text field from finalReceipt.tax which is type double*/
            
        }
        TaxField.text = String(format: "$%.2f", finalReceipt.tax);
        //self.editableItemsList = [EditableItem(itemName: "Buffalo Wings", price: 3.50, quantity: 2), EditableItem(itemName: "Chicken Fingers", price: 2.75, quantity: 1)];
        
        //EditItemsTable.dequeueReusableCellWithIdentifier()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "AddPeopleSegue")
        {
            var svc = segue.destinationViewController as! AddPeopleViewController;
            /*pull changed data here and save back into editableItemsList*/
            var passedEditableItemsList : [EditableItem] = [];
            var newTotal : Double = 0;
            var table = EditItemsTable.visibleCells()
            
            var tempTax: String = TaxField.text;
            tempTax = tempTax.stringByReplacingOccurrencesOfString("$", withString: "", options: nil, range: nil);
            tempTax = tempTax.stringByReplacingOccurrencesOfString(".", withString: "", options: nil, range: nil);
            
            taxAmount = Double(tempTax.toInt()!)/100.0;

            for(var i: Int = 0; i < table.count; i++)
            {
                let selectedCell = table[i] as! EditItemsCell
                var q = String(selectedCell.QuantityTextField.text)
                var n = String(selectedCell.ItemNameField.text)
                var p = String(selectedCell.CostField.text)
                var quantInt : Int = 0;
                var priceD : Double = 0;
                q = q.stringByReplacingOccurrencesOfString("x", withString: "", options: nil, range: nil);
                p = p.stringByReplacingOccurrencesOfString("$", withString: "", options: nil, range: nil);
                if let myNumber = NSNumberFormatter().numberFromString(q) {
                    quantInt = q.toInt()!;
                }
                if let myNumber = NSNumberFormatter().numberFromString(p) { //<- not sure if works with '.' in number
                    priceD = NSString(string: p).doubleValue;
                    newTotal = newTotal + priceD;
                }
                
                totalItems += q.toInt()!;
                
                passedEditableItemsList.append(EditableItem(itemName: n, price: priceD, quantity: quantInt, assigned: 0));
                
            }
            finalReceipt.total = newTotal;
            
            //For a commit
            
            //pull from tax text field here
            var savedTax = TaxField.text;
            savedTax = savedTax.stringByReplacingOccurrencesOfString("$", withString: "", options: nil, range: nil);
            var taxD : Double = 0;
            if let myNumber = NSNumberFormatter().numberFromString(savedTax) {
                taxD = NSString(string: savedTax).doubleValue;
            }
            
            finalReceipt.tax=taxD;
            
            svc.editableItemsList = passedEditableItemsList;
            svc.people = self.people;
            svc.historyList = self.historyList;
            svc.colors = self.colors;
            svc.totalItems = self.totalItems;
            svc.totalItemsAssigned = self.totalItemsAssigned;
            
        }
        
        if (segue.identifier == "AddItemsSegue")
        {
            var svc = segue.destinationViewController as! AddItemPopUpViewController;
            svc.historyList = self.historyList;
            svc.people = self.people;
            svc.colors = self.colors;
            svc.editableItemsList = self.editableItemsList;
            svc.totalItems = self.totalItems;
            svc.totalItemsAssigned = self.totalItemsAssigned;
        }
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
        cell.QuantityTextField.text = String(format: "%dx",editItem.Quantity);
        cell.ItemNameField.text = editItem.ItemName;
        cell.CostField.text = String(format: "$%.2f",editItem.Price);
        
        return cell;
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        var passedEditableItemsList : [EditableItem] = [];
        var table = EditItemsTable.visibleCells();
        var newTotal : Double = 0;
        
        for(var i: Int = 0; i < table.count; i++)
        {
            let selectedCell = table[i] as! EditItemsCell
            var q = String(selectedCell.QuantityTextField.text)
            var n = String(selectedCell.ItemNameField.text)
            var p = String(selectedCell.CostField.text)
            var quantInt : Int = 0;
            var priceD : Double = 0;
            q = q.stringByReplacingOccurrencesOfString("x", withString: "", options: nil, range: nil);
            p = p.stringByReplacingOccurrencesOfString("$", withString: "", options: nil, range: nil);
            if let myNumber = NSNumberFormatter().numberFromString(q) {
                quantInt = q.toInt()!;
            }
            if let myNumber = NSNumberFormatter().numberFromString(p) { //<- not sure if works with '.' in number
                priceD = NSString(string: p).doubleValue;
                newTotal = newTotal + priceD;
            }
            
            totalItems += q.toInt()!;
            
            
            passedEditableItemsList.append(EditableItem(itemName: n, price: priceD, quantity: quantInt, assigned: 0));
            
        }
        
        editableItemsList = passedEditableItemsList;

        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            editableItemsList.removeAtIndex(indexPath.row);
            finalReceipt.items.removeAtIndex(indexPath.row);
            EditItemsTable.reloadData();
            
        }
    }

    
    /*func textFieldShouldReturn(textField: UITextField!) -> Bool {
        self.view.endEditing(true)
        return false
    }*/
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
    
}