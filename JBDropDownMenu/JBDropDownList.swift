//
//  JBDropDownList.swift
//  TutorSwift
//
//  Created by Developer on 18/03/15.
//  Copyright (c) 2015 jithinpala@gmail.com. All rights reserved.
//

import UIKit

protocol JBDropDownDelegate {
    func DropDownListViewDataList(datalist: NSMutableArray)
    func DropDownListViewDidSelect(didSelectedIndex:NSInteger)
    //func DropDownListViewDidSelect(didSelectedIndex:NSInteger)
    //func DropDownListViewDidCancel()
    
}

class JBDropDownList: UIView, UITableViewDataSource, UITableViewDelegate {
    
    let DROPDOWNVIEW_SCREENINSET = 0
    let DROPDOWNVIEW_HEADER_HEIGHT = 50
    let RADIUS = 5.0
    
    var DropTableView: UITableView = UITableView()
    var _kTitleText: NSString!
    var _kDropDownOption: NSArray!
    var R,G,B,A: CGFloat!
    var isMultipleSelection: Bool = false
    var jbDelegate: JBDropDownDelegate?
    var arryData: NSMutableArray!
    var DropDownOption: NSArray!
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //self.callFingerTapToExit()
    }
    
    convenience init(content: String, sender: String, frame: CGRect)
    {
        //Rule 2 and 3:  Calling the Designated Initializer in same class
        self.init(frame:frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func callInitialSetup(titleText: NSString, listValues: NSArray, isMultiple: Bool) {
        self.backgroundColor = UIColor.clearColor()
        
        isMultipleSelection = isMultiple
        _kTitleText         = titleText.copy() as NSString
        DropDownOption      = listValues.copy() as NSArray
        arryData            = NSMutableArray()
        
        var innerContainer  = UIView(frame: self.calculateDropdownContainerSize(listValues.count))
        innerContainer.backgroundColor      = UIColor.redColor().colorWithAlphaComponent(0.5)
        innerContainer.layer.cornerRadius   = 8.0
        innerContainer.layer.shadowColor    = UIColor.blackColor().CGColor
        innerContainer.layer.shadowOffset   = CGSizeMake(2.5, 2.5)
        innerContainer.layer.shadowRadius   = 2.0
        innerContainer.layer.shadowOpacity  = 0.5
        self.addSubview(innerContainer)
        
        DropTableView       = UITableView(frame: CGRectMake(0, CGFloat(DROPDOWNVIEW_HEADER_HEIGHT), innerContainer.frame.size.width, innerContainer.frame.size.height - 50), style: UITableViewStyle.Plain)
        DropTableView.separatorColor    =   UIColor(white: 1, alpha: 0.2)
        DropTableView.separatorInset    =   UIEdgeInsetsZero
        DropTableView.backgroundColor   =   UIColor.clearColor()
        DropTableView.delegate          =   self
        DropTableView.dataSource        =   self
        innerContainer.addSubview(DropTableView)
        
        if isMultipleSelection {
            //var doneButton  =   UIButton(frame: CGRectMake(innerContainer.frame.size.width - 100, 10, 80, 30))
            var doneButton  =   UIButton.buttonWithType(UIButtonType.Custom) as UIButton
            doneButton.frame = CGRectMake(innerContainer.frame.size.width - 100, 10, 80, 30)
            doneButton.setImage(UIImage(named: "done@2x.png"), forState: .Normal)
            //doneButton.addTarget(self, action: "Click_Done", forControlEvents: UIControlEvents.TouchUpInside)
            doneButton.addTarget(self, action: "Click_Done:", forControlEvents: .TouchUpInside)
            innerContainer.addSubview(doneButton)
            //doneButton(but
        }
        
    }
    
    func calculateDropdownContainerSize(totalCout: NSInteger) -> CGRect {
        
        var bounds: CGRect = UIScreen.mainScreen().bounds
        var width:CGFloat  = bounds.size.width - 30
        var height:CGFloat = bounds.size.height - 100
        var totalTableH    = CGFloat((totalCout*40) + 50)
        var frameBounds: CGRect
        
        if height > totalTableH {
            frameBounds = CGRectMake(15, (bounds.size.height - totalTableH)/2, width, totalTableH)
        }else {
            frameBounds = CGRectMake(15, (bounds.size.height - height)/2, width, height)
        }
        
        return frameBounds
    }
    
    //
    //  UITAbleview data sources
    //
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DropDownOption.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let reuseIndentifier = "CellIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIndentifier) as? UITableViewCell
        cell = JBDropDownCell(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIndentifier)
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        var tickImage = UIImageView()
        if (arryData.containsObject(indexPath)) {
            tickImage.frame = CGRectMake(tableView.frame.size.width - 50 , 6, 27, 27)
            tickImage.image = UIImage(named: "check_mark@2x.png")
        }else {
            tickImage.removeFromSuperview()
            println("Remove tick mark")
        }
        cell?.addSubview(tickImage)        
        //we know that cell is not empty now so we use ! to force unwrapping
        cell!.contentView.backgroundColor = UIColor.clearColor()
        cell!.textLabel.text = NSString(format: "%@", DropDownOption.objectAtIndex(indexPath.row) as NSString)
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40.0
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        println("indexpath => \(indexPath.row)")
        
        if isMultipleSelection {
            if (arryData.containsObject(indexPath)) {
                arryData.removeObject(indexPath)
            }else{
                arryData.addObject(indexPath)
            }
            tableView.reloadData()
        }else {
            jbDelegate?.DropDownListViewDidSelect(indexPath.row)
            self.showFadeOut()
        }
        
    }
    
    //
    //  Show Drope down with animation
    //
    
    func showDropdownWithAnimation(parentView: UIView, animation: Bool) {
        
        parentView.addSubview(self)
        if animation {
            self.showFadeIn()
        }
    }
    
    func showFadeIn() {
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0;
        UIView.animateWithDuration(0.35, animations: {
            self.alpha = 1
            self.transform = CGAffineTransformMakeScale(1, 1)
        }, completion: nil)
        
        
    }
    
    func showFadeOut() {
        
        UIView.animateWithDuration(0.35, animations: {
            self.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.alpha = 0.0
            }, completion: { finished in
                self.removeFromSuperview()
        })
        
    }
    
    func callFingerTapToExit() {
        
        var singleTap = UITapGestureRecognizer(target: self, action: Selector("dissmissDropDownList"))
        singleTap.numberOfTouchesRequired = 1
        self.addGestureRecognizer(singleTap)
        
        
    }

    func dissmissDropDownList() {
        self.showFadeOut()
        self.removeFromSuperview()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        var touch = touches.anyObject() as UITouch
        
        if touch.view.isKindOfClass(UIView) {
            self.showFadeOut()
        }
        
    }
    
    func Click_Done(sender: UIButton!){
        
        var dataList = NSMutableArray()
        for (var i = 0; i < arryData.count; i++) {
            var arrayIndexPath = arryData.objectAtIndex(i) as NSIndexPath
            dataList.addObject(DropDownOption.objectAtIndex(arrayIndexPath.row))
        }
        jbDelegate?.DropDownListViewDataList(dataList)
        self.showFadeOut()
                
    }
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
