//
//  ViewControllerStartScreen.swift
//  BilSplit
//
//  Created by James McCarthy on 3/20/15.
//  Copyright (c) 2015 JimMcCarthy3d. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerStartScreen: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate
{
    var activityIndicator:UIActivityIndicatorView!
    var t:UILabel!
    var finalReceipt: Receipt!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalReceipt = Receipt()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        SwiftSpinner.show("Processing Image...\nthis takes a bit")
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        SwiftSpinner.hide()
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
    }
    
    class Item {
        var price: Double
        var quantity: Int
        var name: String
        
        init() {
            self.quantity = 1
            self.price = 0.0
            self.name = ""
        }
    }
    
    class Receipt {
        var items: [Item]
        var total: Double
        var tax: Double
        
        init() {
            self.items = []
            self.total = 0.0
            self.tax = 0.0
        }
    }
    
    //Scales the Image for Tesseract
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
    
    @IBAction func TakePhoto(sender: AnyObject)
    {
        /*
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
        */
        
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
        presentViewController(imagePickerActionSheet, animated: true, completion: nil)
    }
    
    
    
    func isNumeric(a: String) -> Bool {
        if let n = a.toInt() {
            return true
        } else {
            return false
        }
    }
    
    
    //Checks text for errors and splits up into array
    func checkText(readText: String) -> [String] {
        print("check start\n")
        var finalizedText = readText
        var arrayText:[String]
        let replaceI : Character = "1"
        if(readText.isEmpty){
            return []
        }
        else{
            //remove extra '\n' (empty lines)
            arrayText = finalizedText.componentsSeparatedByString("\n")
            for var index = 0; index < arrayText.count; ++index {
                if(countElements(arrayText[index]) < 2){
                    arrayText.removeAtIndex(index)
                }
            }
            
            //change '_' for '.'
            for var index = 0; index < arrayText.count; ++index {
                if arrayText[index].rangeOfString("_") != nil{
                    arrayText[index] = arrayText[index].stringByReplacingOccurrencesOfString("_", withString: ".", options: nil, range: nil)
                }
            }
            
            
            for var index = 0; index < arrayText.count; ++index {
                if( countElements(arrayText[index]) > 2 ) {
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
            
            
            var errorString = ""
            for var i = 0; i < arrayText.count; i++ {
                for var j = 1; j<countElements(arrayText[i]); j++ {
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
                        for var countb = 1; countb<3 && j+countb<countElements(arrayText[i]); countb++ {
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
            //find name and put into array
            if temp.price != 0.0 && !isEmpty(split[i]) {
                var n = " ".join(split[i])
                
                if (n.lowercaseString.rangeOfString("total") != nil || n.lowercaseString.rangeOfString("tl") != nil) && n.lowercaseString.rangeOfString("tax") == nil && n.lowercaseString.rangeOfString("%") == nil{
                    finalReceipt.total = temp.price
                }
                
                else if n.lowercaseString.rangeOfString("tax") != nil {
                    finalReceipt.tax = temp.price
                }

                
                else if n.lowercaseString.rangeOfString("change") == nil && n.lowercaseString.rangeOfString("cash") == nil && n.lowercaseString.rangeOfString("cg") == nil && n.lowercaseString.rangeOfString("credit") == nil{
                    temp.name = n
                    receipt.append(temp)
                }
                
                else if n.lowercaseString.rangeOfString("sub") != nil || n.lowercaseString.rangeOfString("subtotal") != nil {
                    sub = temp.price
                }
                
                else if n.lowercaseString.rangeOfString("cash") != nil || n.lowercaseString.rangeOfString("tender") != nil {
                    tender = temp.price
                }
                
                else if n.lowercaseString.rangeOfString("change") != nil || n.lowercaseString.rangeOfString("cg") != nil {
                    change = temp.price
                }
            }
        }
        
        if finalReceipt.total == 0.0 && tender != 0.0 && change != 0.0  {
            finalReceipt.total = tender-change
        }
        
        if finalReceipt.tax == 0.0 && sub != 0.0 {
            finalReceipt.tax = finalReceipt.total - sub
        }
        
        //below line is strictly for debugging
        //receipt = []
        
        removeActivityIndicator()
        
        if(isEmpty(receipt) == false){
            if(isEmpty(finalReceipt.items)){
                finalReceipt.items = receipt
            }
            else{
                finalReceipt.items += receipt
            }
            var alert = UIAlertController(title: "Yay!", message: "Image procesed! Click next to continue.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        else{
            var alert = UIAlertController(title: "Error:", message: "Couldn't processing image.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        // 8
        
        
        //call function to populate tables here
        //eg:
        //populateTables(arrayText)
        return arrayText as [String]
    }
    
    func preProcessingImage(preimage: UIImage) {
        print("preprocessing start\n")
        var beginImage = CIImage(image: preimage)
        
        var greyFilter = CIFilter(name: "CIPhotoEffectMono")
        greyFilter.setValue(beginImage, forKey:kCIInputImageKey)
        var displayImage = UIImage(CGImage: CIContext(options:nil).createCGImage(greyFilter.outputImage, fromRect:greyFilter.outputImage.extent()))!
        
        beginImage = CIImage(image: displayImage)
        
        
        /*var invertFilter = CIFilter(name: "CIColorInvert")
        invertFilter.setDefaults()
        invertFilter.setValue(nextImage, forKey:kCIInputImageKey)
        var final = UIImage(CGImage: CIContext(options:nil).createCGImage(invertFilter.outputImage, fromRect:invertFilter.outputImage.extent()))!*/
        
        print("preprocessing finish\n")
        
        performImageRecognition(displayImage)
    }

    
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
    
}

extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}


extension ViewControllerStartScreen: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            let selectedPhoto = info[UIImagePickerControllerOriginalImage] as UIImage
            let scaledImage = self.scaleImage(selectedPhoto, maxDimension: 640)
            
            addActivityIndicator()
            
            dismissViewControllerAnimated(true, completion: {
                self.preProcessingImage(scaledImage)
            })
            
            
    }
}