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
        
       
    }
    @IBAction func cartAdd(_ sender: UIButton) {
        
        
        if textInput.text != "" {//ensure text in feild
            for i in 0 ..< items.count{//iterate through menu array
                if textInput.text == items[i]{//if match
                    itemCart.append(textInput.text!)//add to your car array
                    price += prices[i]//calculate price
                    priceOutput.text = "$\(price)"//update price
                    break//break loop since item found
                }
                else{
                    cartOutput.text = "Item doesn't exist!"
                }
                
            }
        }
        
        
        
        
        //... inclusive of 1 ..< exlusisive of one
    }
    

}

