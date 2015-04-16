//
//  AssignItemsWindow.swift
//  BilSplit
//
//  Created by James McCarthy on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import UIKit

class AssignItemsWindow: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    var people: [Person] = [];
    var editableItemsList: [EditableItem] = []
    var colors: ColorPresets = ColorPresets();
    var currPerson: Person = Person();
    var currPersonIndex: Int = 0;
    var selected: [Bool] = [];
    var assignedQuantities: [Int] = [];
    
    var viableItemsList: [EditableItem] = []
    var originalIndex: [Int] = [];
    
    @IBOutlet weak var SelectItemTable: UITableView!
    @IBOutlet weak var TipTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("ViewDidLoad ran\n");
        
        for(var i: Int = 0; i < editableItemsList.count; i++)
        {
            if(editableItemsList[i].Quantity - editableItemsList[i].numAssigned > 0)
            {
                viableItemsList.append(editableItemsList[i]);
                selected.append(Bool(false));
                assignedQuantities.append(0);
                originalIndex.append(i);
            }
        }
        
        TipTextField.text = String(format: "%d%%", Int(people[currPersonIndex].tip*100));
        
        //print("Current Person: " + currPerson.name + "\n");
        //print(currPerson.name);
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return viableItemsList.count;
        //return editableItemsList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var item : EditableItem;
        item = viableItemsList[indexPath.row];
        //item = editableItemsList[indexPath.row];
        
        let cell: ItemSelectCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("AssignmentCell", forIndexPath: indexPath) as! ItemSelectCellTableViewCell
        
        if(assignedQuantities[indexPath.row] > (item.Quantity - item.numAssigned))
        {
            assignedQuantities[indexPath.row] = (item.Quantity - item.numAssigned);
        }
        
        cell.QuantityTextField.text = String(format: "%dx", assignedQuantities[indexPath.row]);
        cell.OutOfLabel.text = String(format: "/%d", (item.Quantity - item.numAssigned));
        cell.NameLabel.text = item.ItemName;
        cell.PriceLabel.text = String(format: "$%.2f", item.Price);
        
        if(selected[indexPath.row])
        {
            cell.Color1.backgroundColor = currPerson.color;
            var tempString: String = cell.QuantityTextField.text;
            tempString = tempString.stringByReplacingOccurrencesOfString("x", withString: "", options: nil, range: nil);
            print("Quantity for row: " + tempString + "\n");
            assignedQuantities[indexPath.row] = tempString.toInt()!;
        }
        else
        {
            //assignedQuantities[indexPath.row] = 0;
            cell.Color1.backgroundColor = UIColor.clearColor();
        }
        
        //cell.NameLabel.text = person.name;
        //cell.ColorLabel.backgroundColor = person.color;
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "DoneAssigningItemsSegue")
        {
            var svc = segue.destinationViewController as! SelectPersonViewController;
            
            //add the items the person signed up for to the data structure
            //for(var i: Int = 0; i < editableItemsList.count; i++)
            for(var i: Int = 0; i < viableItemsList.count; i++)
            {
                if(selected[i])
                {
                    var tempItem: EditableItem = editableItemsList[originalIndex[i]];
                    tempItem.Quantity = assignedQuantities[i];
                    people[currPersonIndex].items.append(tempItem);
                    //currPerson.items.append(tempItem);
                    editableItemsList[originalIndex[i]].numAssigned += assignedQuantities[i];
                }
            }
            
        var tipString = TipTextField.text;
        tipString = tipString.stringByReplacingOccurrencesOfString("%", withString: "", options: nil, range: nil);
            
            people[currPersonIndex].tip = (0.01 * Double(tipString.toInt()!));
            
            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
            
        }
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    {
        //var item: EditableItem = editableItemsList[indexPath.row];
        var item: EditableItem = viableItemsList[indexPath.row];
        selected[indexPath.row] = !selected[indexPath.row];
        
        var table = SelectItemTable.visibleCells()

        for(var i: Int = 0; i < table.count; i++)
        {
            let selectedCell = table[i] as! ItemSelectCellTableViewCell
            var q = String(selectedCell.QuantityTextField.text)
            q = q.stringByReplacingOccurrencesOfString("x", withString: "", options: nil, range: nil);
            assignedQuantities[i] = q.toInt()!;
        }
        self.SelectItemTable.reloadData();
    }
    
}
