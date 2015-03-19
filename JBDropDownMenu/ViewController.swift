//
//  ViewController.swift
//  JBDropDownMenu
//
//  Created by Developer on 19/03/15.
//  Copyright (c) 2015 JBGroup. All rights reserved.
//

import UIKit

class ViewController: UIViewController, JBDropDownDelegate {

    var categoryArray: NSMutableArray!
    var jbdropdrownView: JBDropDownList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        categoryArray = NSMutableArray(objects: "India","Swaziland","Africa","Australlia","Kuwait")
        jbdropdrownView = JBDropDownList(frame: UIScreen.mainScreen().bounds)
        jbdropdrownView.jbDelegate = self
        jbdropdrownView.callInitialSetup("OKK", listValues: categoryArray, isMultiple: true)
    }
    
    //
    //  UIbutton Action
    //
    @IBAction func showMyDropdownList(sender: AnyObject) {
        
        jbdropdrownView.showDropdownWithAnimation(self.view, animation: true)
        
    }
    
    //
    //  JBDropdown Delegate
    //
    
    func DropDownListViewDataList(datalist: NSMutableArray) {
        println(datalist)
    }
    
    func DropDownListViewDidSelect(didSelectedIndex: NSInteger) {
        println(didSelectedIndex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

