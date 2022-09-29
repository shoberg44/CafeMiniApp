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
    var bag : (String) = "" //cart mem during dev mode
    override func viewDidLoad() {
        super.viewDidLoad()
        /* Do any additional setup after loading the view.
        
        for i in 0 ..< ages.count{
            print(ages[i])
        } //... inclusive of 1 ..< exlusisive of one
        
    */
        
        items.append("apple")
        prices.append(2.08)
        items.append("steak")
        prices.append(8.00)
        items.append("water")
        prices.append(1.50)
        items.append("shake")
        prices.append(5.75)
        items.append("potato")
        prices.append(3.75)
        updateMenu()
        
        
        
        
        
        ///Stolen Code \/\/
        //Looks for single or multiple taps.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
    }
    func updateMenu(){
        menuLabel.text = ""
        for i in 0 ..< items.count{
                menuLabel.text = (menuLabel.text ?? " ") + "\(items[i])\t\(prices[i])\n"
        }
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    @IBAction func sortButton2(_ sender: UIButton) {
        var tuple = (itemCart,true)
        while tuple.1 == true{
            
            tuple = strBubStep(strDArray: tuple.0)
        }
        itemCart = tuple.0
        updateCart()
    }
        
    @IBAction func sortButton(_ sender: UIButton) {
        itemCart.sort(by: sortDem(string1:string2:))
        updateCart()
        
    }
    func findPrice(inputString str: String)->Double{
            for i in 0 ..< items.count{
                if items[i] == str{
                    return prices[i]
                }
            }
        return 0.0
    }
    func strBubStep(strDArray stuff: [String])->([String],Bool){ //set stuff as new var sort that not old cartList
        var tempList = stuff
        if tempList.count == 1{
            return (tempList,false)
        }
        var acted = false
        var str = ""
        for i in 0 ..< tempList.count-1{
            if findPrice(inputString: tempList[i]) < findPrice(inputString: tempList[i+1]){
                str = tempList[i+1]
                tempList[i+1] = tempList[i]
                tempList[i] = str
                acted = true
            }
        }
        return (tempList,acted)
    }
    func updateCart(){
        price = 0
        cartOutput.text = ""
        for i in 0 ..< itemCart.count{//for each item in cart. search master list for matching name location and therefoe matching price.
            for f in 0 ..< items.count{
                if itemCart[i] == items[f]{//finds which index in master list belongs to which item in cart. note not a garrentie i will = to f. Thats stupid stop thinking that.
                    price += prices[f]//calculate price
                    price = round(price * 100) / 100.0 // round to .00
                    priceOutput.text = "$\(price)"//update price
                    
                    cartOutput.text = "\(cartOutput.text!)\n" + "\(items[f])\t\(prices[f])"
                    break
                }
            }
        }
    }
    func sortDem(string1: String, string2: String)->Bool{
        string1 < string2
    }
    func sortDem2(num1: Double, num2: Double)->Bool{
        num1 < num2
    }
    var devmode = 0
    func find(_ s1: String)->(Bool,Int){
        for i in 0 ..< items.count{
            if s1 == items[i]{
                return (true,i)
            }
        }
        return (false,-1)
    }
    @IBAction func cartAdd(_ sender: UIButton) {
        //var storage : (String)
        alert.text = "Not on the menu!"
        alert.isHidden = true
        if textInput.text != "" {//ensure text in feild
            
            
            /*dev mode explantion
             there is probably a better way to do it
             
             dev = 0 ; not in mode
             dev = 1 ; pending init command
             dev = 2 ; pending price
             back to 1
            */
            
            if ((textInput.text! != "exit")&&(textInput.text! != "pass")) && devmode == 1{//checks for first command ignores exit (exit is read when )
                let tuple = find(textInput.text!)
                if tuple.0 == true{
                    items.remove(at: tuple.1)
                    updateMenu()
                }
                else{
                items.append(textInput.text!)
                textInput.text = ""
                textInput.placeholder = "Now set a price!"
                devmode = 2
                }
            }
            else if devmode == 2{
                if let num = Double(textInput.text!)  {
                    prices.append(num)
                    textInput.text = ""
                    textInput.placeholder = "Add Item's Here"
                    devmode = 1
                    updateMenu()
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
                cartOutput.text = bag
            }
            else{
                //\//////////end of dev mode code/////
                for i in 0 ..< items.count{//iterate through menu array
                    if textInput.text == items[i]{//if match
                        itemCart.append(textInput.text!)//add to your car array
                        price += prices[i]//calculate price
                        price = round(price * 100) / 100.0 // round to .00
                        priceOutput.text = "$\(price)"//update price
                        cartOutput.text = "\(cartOutput.text!)\n" + "\(items[i])\t\(prices[i])"
                        textInput.text = ""
                        break//break loop since item found
                        
                    }
                    
                   //devmode path
                    else if textInput.text == "pass" {
                        view.backgroundColor = UIColor.systemRed
                        bag = cartOutput.text ?? " "
                        cartOutput.text = "Manager Mode\nType 'exit' to exit mode"
                        devmode = 1
                        textInput.text = ""
                        
                        break
                    }
                    else{
                        if i == (items.count-1){ //see if at end
                            alert.isHidden = false
                        }
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
