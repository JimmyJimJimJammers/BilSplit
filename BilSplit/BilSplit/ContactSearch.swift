//
//  ContactSearch.swift
//  BilSplit
//
//  Created by James McCarthy on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation
import UIKit
import AddressBook

class ContactSearch: UISearchBar
{
    // Initializing the address book
    var adbk : ABAddressBook!
    
    func createAddressBook() -> Bool {
        if self.adbk != nil {
            return true
        }
        var err : Unmanaged<CFError>? = nil
        let adbk : ABAddressBook? = ABAddressBookCreateWithOptions(nil, &err).takeRetainedValue()
        if adbk == nil {
            println(err)
            self.adbk = nil
            return false
        }
        self.adbk = adbk
        return true
    }
    
    // Permissions for the Address Book
    func determineStatus() -> Bool {
        let status = ABAddressBookGetAuthorizationStatus()
        switch status {
        case .Authorized:
            return self.createAddressBook()
        case .NotDetermined:
            var ok = false
            ABAddressBookRequestAccessWithCompletion(nil) {
                (granted:Bool, err:CFError!) in
                dispatch_async(dispatch_get_main_queue()) {
                    if granted {
                        ok = self.createAddressBook()
                    }
                }
            }
            if ok == true {
                return true
            }
            self.adbk = nil
            return false
        case .Restricted:
            self.adbk = nil
            return false
        case .Denied:
            self.adbk = nil
            return false
        }
    }
    
    
    // Change this so we can use the people array in the search bar
    func getContactNames() {
        if !self.determineStatus() {
            println("not authorized")
            return
        }
        var people: NSArray = ABAddressBookCopyArrayOfAllPeople(adbk).takeRetainedValue()// as NSArray as [ABRecord]
        
        
//        for person in people {
//            println(ABRecordCopyCompositeName(person).takeRetainedValue())
//        }
    
        // Looping through contacts and grabbing their information
        for record:ABRecordRef in people {
            let x: Unmanaged<CFString>! = ABRecordCopyCompositeName(record)
            if x != nil {
                var contactPerson: ABRecordRef = record
                
                let emailProperty: ABMultiValueRef = ABRecordCopyValue(record, kABPersonEmailProperty).takeRetainedValue() as ABMultiValueRef
                let allEmailIDs: NSArray = ABMultiValueCopyArrayOfAllValues(emailProperty).takeUnretainedValue() as NSArray
                
                // Printing out emails
                
                for email in allEmailIDs {
                    let emailID = email as! String
                    println ("contactEmail : \(emailID) :=>")
                }
                
                // Printing out first and last names
                if let contactFirstName = ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty).takeRetainedValue() as? NSString {
                    println ("\t\t contactFirstName : \(contactFirstName)")
                }
                if let contactLastName = ABRecordCopyValue(contactPerson, kABPersonLastNameProperty).takeRetainedValue() as? NSString {
                    println ("\t\t contactLastName : \(contactLastName)")
                }
                
                // Phone numbers
                /* Get all the phone numbers this user has */
                let unmanagedPhones = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty)
                let phones: ABMultiValueRef =
                Unmanaged.fromOpaque(unmanagedPhones.toOpaque()).takeUnretainedValue()
                    as NSObject as ABMultiValueRef
                
                let countOfPhones = ABMultiValueGetCount(phones)
                
                for index in 0..<countOfPhones{
                    let unmanagedPhone = ABMultiValueCopyValueAtIndex(phones, index)
                    let phone: String = Unmanaged.fromOpaque(unmanagedPhone.toOpaque()).takeUnretainedValue() as NSObject as! String
                    
                    println(phone)
                }
            }
        }
    }
}