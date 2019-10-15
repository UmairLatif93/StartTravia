//
//  ViewController.swift
//  Star Travia
//
//  Created by Umair Latif on 09/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit

class SelectPersonVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var birthYearLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var homeWorldBtn: UIButton!
    @IBOutlet weak var starShipsBtn: UIButton!
    @IBOutlet weak var filmsBtn: UIButton!
    @IBOutlet weak var vehicleBtn: UIButton!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    
    
    var personAPI = PersonAPI()
    var person : Person!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func RandomButtonPressed(_ sender: UIButton) {
        
        let random = Int.random(in: 1 ... 87)
        spinnerIndicator.startAnimating()
        personAPI.getRandomPersonAlamo(id: random) { (person) in
            self.spinnerIndicator.stopAnimating()
            if let person = person {
                
                self.setupView(person: person)
                self.person = person
            }
        }
    }
    
    func setupView(person : Person){
        
        nameLabel.text = person.name
        heightLabel.text = person.height
        massLabel.text = person.mass
        hairLabel.text = person.hair
        birthYearLabel.text = person.birthYear
        genderLabel.text = person.gender
        
        homeWorldBtn.isEnabled = !person.homeWorldURLS.isEmpty
        vehicleBtn.isEnabled = !person.vehicleURLS.isEmpty
        starShipsBtn.isEnabled = !person.starShipURLS.isEmpty
        filmsBtn.isEnabled = !person.filmURLS.isEmpty
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toHomeWorld" {
            
            if let destination = segue.destination as? HomeworldVC {
                
                destination.person = person
            }
        }
        
        if segue.identifier == "toVehicles" {
            
            if let destination = segue.destination as? VehiclesVC {
                
                destination.person = person
            }
        }
        
        if segue.identifier == "toStarShips" {
            
            if let destination = segue.destination as? StarshipsVC {
                
                destination.person = person
            }
        }
        
        if segue.identifier == "toFilms" {
            
            if let destination = segue.destination as? FilmsVC {
                
                destination.person = person
            }
        }
    }
    
}

