//
//  SummaryWindow.swift
//  BilSplit
//
//  Created by James McCarthy on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import UIKit

class SummaryWindow: UIViewController, NSCoding
{
    
    var people: [Person] = [];
    var editableItemsList: [EditableItem] = []
    var colors: ColorPresets = ColorPresets();
    @IBOutlet weak var RestaurantTextField: UITextField!
    @IBOutlet weak var TotalLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var total: Double = 0;
        
        for(var i: Int = 0; i < people.count; i++)
        {
            var subTotal: Double = 0;
            for(var j: Int = 0; j < people[i].items.count; j++)
            {
                subTotal += people[i].items[j].Price;
            }
            total += (subTotal + (subTotal * people[i].tip));
        }
        
        TotalLabel.text = String(format: "$%.2f", total);
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return people.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: SummaryTableCell = tableView.dequeueReusableCellWithIdentifier("IndividualTotalCells", forIndexPath: indexPath) as! SummaryTableCell
        
        var person :Person;
        person = people[indexPath.row];
        
        cell.Name.text = person.name;
        var total: Double = 0;
        for(var i: Int = 0; i < person.items.count; i++)
        {
            total += person.items[i].Price;
        }
        total += total*person.tip;
        
        cell.Total.text = String(format: "$%.2f", total);
        cell.Color.backgroundColor = person.color;
        
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
        
        if(segue.identifier == "SaveHistorySegue")
        {
            var svc = segue.destinationViewController as! ViewControllerStartScreen;
            
            var loc : String = RestaurantTextField.text
            
            
            //string history class
            var temp = loc + "==";
            temp = temp + String(format: "%.2f", finalReceipt.total) + "==";
            temp = temp + String(format: "%.2f", finalReceipt.tax) + "== ::";
            
            for(var i=0; i<people.count; i++){
                temp = temp + "::";
                temp = temp + people[i].name + "[]";
                //temp = temp + people[i].color + "[]";// <--color bullshit
                var r:CGFloat = 0;
                var g:CGFloat = 0;
                var b:CGFloat = 0;
                var a:CGFloat = 0;
                var myColor = people[i].color;
                myColor.getRed(&r, green: &g, blue: &b, alpha: &a);
                temp = temp + r.description + " " + g.description + " " + b.description + " " + a.description + "[]"
                temp = temp + people[i].email + "[]";
                temp = temp + people[i].phone + "[]";
                temp = temp + String(format: "%d", people[i].tip) + "{}";
                for(var j=0; j<people[i].items.count; j++){
                    temp = temp + people[i].items[j].ItemName + "&&";
                    temp = temp + String(format: "%.2f", people[i].items[j].Price) + "&&";
                    temp = temp + String(format: "%d", people[i].items[j].Quantity) + "&&";
                    temp = temp + String(format: "%d", people[i].items[j].numAssigned) + "()";
                    
                }
            }
            
            
            let filemgr = NSFileManager.defaultManager()
            let dirPaths =
            NSSearchPathForDirectoriesInDomains(.DocumentDirectory,
                .UserDomainMask, true)
            
            let docsDir = dirPaths[0] as! String
            dataFilePath =
                docsDir.stringByAppendingPathComponent("data.archive")
            
            if filemgr.fileExistsAtPath(dataFilePath!) {
                var dataArray =
                NSKeyedUnarchiver.unarchiveObjectWithFile(dataFilePath!)
                    as! [String]
                dataArray.append(temp);
                NSKeyedArchiver.archiveRootObject(dataArray,
                    toFile: dataFilePath!)
            }
            else{
                var dataArray: [String] = [];
                dataArray.append(temp);
                NSKeyedArchiver.archiveRootObject(dataArray, toFile: dataFilePath!)
            }
        }
    }
    
}