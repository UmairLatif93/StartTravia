//
//  FilmsVC.swift
//  Star Travia
//
//  Created by Umair Latif on 14/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit

class FilmsVC: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var episodeLbl: UILabel!
    @IBOutlet weak var directorLbl: UILabel!
    @IBOutlet weak var producerLbl: UILabel!
    @IBOutlet weak var releaseLbl: UILabel!
    @IBOutlet weak var previousBtn: FadeEnabledButton!
    @IBOutlet weak var nextBtn: FadeEnabledButton!
    @IBOutlet weak var crawlLbl: UITextView!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    
    
    var person : Person!
    var api = FilmsAPI()
    var filmsArray = [String]()
    var currentFilm : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        filmsArray = person.filmURLS
        nextBtn.isEnabled = filmsArray.count > 1
        previousBtn.isEnabled = false
        guard let firstFilm = filmsArray.first else {return}
        getFilm(url: firstFilm)
    }
    
    func getFilm(url : String){
        
        spinnerIndicator.startAnimating()
        
        api.GetFilms(url: url) { (films) in
            
            self.spinnerIndicator.stopAnimating()
            
            if let films = films {
                
                self.setupUI(films: films)
            }
        }
    }
    
    func setupUI(films : Films){
        
        titleLbl.text = films.title
        episodeLbl.text = String(films.episode_id)
        directorLbl.text = films.director
        producerLbl.text = films.producer
        releaseLbl.text = films.release_date
        crawlLbl.text = films.opening_crawl
    }
    
    @IBAction func previousClicked(_ sender: Any) {
        
        currentFilm -= 1
        getButtonState()
    }
    
    @IBAction func nextClicked(_ sender: Any) {
        
        currentFilm += 1
        getButtonState()
    }
    
    func getButtonState() {
        
        if currentFilm == 0 {
            
            previousBtn.isEnabled = false
        }
        else {
            
            previousBtn.isEnabled = true
        }
        
        if currentFilm == filmsArray.count - 1 {
            
            nextBtn.isEnabled = false
        }
        else {
            
            nextBtn.isEnabled = true
        }
        
        getFilm(url: filmsArray[currentFilm])
    }
    
}
