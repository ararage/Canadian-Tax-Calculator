//
//  ViewController.swift
//  Canadian Tax Calculator
//
//  Created by Ricardo Perez on 2/8/17.
//  Copyright © 2017 Ricardo Perez. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var txtInputCost: UITextField!
    @IBOutlet weak var pkrProvincePicker: UIPickerView!
    @IBOutlet weak var btnCalculateButton: UIButton!
    @IBOutlet weak var lblTotalCostLabel: UILabel!
    
    var listOfProvinces : [String] = ["Alberta",
                                      "British Columbia",
                                      "Manitoba",
                                      "New Brunswick",
                                      "Newfoundland and Labrador",
                                      "Northwest Territories",
                                      "Nova Scotia",
                                      "Nunavut",
                                      "Ontario",
                                      "P.E.I.",
                                      "Quebec",
                                      "Saskatchewan",
                                      "Yukon"
                                    ]
    
    var costInput : Double?
    var selectedProvince : String?
    var taxPercentage : Double?
    var taxType : String?
    var totalCost : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pkrProvincePicker.delegate = self
        self.pkrProvincePicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pressCalculateButton(_ sender: UIButton) {
        if let _ = Double(txtInputCost.text!){
            costInput = Double(txtInputCost.text!)!
            calculateAndPrintTotalCost()
        }
        txtInputCost.text?.removeAll()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 30
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return listOfProvinces.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return listOfProvinces[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedProvince = listOfProvinces[row]
        setTaxValue()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleForLabel = NSAttributedString(string: listOfProvinces[row], attributes: [NSFontAttributeName:UIFont(name:".SFCompactRounded-Bold",size:30)!])
        pickerLabel.attributedText = titleForLabel
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
    
    func setTaxValue(){
        switch selectedProvince! {
        case "Alberta","Northwet Territories","Nunavut","Yukon":
            taxType = "GST"
            taxPercentage = 5
        case "British Columbia":
            taxType = "GST and PST"
            taxPercentage = 12
        case "Manitoba":
            taxType = "GST and PST"
            taxPercentage = 13
        case "New Brunswick":
            taxType = "HST"
            taxPercentage = 15
        case "NewFoundland and Labrador":
            taxType = "HST"
            taxPercentage = 13
        case "P.E.I.":
            taxType = "HST"
            taxPercentage = 14
        case "P.E.I.":
            taxType = "HST"
            taxPercentage = 14
        case "Quebec":
            taxType = "GST and QST"
            taxPercentage = 14.975
        case "Saskatchewan":
            taxType = "GST and QST"
            taxPercentage = 10
        default:
            break
        }
    }
    
    func calculateAndPrintTotalCost(){
        let taxAmount = costInput! * (taxPercentage! / 100)
        totalCost = costInput! + taxAmount
        lblTotalCostLabel.text = "Total Cost + " + taxType! + " is " + String(format:"%.2f",totalCost!)
    }

}

