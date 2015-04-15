//
//  ColorPresets.swift
//  BilSplit
//
//  Created by James McCarthy on 4/15/15.
//  Copyright (c) 2015 PandaTech. All rights reserved.
//

import Foundation
import UIKit

class ColorPresets
{
    var colors: [UIColor] = [];
    var nextColor: Int = 0;
    
    init(var newColors: [UIColor])
    {
        colors = newColors;
    }
    init()
    {
        //pumpkin orange rgb(211,84,0)
        colors.append(UIColor(red: CGFloat(211/255.0), green: CGFloat(84/255.0), blue: CGFloat(0/255.0), alpha: CGFloat(1)));
        
        //sunflower yellow rgb(241,196,15)
        colors.append(UIColor(red: CGFloat(241.0/255.0), green: CGFloat(196.0/255.0), blue: CGFloat(14/255.0), alpha: CGFloat(1)));
        
        //pomegranite red rgb(192,57,43)
        colors.append(UIColor(red: CGFloat(192/255.0), green: CGFloat(57/255.0), blue: CGFloat(43/255.0), alpha: CGFloat(1)));
        
        //midnight blue rgb(44,62,80)
        colors.append(UIColor(red: CGFloat(44.0/255.0), green: CGFloat(62.0/255.0), blue: CGFloat(80/255.0), alpha: CGFloat(1)));
        
        //amathyst purple rgb(155,89,182)
        colors.append(UIColor(red: CGFloat(155/255.0), green: CGFloat(89/255.0), blue: CGFloat(182/255.0), alpha: CGFloat(1)));
        
        //dark turquise rgb(22,160,133)
        colors.append(UIColor(red: CGFloat(22/255.0), green: CGFloat(160/255.0), blue: CGFloat(133/255.0), alpha: CGFloat(1)));
        
        //river blue rgb(52,152,219)
        colors.append(UIColor(red: CGFloat(52/255.0), green: CGFloat(152/255.0), blue: CGFloat(219/255.0), alpha: CGFloat(1)));
        
        //carrot orange rgb(230,126,34)
        colors.append(UIColor(red: CGFloat(230/255.0), green: CGFloat(126/255.0), blue: CGFloat(34/255.0), alpha: CGFloat(1)));
        
        //salmon rgb(231,76,60)
        colors.append(UIColor(red: CGFloat(231/255.0), green: CGFloat(76/255.0), blue: CGFloat(60/255.0), alpha: CGFloat(1)));
        
        //emerald green rgb(46,204,113)
        colors.append(UIColor(red: CGFloat(46.0/255.0), green: CGFloat(204.0/255.0), blue: CGFloat(113/255.0), alpha: CGFloat(1)));
        
        /*colors.append(UIColor.lightGrayColor());
        colors.append(UIColor.greenColor());
        colors.append(UIColor.blueColor());
        colors.append(UIColor.cyanColor());
        colors.append(UIColor.magentaColor());
        colors.append(UIColor.purpleColor());
        colors.append(UIColor.redColor());
        colors.append(UIColor.orangeColor());
        colors.append(UIColor.yellowColor());
        colors.append(UIColor.darkGrayColor());*/
    }
    
    func getColor() -> UIColor
    {
        if(nextColor >= colors.count)
        {
            //CGFloat(
            return UIColor(red: CGFloat(arc4random()%256)/CGFloat(256.0), green: CGFloat(arc4random()%256)/CGFloat(256.0), blue: CGFloat(arc4random()%256)/CGFloat(256.0), alpha: CGFloat(1));
        }
        
        var temp: UIColor = colors[nextColor];
        nextColor++;
        return temp;
    }
}