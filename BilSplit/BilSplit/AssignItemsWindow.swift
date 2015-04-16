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
    
    @IBOutlet weak var TipTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return editableItemsList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: ItemSelectCellTableViewCell = tableView.dequeueReusableCellWithIdentifier("AssignmentCell", forIndexPath: indexPath) as! ItemSelectCellTableViewCell
        
        var item : EditableItem;
        item = editableItemsList[indexPath.row];
        
        cell.QuantityTextField.text = "1x";
        cell.OutOfLabel.text = String(format: "/%d", item.Quantity);
        cell.NameLabel.text = item.ItemName;
        cell.PriceLabel.text = String(format: "$%.2f", item.Price);
        
        //cell.NameLabel.text = person.name;
        //cell.ColorLabel.backgroundColor = person.color;
        return cell;
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "DoneAssigningItemsSegue")
        {
            var svc = segue.destinationViewController as! SelectPersonViewController;
            
            svc.editableItemsList = self.editableItemsList;
            svc.people = self.people;
            svc.colors = self.colors;
        }
    }
    
    
}
