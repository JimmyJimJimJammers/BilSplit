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
    
    var historyList: [History] = [];
    var people: [Person] = [];
    var editableItemsList: [EditableItem] = []
    var colors: ColorPresets = ColorPresets();
    var taxAmount: Double = 0;
    
    var totalItemsAssigned: Int = 0;
    var totalItems: Int = 0;
    
    var cellTapped:Bool = true
    var currentRow = 0;
    
    @IBOutlet weak var SaveButton: UIButton!
    @IBOutlet weak var RestaurantTextField: UITextField!
    
    @IBOutlet weak var TotalLabel: UILabel!
    
    
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
        
        super.viewDidLoad()
        var noTip:Double = 0.0;
        for(var i: Int = 0; i < people.count; i++)
        {
            for(var j: Int = 0; j < people[i].items.count; j++)
            {
                noTip += people[i].items[j].Price;
            }
        }
        taxAmount = finalReceipt.tax/noTip;
        
        var total: Double = 0;
        
        for(var i: Int = 0; i < people.count; i++)
        {
            var subTotal: Double = 0;
            for(var j: Int = 0; j < people[i].items.count; j++)
            {
                subTotal += people[i].items[j].Price;
            }
            total += subTotal*taxAmount;
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
        total += total*taxAmount;
        total += total*person.tip;
        
        cell.Total.text = String(format: "$%.2f", total);
        cell.Color.backgroundColor = person.color;
        
        //cell.QuantityTextField.text = "0x";
        
        //cell.NameLabel.text = person.name;
        //cell.ColorLabel.backgroundColor = person.color;
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedRowIndex = indexPath
        currentRow = selectedRowIndex.row
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == currentRow {
            if cellTapped == false {
                cellTapped = true
                return 141
            } else {
                cellTapped = false
                return 45
            }
        }
        return 45
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
            var tempHistory: History = History();
            tempHistory.location = RestaurantTextField.text;
            tempHistory.people = self.people;
            var tempTotal: String = TotalLabel.text!;
            tempTotal = tempTotal.stringByReplacingOccurrencesOfString("$", withString: "", options: nil, range: nil);
            tempTotal = tempTotal.stringByReplacingOccurrencesOfString(".", withString: "", options: nil, range: nil);
            
            tempHistory.total = Double(tempTotal.toInt()!)/100.0;
            
            //tempHistory.tax =
            
            var svc = segue.destinationViewController as! ViewControllerStartScreen;
            
            //historyList.append(tempHistory);
            //svc.historyList = self.historyList;
            
            finalReceipt = Receipt();
            
            var loc: String = RestaurantTextField.text;
            
            //string history class
            var temp = tempHistory.location + "==";
            temp = temp + String(format: "%.2f", tempHistory.total) + "==";
            temp = temp + String(format: "%f", taxAmount) + "==";
            
            for(var i=0; i<tempHistory.people.count; i++){
                
                temp = temp + tempHistory.people[i].name + "[]";
                //temp = temp + people[i].color + "[]";// <--color bullshit
                var r:CGFloat = 0;
                var g:CGFloat = 0;
                var b:CGFloat = 0;
                var a:CGFloat = 0;
                var myColor = tempHistory.people[i].color;
                myColor.getRed(&r, green: &g, blue: &b, alpha: &a);
                temp = temp + r.description + " " + g.description + " " + b.description + " " + a.description + "[]"
                if(tempHistory.people[i].email != ""){
                    temp = temp + tempHistory.people[i].email + "[]";
                }
                else{
                    temp = temp + "n/a" + "[]";
                }
                if(tempHistory.people[i].phone != ""){
                    temp = temp + tempHistory.people[i].phone + "[]";
                }
                else{
                    temp = temp + "n/a" + "[]";
                }
                temp = temp + String(format: "%f", tempHistory.people[i].tip) + "{}";
                for(var j=0; j<tempHistory.people[i].items.count; j++){
                    temp = temp + tempHistory.people[i].items[j].ItemName + "&&";
                    temp = temp + String(format: "%.2f", tempHistory.people[i].items[j].Price) + "&&";
                    temp = temp + String(format: "%d", tempHistory.people[i].items[j].Quantity) + "&&";
                    temp = temp + String(format: "%d", tempHistory.people[i].items[j].numAssigned);
                    if(j<tempHistory.people[i].items.count-1){
                        temp = temp + "()";
                    }
                }
                if(i<tempHistory.people.count-1){
                    temp = temp + "::";
                }
            }
            let formatter = NSDateFormatter()
            let date = NSDate()
            formatter.dateFormat = "MM/dd/yy"
            var d:String = formatter.stringFromDate(date);
            temp = temp + "=="  + d;
            
            
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