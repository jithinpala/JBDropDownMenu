# JBDropDownMenu

## Usage
Please download example project and run 

To close a popup, just call close() function of PopupContainer.

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
      }

## Requirements

iOS 8.0+

## Screen Shot

![alt tag](https://github.com/jithinpala/JBDropDownMenu/blob/master/JBDropDownMenu/JBDropDown.gif)
