//
//  StarshipsVC.swift
//  Star Travia
//
//  Created by Umair Latif on 14/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit

class StarshipsVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var makerLbl: UILabel!
    @IBOutlet weak var costLbl: UILabel!
    @IBOutlet weak var crewLbl: UILabel!
    @IBOutlet weak var passengerLbl: UILabel!
    @IBOutlet weak var cargoLbl: UILabel!
    @IBOutlet weak var consumeableLbl: UILabel!
    @IBOutlet weak var classLbl: UILabel!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    
    
    var person : Person!
    var api = StarshipsAPI()
    var starshipArray = [String]()
    var currentStarship : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        starshipArray = person.starShipURLS
        nextBtn.isEnabled = starshipArray.count > 1
        previousBtn.isEnabled = false
        guard let firstShip = starshipArray.first else {return}
        getStarShip(url: firstShip)
    }
    
    func getStarShip(url : String){
        
        spinnerIndicator.startAnimating()
        
        api.GetStarShips(url: url) { (starship) in
            
            self.spinnerIndicator.stopAnimating()
            
            if let starship = starship {
                
                self.setupUI(starship: starship)
            }
        }
    }
    
    func setupUI(starship : Starships){
        
        nameLbl.text = starship.name
        modelLbl.text = starship.model
        makerLbl.text = starship.manufacturer
        costLbl.text = starship.cost_in_credits
        crewLbl.text = starship.crew
        passengerLbl.text = starship.passengers
        cargoLbl.text = starship.cargo_capacity
        consumeableLbl.text = starship.consumables
        classLbl.text = starship.starship_class
    }
    
    
    @IBAction func previousClicked(_ sender: Any) {
        
        currentStarship -= 1
        getButtonState()
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        
        currentStarship += 1
        getButtonState()
    }
    
    func getButtonState() {
        
        if currentStarship == 0 {
            
            previousBtn.isEnabled = false
        }
        else {
            
            previousBtn.isEnabled = true
        }
        
        if currentStarship == starshipArray.count - 1 {
            
            nextBtn.isEnabled = false
        }
        else {
            
            nextBtn.isEnabled = true
        }
        
        getStarShip(url: starshipArray[currentStarship])
    }
}
