//
//  Person.swift
//  BilSplit
//
//  Created by James McCarthy on 4/14/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation

class Person
{
    var name: String;// = "Name";
    var color: UIColor;// = UIColor.blackColor();
    var email: String;// = "NoEmail";
    var phone: String;//  = 5558675309;
    var items: [EditableItem];// = [];
    var tip: Double;
    
    init(personName: String, personColor: UIColor, personEmail: String, phoneNumber: String, assignedItems: [EditableItem], personTip: Double)
    {
        name = personName;
        color = personColor;
        email = personEmail;
        phone = phoneNumber;
        items = assignedItems;
        tip = personTip;
        
    }
    init()
    {
        name = "Name";
        color = UIColor.blackColor();
        email = "NoEmail";
        phone  = "5558675309";
        items = [];
        tip = 0.10;
    }
    
    func printValues()
    {
       // var tempR: CGFloat;
        //var tempG: CGFloat;
        //var tempB: CGFloat;
        //var tempA: CGFloat;
        //color.getRed(tempR, saturation: &tempG, brightness: &tempB, alpha: &tempA);
        
        /*var colorString = color.description;
        let newString = colorString.stringByReplacingOccurrencesOfString("UIDeviceRGBColorSpace", withString: "");
        let myWordList = newString.wordList;
        let red = myWordList[1].toInt();
        let green = myWordList[2].toInt();
        let blue = myWordList[3].toInt();*/
        
        print(name);
        print("\n");
        print("_____________\n");
        //print("\tColor: R:%f G:%f B:%f\n", red, green, blue);
        print(email);
        print("\n");
        print(phone);
        print("\n");
        for(var i: Int = 0; i < items.count; i++)
        {
            items[i].printItem();
        }
        print(String(format: "Tip: $%.2f\n" , tip));

        
    }
}

/*extension String {
    var wordList:[String] {
        return "".join(componentsSeparatedByCharactersInSet(NSCharacterSet.punctuationCharacterSet())).componentsSeparatedByString(" ")
    }
}*/