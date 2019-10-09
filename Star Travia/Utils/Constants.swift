//
//  Constants.swift
//  Star Travia
//
//  Created by Umair Latif on 09/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import UIKit

let BlackBG = UIColor.black.withAlphaComponent(0.6).cgColor

let URL_BASE = "https://swapi.co/api/"

let PEOPLE_URL = URL_BASE + "people/"

typealias PersonResponseCompletion = (Person?) -> Void
