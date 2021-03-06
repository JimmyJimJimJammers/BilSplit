//
//  ViewControllerStartScreen.swift
//  BilSplit
//
//  Created by James McCarthy on 3/20/15.
//  Copyright (c) 2015 JimMcCarthy3d. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices

var finalReceipt: Receipt!
var start: Bool!
var dataFilePath: String?
var historyList: [History] = [];

class ViewControllerStartScreen: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var historyTable: UITableView!
    var activityIndicator:UIActivityIndicatorView!
    var t:UILabel!
    @IBOutlet weak var textView: UITextView!
    var historyList: [History] = [];
    var histListString : [String] = [];
    var taxAmount: Double = 0;
    var singleHis: History!
    
    var totalItemsAssigned: Int = 0;
    var totalItems: Int = 0;
    
    //loads screen every time screen is called via segue
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("made receipt in load\n")
        start = true
        if finalReceipt == nil{
            finalReceipt = Receipt()
        }
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let filemgr = NSFileManager.defaultManager()
        let dirPaths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        
        let docsDir = dirPaths[0] as! String
        dataFilePath = docsDir.stringByAppendingPathComponent("data.archive")
        //var error:NSError?
        //filemgr.removeItemAtPath(dataFilePath!, error: &error);
        
        //************************************************if shit is broken, uncomment this:******************************************************
        /*
        var error:NSError?
        //let filemgr = NSFileManager.defaultManager()
        filemgr.removeItemAtPath(dataFilePath!, error: &error);
        historyList = [];
        histListString = [];
        finalReceipt = Receipt();
        historyTable.reloadData();
        */
        
        if filemgr.fileExistsAtPath(dataFilePath!)
        {
            historyList = [];
            
            //loads saved persistent data file
            histListString = NSKeyedUnarchiver.unarchiveObjectWithFile(dataFilePath!) as! [String]
            
            
            //parses in saved data
            for(var i = 0; i<histListString.count; i++){
                var temp = histListString[i].componentsSeparatedByString("=="); //temp[0]=location temp[1]=total temp[2]=tax
                var tempPeople = temp[3].componentsSeparatedByString("::"); //tempPeople = array of people
                var persons : [Person] = [];
                for(var j = 0; j<tempPeople.count; j++){
                    var singlePerson = tempPeople[j].componentsSeparatedByString("{}"); //singlePerson[0]=name 1=color 2=email 3=phone 4=tip 5=arrayOfItems
                    var itemsArray = singlePerson[1].componentsSeparatedByString("()");
                    singlePerson=singlePerson[0].componentsSeparatedByString("[]");
                    var tempItem : [EditableItem] = [];
                    for(var k = 0; k<itemsArray.count; k++){
                        var singleItem = itemsArray[k].componentsSeparatedByString("&&"); //singleItem[0] = ItemName 1=Price 2=Quantity 3=numAssigned
                        //make Item
                        var tItem = EditableItem(itemName: singleItem[0], price: NSString(string: singleItem[1]).doubleValue, quantity: singleItem[2].toInt()!, assigned: singleItem[3].toInt()!);
                        //append Item
                        tempItem.append(tItem);
                    }
                    //make Person
                    var colorBits = singlePerson[1].componentsSeparatedByString(" ")
                    //CGFloat((str as NSString).floatValue)
                    var c = UIColor(red: CGFloat((colorBits[0] as NSString).floatValue), green: CGFloat((colorBits[1] as NSString).floatValue), blue: CGFloat((colorBits[2] as NSString).floatValue), alpha: CGFloat((colorBits[3] as NSString).floatValue));
                    var p = Person(personName: singlePerson[0], personColor: c, personEmail: singlePerson[2], phoneNumber: singlePerson[3], assignedItems: tempItem, personTip: NSString(string: singlePerson[4]).doubleValue);
                    //appendPerson
                    persons.append(p);
                }
                
                //saves parsed data in historyList
                var h = History(people: persons, tax: NSString(string: temp[2]).doubleValue, total: NSString(string: temp[1]).doubleValue, location: temp[0], date:temp[temp.count-1]);
                historyList.append(h);
            }
        }
        
    }
    
    @IBAction func deleteHistory(sender: AnyObject) {
        var error:NSError?
        let filemgr = NSFileManager.defaultManager()
        filemgr.removeItemAtPath(dataFilePath!, error: &error);
        historyList = [];
        histListString = [];
        finalReceipt = Receipt();
        historyTable.reloadData();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //function to get global final receipt
    func getReceipt(i: Receipt) -> Receipt {
        return finalReceipt
    }
    
    
    //handles loading the spinny bar thingy
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        SwiftSpinner.show("Processing Image...\nthis takes a bit")
        view.addSubview(activityIndicator)
    }
    
    //handles closing the spinny bar thingy
    func removeActivityIndicator() {
        SwiftSpinner.hide()
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
    }
    
    
    //TABLE STUFFF
    //function to return the size of the table
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.historyList.count;
    }
    
    //defualt loading function of the table
    func tableView(tView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: StartWindowCell = tView.dequeueReusableCellWithIdentifier("HistoryTableCell", forIndexPath: indexPath) as! StartWindowCell
        
        var hist : History;
        hist = historyList[indexPath.row];
        
        cell.LocationLabel.text = hist.location;
        cell.TotalLabel.text = String(format: "$%.2f", hist.total);
        cell.DateLabel.text = hist.date;
        //cell.NameLabel.text = person.name;
        //cell.ColorLabel.backgroundColor = person.color;
        return cell;
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //handles deleting from the table
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            historyList.removeAtIndex(indexPath.row);
            histListString.removeAtIndex(indexPath.row);
            NSKeyedArchiver.archiveRootObject(histListString, toFile: dataFilePath!)
            historyTable.reloadData();
            
        }
    }
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath)
    {
        singleHis = historyList[indexPath.row];
        
    }
    
    
    //Scales the Image for Tesseract based on dimension sent to func
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        var scaledSize = CGSizeMake(maxDimension, maxDimension)
        var scaleFactor:CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    //take photo function to call the image picker without alert boxes
    func TakePhotoN(sender: AnyObject){
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
            message: nil, preferredStyle: .ActionSheet)
        
        // 3
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                style: .Default) { (alert) -> Void in
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .Camera
                    self.presentViewController(imagePicker,
                        animated: true,
                        completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        // 4
        let libraryButton = UIAlertAction(title: "Choose Existing",
            style: .Default) { (alert) -> Void in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        // 5
        let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        
        // 6
        self.presentViewController(imagePickerActionSheet, animated: true, completion: nil)
    }

    
    //take photo with alert boxes
    @IBAction func TakePhoto(sender: AnyObject)
    {
        //if a receipt has already been scaned it asks if you want to discard that receipt
        //or add to it
        if !isEmpty(finalReceipt.items) && finalReceipt.total != 0.0 && finalReceipt.tax != 0.0 {
            var alert = UIAlertController(title: "Start Over?", message:
                "Receipt already loaded. Start over or add to original?", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Start Over", style: UIAlertActionStyle.Default,
                handler: {action in
                    finalReceipt = nil
                    finalReceipt = Receipt()
                    let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
                        message: nil, preferredStyle: .ActionSheet)
                    
                    // 3
                    if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                        let cameraButton = UIAlertAction(title: "Take Photo",
                            style: .Default) { (alert) -> Void in
                                let imagePicker = UIImagePickerController()
                                imagePicker.delegate = self
                                imagePicker.sourceType = .Camera
                                self.presentViewController(imagePicker,
                                    animated: true,
                                    completion: nil)
                        }
                        imagePickerActionSheet.addAction(cameraButton)
                    }
                    
                    // 4
                    let libraryButton = UIAlertAction(title: "Choose Existing",
                        style: .Default) { (alert) -> Void in
                            let imagePicker = UIImagePickerController()
                            imagePicker.delegate = self
                            imagePicker.sourceType = .PhotoLibrary
                            self.presentViewController(imagePicker, animated: true, completion: nil)
                    }
                    imagePickerActionSheet.addAction(libraryButton)
                    
                    // 5
                    let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel) { (alert) -> Void in
                    }
                    imagePickerActionSheet.addAction(cancelButton)
                    
                    // 6
                    self.presentViewController(imagePickerActionSheet, animated: true, completion: nil)
            }))
            //if add more is selected it appends the scan results
            alert.addAction(UIAlertAction(title: "Add More", style: UIAlertActionStyle.Default,
                handler: { action in
                    let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
                        message: nil, preferredStyle: .ActionSheet)
                    
                    // 3
                    if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                        let cameraButton = UIAlertAction(title: "Take Photo",
                            style: .Default) { (alert) -> Void in
                                let imagePicker = UIImagePickerController()
                                imagePicker.delegate = self
                                imagePicker.sourceType = .Camera
                                self.presentViewController(imagePicker,
                                    animated: true,
                                    completion: nil)
                        }
                        imagePickerActionSheet.addAction(cameraButton)
                    }
                    
                    // 4
                    let libraryButton = UIAlertAction(title: "Choose Existing",
                        style: .Default) { (alert) -> Void in
                            let imagePicker = UIImagePickerController()
                            imagePicker.delegate = self
                            imagePicker.sourceType = .PhotoLibrary
                            self.presentViewController(imagePicker, animated: true, completion: nil)
                    }
                    imagePickerActionSheet.addAction(libraryButton)
                    
                    // 5
                    let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel) { (alert) -> Void in
                    }
                    imagePickerActionSheet.addAction(cancelButton)
                    
                    // 6
                    self.presentViewController(imagePickerActionSheet, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default,
                handler: nil ))
            self.presentViewController(alert, animated: false, completion: nil)
        }
        else{
            let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
                message: nil, preferredStyle: .ActionSheet)
            
            // 3
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                let cameraButton = UIAlertAction(title: "Take Photo",
                    style: .Default) { (alert) -> Void in
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.sourceType = .Camera
                        self.presentViewController(imagePicker,
                            animated: true,
                            completion: nil)
                }
                imagePickerActionSheet.addAction(cameraButton)
            }
            
            // 4
            let libraryButton = UIAlertAction(title: "Choose Existing",
                style: .Default) { (alert) -> Void in
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .PhotoLibrary
                    self.presentViewController(imagePicker, animated: true, completion: nil)
            }
            imagePickerActionSheet.addAction(libraryButton)
            
            // 5
            let cancelButton = UIAlertAction(title: "Cancel", style: .Cancel) { (alert) -> Void in
            }
            imagePickerActionSheet.addAction(cancelButton)
            
            // 6
            self.presentViewController(imagePickerActionSheet, animated: true, completion: nil)
        }
    }
    
    
    //checks if type swift string is numeric
    func isNumeric(a: String) -> Bool {
        if let n = a.toInt() {
            return true
        } else {
            return false
        }
    }
    
    
    //Checks text for errors and splits up into array
    func checkText(readText: String) {
        //creates storage object
        if(finalReceipt == nil){
            print("made receipt in func")
            finalReceipt = Receipt()
        }
        print("check start\n")
        var finalizedText = readText
        var arrayText:[String] = []
        let replaceI : Character = "1"
        
        //if readText is empty then nothing was read from photo and display error popup to go back
        if(readText.isEmpty){
            var alert = UIAlertController(title: "Error:", message: "Couldn't processing image.", preferredStyle:UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            //remove extra '\n' (empty lines)
            arrayText = finalizedText.componentsSeparatedByString("\n")
            for var index = 0; index < arrayText.count; ++index {
                if(count(arrayText[index]) < 2){
                    arrayText.removeAtIndex(index)
                }
            }
            
            //change '_' for '.'
            for var index = 0; index < arrayText.count; ++index {
                if arrayText[index].rangeOfString("_") != nil{
                    arrayText[index] = arrayText[index].stringByReplacingOccurrencesOfString("_", withString: ".", options: nil, range: nil)
                }
            }
            
            //check if first char of string is I and just change it to 1 (common error in OCR)
            for var index = 0; index < arrayText.count; ++index {
                if( count(arrayText[index]) > 2 ) {
                    if( startsWith(arrayText[index], "I") ) {
                        var temp = dropFirst( arrayText[index] )
                        arrayText[index] = ("1" + temp)
                    }
                    else if( startsWith(arrayText[index], "l") ) {
                        var temp = dropFirst( arrayText[index] )
                        arrayText[index] = ("1" + temp)
                    }
                }
            }
            
            
            //will fix "6 .99" "6. 99" "6df.99" to "6.99"
            var errorString = ""
            for var i = 0; i < arrayText.count; i++ {
                for var j = 1; j<count(arrayText[i]); j++ {
                    if(!isNumeric(String(Array(arrayText[i])[j]))){
                        errorString = ""
                        var founda = false
                        for var counta = 1; counta<3 && j-counta>=0; counta++ {
                            if(isNumeric(String(Array(arrayText[i])[j-counta]))){
                                founda = true
                                break
                            }
                            else{
                                errorString = errorString + String(Array(arrayText[i])[j-counta])
                            }
                        }
                        errorString = errorString + String(Array(arrayText[i])[j])
                        var foundb = false
                        for var countb = 1; countb<3 && j+countb<count(arrayText[i]); countb++ {
                            if(isNumeric(String(Array(arrayText[i])[j+countb]))){
                                foundb = true
                                break
                            }
                            else{
                                errorString = errorString + String(Array(arrayText[i])[j+countb])
                            }
                        }
                        if(founda && foundb){
                            arrayText[i] = arrayText[i].stringByReplacingOccurrencesOfString(errorString, withString: ".", options: nil, range: nil)
                        }
                    }
                }
            }
        }
        
        for var i = 0; i < arrayText.count; i++ {
            var stringLength:Int = count(arrayText[i])
            var substringIndex = stringLength - 1
            var x:String = ""
            if(!isEmpty(arrayText[i])) {
                x = String(Array(arrayText[i])[substringIndex])
            }
            else {
                break
            }
            while (!isNumeric( x )){
                arrayText[i] = arrayText[i].substringToIndex(advance(arrayText[i].startIndex, substringIndex))
                stringLength = count(arrayText[i])
                substringIndex = stringLength - 1
                if(!isEmpty(arrayText[i])) {
                    x = String(Array(arrayText[i])[substringIndex])
                }
                else {
                    break
                }

            }
        }
        
        //var count = 0
        var stemp:String = ""
        var f = false
        for var i = 0; i < arrayText.count; i++ {
            stemp = ""
            for var j = 1; j<count(arrayText[i]); j++ {
                if (!isNumeric(String(Array(arrayText[i])[j])) && !(String(Array(arrayText[i])[j]) == " ")) {
                    stemp = stemp + String(Array(arrayText[i])[j])
                }
                else if (String(Array(arrayText[i])[j]) == " ") {
                    stemp = ""
                }
            }
            
            if (stemp != "" && stemp != "."){
                arrayText[i] = arrayText[i].stringByReplacingOccurrencesOfString(stemp, withString: " ", options: nil, range: nil)
                arrayText[i] = arrayText[i].stringByReplacingOccurrencesOfString("  ", withString: " ", options: nil, range: nil)
            }

    
        }
        
        for var i = 0; i < arrayText.count; i++ {
            if arrayText[i] == "" {
                arrayText.removeAtIndex(i)
            }
        }
        
        //checks to see if numbers are formatted properly
        for var i = 0; i < arrayText.count; i++ {
            var stringLength:Int = count(arrayText[i])
            var substringIndex = stringLength - 2
            var x:String = ""
            if(!isEmpty(arrayText[i])) {
                x = String(arrayText[i].characterAtIndex(substringIndex)!)
            }
            else {
                break
            }
            //fixes cases of double ..
            if(x != "." && x != " "){
                var rep = arrayText[i].substringToIndex(advance(arrayText[i].startIndex, substringIndex))
                arrayText[i] = arrayText[i].stringByReplacingOccurrencesOfString(rep, withString: rep + ".", options: nil, range: nil)
                arrayText[i] = arrayText[i].stringByReplacingOccurrencesOfString("..", withString: ".", options: nil, range: nil)
            }
        }
        
        for var i = 0; i < arrayText.count; i++ {
            if(isEmpty(arrayText[i]) || count(arrayText[i]) < 2){
                arrayText.removeAtIndex(i)
            }
        }
        
        var split: [[String]] = []
        for var index = 0; index < arrayText.count; index++ {
            var x = arrayText[index].componentsSeparatedByString(" ")
            var s = x.count
            if s > 1 {
                split.append(x)
            }
        }
        
        var receipt: [Item] = []
        var sub:Double = 0.0
        var tender:Double = 0.0
        var change:Double = 0.0
        
        //finds price in receipt
        for var i = 0; i < split.count; i++ {
            var temp = Item()
            //find price
            for var p = 0; p < split[i].count; p++ {
                let characterToFind: Character = "$"
                if var characterIndex = find(split[i][p], characterToFind) {
                    split[i][p].stringByReplacingOccurrencesOfString("$", withString: "", options: nil, range: nil)
                }
                
                if split[i][p].rangeOfString(".") != nil && split[i][p].rangeOfString("%") == nil {
                    var pr:Double = 0.0
                    pr = NSString(string: split[i][p]).doubleValue
                    if pr != 0.0 {
                        var pri:Double = 0.0
                        pri = pr
                        temp.price = pri
                        split[i].removeAtIndex(p)
                        break
                    }
                }
            }
            
            //find quantity
            //not fully tested
            for var p = 0; p < split[i].count; p++ {
                if isNumeric(split[i][p]) && count(split[i][p]) < 3 {
                    temp.quantity = split[i][p].toInt()!
                }
            }
            
            //find name and put into array also sets tax and total in storage object
            if temp.price != 0.0 && !isEmpty(split[i]) {
                var n = " ".join(split[i])
                
                if n.lowercaseString.rangeOfString("sub") != nil || n.lowercaseString.rangeOfString("subtotal") != nil {
                    sub = temp.price
                }
                
                else if (n.lowercaseString.rangeOfString("total") != nil || n.lowercaseString.rangeOfString("tl") != nil) && (n.lowercaseString.rangeOfString("tax") == nil && n.lowercaseString.rangeOfString("%") == nil) {
                    if(  finalReceipt.tax == 0.0 && (temp.price < sub || sub == 0)) {
                        finalReceipt.tax = temp.price
                    }
                    
                    else if( finalReceipt.total < sub || finalReceipt.total == 0.0 || finalReceipt.total < temp.price ){
                        finalReceipt.total = temp.price
                    }
                    
                }
                
                else if n.lowercaseString.rangeOfString("tax") != nil {
                    finalReceipt.tax = temp.price
                }

                
                else if n.lowercaseString.rangeOfString("change") == nil && n.lowercaseString.rangeOfString("cash") == nil && n.lowercaseString.rangeOfString("cg") == nil && n.lowercaseString.rangeOfString("credit") == nil{
                    temp.name = n
                    receipt.append(temp)
                }
                
                else if n.lowercaseString.rangeOfString("cash") != nil || n.lowercaseString.rangeOfString("tender") != nil {
                    tender = temp.price
                }
                
                else if n.lowercaseString.rangeOfString("change") != nil || n.lowercaseString.rangeOfString("cg") != nil {
                    change = temp.price
                }
            }
        }
        
        if(finalReceipt.tax != 0.0 && sub != 0.0 && finalReceipt.total==0.0 ){
            finalReceipt.total = finalReceipt.tax + sub
        }
        
        else if finalReceipt.tax == 0.0 && sub != 0.0 && finalReceipt.total != 0.0 {
            finalReceipt.tax = finalReceipt.total - sub
        }
        
        if finalReceipt.tax > finalReceipt.total {
            var t = finalReceipt.tax
            finalReceipt.tax = finalReceipt.total
            finalReceipt.total = t
        }
        
        //below line is strictly for debugging
        //receipt = []
        removeActivityIndicator()
        
        
        //pops up to see if another photo is needed for large receipt
        //if yes opens up camera button again
        //if not tells user what to do next (click next button)
        if(isEmpty(receipt) == false){
            if(isEmpty(finalReceipt.items)){
                finalReceipt.items = receipt
            }
            else{
                finalReceipt.items += receipt
                
            }
            var alert = UIAlertController(title: "Add More?", message:
                "Do you need to take another photo?", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default,
                handler: {action in
                    start = true
                    var alert = UIAlertController(title: "Yay!", message: "Image procesed! Click next to continue.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default,
                handler: {action in
                    let somevar = 0
                    self.TakePhotoN(somevar)
            }))
            self.presentViewController(alert, animated: false, completion: nil)
        }
        
        else{
            var alert = UIAlertController(title: "Error:", message: "Couldn't processing image.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        // 8
    }
    
    
    //applies filters from CIImage to sharpen up and contrast photo
    //calls perform image recognition function
    func preProcessingImage(preimage: UIImage) {
        print("preprocessing start\n")
        var beginImage = CIImage(image: preimage)
        
        var greyFilter = CIFilter(name: "CIPhotoEffectMono")
        greyFilter.setValue(beginImage, forKey:kCIInputImageKey)
        var displayImage = UIImage(CGImage: CIContext(options:nil).createCGImage(greyFilter.outputImage, fromRect:greyFilter.outputImage.extent()))!
        
        var greyImage = CIImage(image: displayImage)
        
        
        var invertFilter = CIFilter(name: "CIColorInvert")
        invertFilter.setDefaults()
        invertFilter.setValue(greyImage, forKey:kCIInputImageKey)
        var final = UIImage(CGImage: CIContext(options:nil).createCGImage(invertFilter.outputImage, fromRect:invertFilter.outputImage.extent()))!
        
        var next = CIImage(image: final)
        
        var finalgreyFilter = CIFilter(name: "CIColorControls")
        finalgreyFilter.setValue(0.8, forKey:"inputContrast")
        finalgreyFilter.setValue(next, forKey:kCIInputImageKey)
        var finished = UIImage(CGImage: CIContext(options:nil).createCGImage(finalgreyFilter.outputImage, fromRect:finalgreyFilter.outputImage.extent()))!
        
        print("preprocessing finish\n")
        
        performImageRecognition(displayImage)
    }

    //initalizes and starts tesseract
    //calls the checkText functon
    func performImageRecognition(image: UIImage) {
        SwiftSpinner.show("Processing Image...\njust a little longer")
        print("tess start\n")
        // 1
        let tesseract = G8Tesseract()
        
        // 2
        tesseract.language = "eng+fra"
        
        // 3
        tesseract.engineMode = .TesseractCubeCombined
        
        // 4
        tesseract.pageSegmentationMode = .SingleColumn //.AutoOSD
        
        // 5
        tesseract.maximumRecognitionTime = 60.0
        
        // 6
        tesseract.image = image.g8_blackAndWhite()
        
        tesseract.recognize()
        
        // 7
        var readText = tesseract.recognizedText
        print("tess end\n")
        checkText(readText)
    
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if(segue.identifier == "EditItemsSegue")
        {
            var svc = segue.destinationViewController as! ItemsWindow;
            
            svc.historyList = self.historyList;
        }
        
        if (segue.identifier == "ToHistoryDetailSegue")
        {
            var svc = segue.destinationViewController as! HistoryDetailViewController;
            
            svc.resturant = singleHis;
        }
    }
    
}

//extenstion to string class to convert string to float
extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}


//extenstion to string class to get character at index from string
extension String {
    func characterAtIndex(index: Int) -> Character? {
        var cur = 0
        for char in self {
            if cur == index {
                return char
            }
            cur++
        }
        return nil
    }
}


//extension to viewcontrollerstartscreen to open up image picker and allow image to be pulled from user selection
//and passed into preprocessingimage function
//also starts the activityindicator (spinny bar thingy)
extension ViewControllerStartScreen: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
            let scaledImage = self.scaleImage(selectedPhoto, maxDimension: 640)
            
            addActivityIndicator()
            
            dismissViewControllerAnimated(true, completion: {
                self.preProcessingImage(scaledImage)
            })
    }
}