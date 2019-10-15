//
//  HomeworldVC.swift
//  Star Travia
//
//  Created by Umair Latif on 14/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit

class HomeworldVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var climateLbl: UILabel!
    @IBOutlet weak var terrainLbl: UILabel!
    @IBOutlet weak var populationLbl: UILabel!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    
    
    var person : Person!
    
    let api = HomeworldAPI()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        spinnerIndicator.startAnimating()
        
        api.getHomeWorld(url: person.homeWorldURLS) { (homeworld) in
            
            self.spinnerIndicator.stopAnimating()
            
            if let homeworld = homeworld {
                
                self.setupUI(homeworld: homeworld)
            }
        }
    }
    
    func setupUI(homeworld : Homeworld){
        
        nameLbl.text = homeworld.name
        climateLbl.text = homeworld.climate
        terrainLbl.text = homeworld.terrain
        populationLbl.text = homeworld.population
    }
    
}
