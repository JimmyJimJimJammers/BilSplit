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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TakePhoto(sender: AnyObject)
    {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
}