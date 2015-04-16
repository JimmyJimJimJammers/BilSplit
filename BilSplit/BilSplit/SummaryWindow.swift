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
        
        if(segue.identifier == "SaveHistorySegue")
        {
            var svc = segue.destinationViewController as! ViewControllerStartScreen;
            
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
                    as! [History]
                dataArray.append(History(people: people, tax: finalReceipt.tax, total: finalReceipt.total));
                NSKeyedArchiver.archiveRootObject(dataArray,
                    toFile: dataFilePath!)
            }
            else{
                var dataArray: [History] = [];
                dataArray.append(History(people: people, tax: finalReceipt.tax, total: finalReceipt.total));
                NSKeyedArchiver.archiveRootObject(dataArray,
                    toFile: dataFilePath!)
            }
        }
    }
    
}