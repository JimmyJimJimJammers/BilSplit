//
//  SummaryWindow.swift
//  BilSplit
//
//  Created by James McCarthy on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import UIKit

class SummaryWindow: UIViewController
{
    
    var people: [Person] = [];
    var editableItemsList: [EditableItem] = []
    var colors: ColorPresets = ColorPresets();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return editableItemsList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: SummaryTableCell = tableView.dequeueReusableCellWithIdentifier("IndividualTotalCells", forIndexPath: indexPath) as! SummaryTableCell
        
        var person :Person;
        person = people[indexPath.row];
        
        //cell.QuantityTextField.text = "0x";
        
        //cell.NameLabel.text = person.name;
        //cell.ColorLabel.backgroundColor = person.color;
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        /*if (segue.identifier == "DoneAssigningItemsSegue")
        {
        var svc = segue.destinationViewController as! SelectPersonViewController;
        
        svc.editableItemsList = self.editableItemsList;
        svc.people = self.people;
        svc.colors = self.colors;
        }*/
    }
    
}