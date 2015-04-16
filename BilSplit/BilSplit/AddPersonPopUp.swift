//
//  AddPersonPopUp.swift
//  BilSplit
//
//  Created by James McCarthy on 4/14/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import UIKit

class AddPersonPopUp: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var NumberTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var ColorButton: UIButton!
    var people: [Person] = [];
    var editableItemsList: [EditableItem] = []
    var colors: ColorPresets = ColorPresets();
    var historyList: [History] = [];
    var taxAmount: Double = 0;
    
    var totalItemsAssigned: Int = 0;
    var totalItems: Int = 0;
    
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
        super.viewDidLoad();
        
        ColorButton.backgroundColor = colors.getColor();
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!)
    {
        if (segue.identifier == "BackToAddPeopleSegue")
        {
            var svc = segue.destinationViewController as! AddPeopleViewController;
            
            if(NameTextField.text == "")
            {
                svc.people = self.people;
                svc.colors = self.colors;
                svc.editableItemsList = self.editableItemsList;
            }
            else
            {
            
                var tempPerson: Person = Person();
                tempPerson.name = NameTextField.text;
                tempPerson.color = ColorButton.backgroundColor!;
            
                let x = NumberTextField;
                let y = EmailTextField;
                if(x != nil)
                {
                    tempPerson.phone = NumberTextField.text;
                }
                if(y != nil)
                {
                    tempPerson.email = EmailTextField.text;
                }
                people.append(tempPerson);

                svc.people = self.people;
                svc.colors = self.colors;
                svc.historyList = self.historyList;
                svc.editableItemsList = self.editableItemsList;
                svc.totalItems = self.totalItems;
                svc.totalItemsAssigned = self.totalItemsAssigned;
                //svc.people.append(tempPerson); //wrong, send person
                //svc.NameTextField = NameTextField.text
                //svc = fieldB.text
            }
        }
    }
    
}
