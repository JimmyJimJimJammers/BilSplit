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
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Activity Indicator methods
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
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
            
            var left : String = ""
            var right : String = ""
            //check if extra spaces eg. "6 . 99" || "6. 99" || "6 .99"
            for var index = 0; index < arrayText.count; ++index {
                for var j = 2; j < countElements(arrayText[index]); j++ {
                    if (Array(arrayText[index])[j] == ".") {
                        if (Array(arrayText[index])[j+1] == " " && Array(arrayText[index])[j-1] == " ") {
                            if(Array(arrayText[index])[j-2] != nil && (j < countElements(arrayText[index])-2 && Array(arrayText[index])[j+2] != nil)){
                                left = String(Array(arrayText[index])[j-2])
                                right = String(Array(arrayText[index])[j+2])
                            }
                            
                            if( isNumeric( left ) && isNumeric( right ) ) {
                                arrayText[index] = arrayText[index].stringByReplacingOccurrencesOfString(left + " . " + right, withString: left + "." + right, options: NSStringCompareOptions.LiteralSearch, range: nil)
                            }
                        }
                        else if (Array(arrayText[index])[j+1] == " ") {
                            if(Array(arrayText[index])[j-2] != nil && (j < countElements(arrayText[index])-2 && Array(arrayText[index])[j+2] != nil)){
                                left = String(Array(arrayText[index])[j-2])
                                right = String(Array(arrayText[index])[j+2])
                            }
                            
                            if( isNumeric( left ) && isNumeric( right ) ) {
                                arrayText[index] = arrayText[index].stringByReplacingOccurrencesOfString(left + ". " + right, withString: left + "." + right, options: NSStringCompareOptions.LiteralSearch, range: nil)
                            }
                        }
                        else if (Array(arrayText[index])[j-1] == " ") {
                            if(Array(arrayText[index])[j-2] != nil && (j < countElements(arrayText[index])-2 && Array(arrayText[index])[j+2] != nil)){
                                left = String(Array(arrayText[index])[j-2])
                                right = String(Array(arrayText[index])[j+2])
                            }
                            
                            if( isNumeric( left ) && isNumeric( right ) ) {
                                arrayText[index] = arrayText[index].stringByReplacingOccurrencesOfString(left + " ." + right, withString: left + "." + right, options: NSStringCompareOptions.LiteralSearch, range: nil)
                            }
                        }
                    }
                }
            }
            
            
            
            
            //then check for no '.' eg. "2 99"
            for var index = 0; index < arrayText.count; ++index {
                for var j = 1; j < countElements(arrayText[index]); j++ {
                    if(Array(arrayText[index])[j-1] != nil){
                        left = String(Array(arrayText[index])[j-1])
                    }
                    if(j < countElements(arrayText[index])-1 && Array(arrayText[index])[j+1] != nil){
                        right = String(Array(arrayText[index])[j+1])
                    }
                    
                    if( isNumeric( left ) && isNumeric( right ) ) {
                        arrayText[index] = arrayText[index].stringByReplacingOccurrencesOfString(left + " " + right, withString: left + "." + right, options: NSStringCompareOptions.LiteralSearch, range: nil)
                    }
                }
            }
        }
        // 8
        removeActivityIndicator()
        //call function to populate tables here
        //eg:
        //populateTables(arrayText)
        return arrayText as [String]
    }

    
    func performImageRecognition(image: UIImage) {
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
        
        checkText(readText)
    
    }
    
}

extension ViewControllerStartScreen: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            let selectedPhoto = info[UIImagePickerControllerOriginalImage] as UIImage
            let scaledImage = scaleImage(selectedPhoto, maxDimension: 640)
            
            addActivityIndicator()
            
            dismissViewControllerAnimated(true, completion: {
                
                let beginImage = CIImage(image: scaledImage)
                let greyFilter = CIFilter(name: "CIPhotoEffectMono")
                greyFilter.setValue(beginImage, forKey:kCIInputImageKey)
                let invertFilter = CIFilter(name: "CIColorInvert")
                invertFilter.setValue(greyFilter.outputImage, forKey:kCIInputImageKey)
                let newImage = UIImage(CIImage: invertFilter.outputImage)
                
                self.performImageRecognition(newImage!)
            })
    }
}