//
//  ViewController.swift
//  CafeMiniApp
//
//  Created by STEVEN HOBERG on 9/14/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textInput: UITextField!
    @IBOutlet weak var priceOutput: UILabel!
    @IBOutlet weak var cartOutput: UILabel!
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var alert: UILabel!
    
    var items = [String]()
    var prices = [Double]()
    var itemCart = [String]()
    var price : (Double) = 0.00
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Do any additional setup after loading the view.
        
        for i in 0 ..< ages.count{
            print(ages[i])
        } //... inclusive of 1 ..< exlusisive of one
        
    */
        for i in 0 ..< items.count{
        menuLabel.text = "\(items[i])\t\(prices[i])"
        }
        items.append("apple")
        prices.append(2.08)
        items.append("steak")
        prices.append(8.00)
        items.append("water")
        prices.append(1.50)
        items.append("shake")
        prices.append(5.75)
        
        
        
        
        
        
        ///Stolen Code \/\/
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    var devmode = 0
    @IBAction func cartAdd(_ sender: UIButton) {
        /*
         else if textInput.text == "exit" && devmode == 1{
             view.backgroundColor = UIColor.systemBackground
             cartOutput.text = ""
             textInput.text = ""
             devmode = 0
             break
         }
        */
        //var storage : (String)
        alert.isHidden = true
        alert.text = "Not on the menu!"
        if textInput.text != "" {//ensure text in feild
            print("devmode --> \(devmode)")
            
            
            /*dev mode explantion
             there is probably a better way to do it
             
             dev = 0 ; not in mode
             dev = 1 ; pending init command
             dev = 2 ; pending price
             back to 1
            */
            
            if ((textInput.text! != "exit")&&(textInput.text! != "pass")) && devmode == 1{//checks for first command ignores exit (exit is read when )
                print(textInput.text!)
                items.append(textInput.text!)
                print(items)
                textInput.text = ""
                textInput.placeholder = "Now set a price!"
                devmode = 2
            }
            else if devmode == 2{
                if let num = Double(textInput.text!)  {
                    prices.append(num)
                    textInput.text = ""
                    textInput.placeholder = "Add Item's Here"
                    print(prices)
                    devmode = 1
                }
                else {
                    alert.text = "Invalid Input"
                    alert.isHidden = false
                }
            }
            else if (textInput.text == "exit") && (devmode == 1){
                view.backgroundColor = UIColor.systemBackground
                cartOutput.text = ""
                textInput.text = ""
                devmode = 0
            }
            else{
                //\//////////end of dev mode code/////
                for i in 0 ..< items.count{//iterate through menu array
                    if textInput.text == items[i]{//if match
                        itemCart.append(textInput.text!)//add to your car array
                        price += prices[i]//calculate price
                        price = round(price * 100) / 100.0 // round to .00
                        priceOutput.text = "$\(price)"//update price
                        print("found")
                        cartOutput.text = "\(cartOutput.text!)\n" + "\(items[i])\t\(prices[i])"
                       
                        priceOutput.text = "$\(price)"//update price
                        break//break loop since item found
                        
                    }
                    
                   //devmode path
                    else if textInput.text == "pass" {
                        view.backgroundColor = UIColor.systemRed
                        cartOutput.text = "Manager Mode\nType 'exit' to exit mode"
                        devmode = 1
                        textInput.text = ""
                        break
                    }
                    else{
                        alert.isHidden = false
                    }
                }
            }
        }
        else{
            textInput.placeholder = "Type in something"
        //note... inclusive of 1 ..< exlusisive of one
            print("blank click")
        }
    }
}
