//
//  ViewController.swift
//  CarML
//
//  Created by Valentin Sanchez on 28/04/2020.
//  Copyright © 2020 Valentin Sanchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cars = Cars()


    @IBOutlet weak var modelSegmented: UISegmentedControl!
    @IBOutlet weak var extrasSwitch: UISwitch!
    @IBOutlet weak var kilometersLabel: UILabel!
    @IBOutlet weak var kilometersSlider: UISlider!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var estateSegmented: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.calculateValue()
    }
    
    @IBAction func calculateValue(){
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formattedKms = formatter.string(for: self.kilometersSlider.value) ?? "0"
        self.kilometersLabel.text = "Kilometraje: \(formattedKms) kms."
        
        if let prediction = try? cars.prediction(
            modelo: Double(self.modelSegmented.selectedSegmentIndex),
            extras:  self.extrasSwitch.isOn ? Double(1.0) : Double(0.0),
            kilometraje: Double(self.kilometersSlider.value),
            estado: Double(estateSegmented.selectedSegmentIndex)){
            
            let clampValue = max(500, prediction.precio)
            
            formatter.numberStyle = .currency
            self.priceLabel.text = formatter.string(for: clampValue)
        }else{
            self.priceLabel.text = "Error"
        }
    }
}

