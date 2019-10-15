//
//  VehiclesVC.swift
//  Star Travia
//
//  Created by Umair Latif on 14/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit

class VehiclesVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var manufacturerLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var lenghtLbl: UILabel!
    @IBOutlet weak var maxSpeedLbl: UILabel!
    @IBOutlet weak var crewLbl: UILabel!
    @IBOutlet weak var passengerLbl: UILabel!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    
    var person : Person!
    let api = VehicleAPI()
    var vehiclesArray = [String]()
    var currentVehicle : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        vehiclesArray = person.vehicleURLS
        nextBtn.isEnabled = vehiclesArray.count > 1
        previousBtn.isEnabled = false
        guard let firstVehicle = vehiclesArray.first else {return}
        getVehicle(url: firstVehicle)
    }
    
    func getVehicle(url : String){
        
        spinnerIndicator.startAnimating()
        
        api.GetVehicles(url: url) { (vehicles) in
            
            self.spinnerIndicator.stopAnimating()
            
            if let vehicle = vehicles {
                
                self.setupUI(vehicle: vehicle)
            }
        }
    }
    
    func setupUI(vehicle : Vehicles){
        
        nameLbl.text = vehicle.name
        modelLbl.text = vehicle.model
        manufacturerLbl.text = vehicle.manufacturer
        costLbl.text = vehicle.cost_in_credits
        lenghtLbl.text = vehicle.length
        maxSpeedLbl.text = vehicle.max_atmosphering_speed
        crewLbl.text = vehicle.crew
        passengerLbl.text = vehicle.passengers
    }
    
    @IBAction func previousClicked(_ sender: UIButton) {
        
        currentVehicle -= 1
        setButtonState()
    }
    
    @IBAction func nextClicked(_ sender: UIButton) {
        
        currentVehicle += 1
        setButtonState()
    }
    
    func setButtonState(){
        
        if currentVehicle == 0 {
            
            previousBtn.isEnabled = false
        }
        else {
            
            previousBtn.isEnabled = true
        }
        
        if currentVehicle == vehiclesArray.count - 1 {
            
            nextBtn.isEnabled = false
        }
        else {
            
            nextBtn.isEnabled = true
        }
        
        getVehicle(url: vehiclesArray[currentVehicle])
    }
}
