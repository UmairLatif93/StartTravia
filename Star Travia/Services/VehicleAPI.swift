//
//  VehicleAPI.swift
//  Star Travia
//
//  Created by Umair Latif on 15/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import Foundation
import Alamofire

class VehicleAPI {
    
    func GetVehicles(url : String, completion : @escaping VehiclesResponseCompletion){
        
        guard let url = URL(string: url) else {return}
        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.result.error {
                
                print(error.localizedDescription)
                completion(nil)
                return
            }
            else {
                
                guard let data = response.data else {return completion(nil)}
                let jsonDecoder = JSONDecoder()
                
                do{
                    
                    let vehicles = try jsonDecoder.decode(Vehicles.self, from: data)
                    completion(vehicles)
                    
                } catch{
                    
                    print(error.localizedDescription)
                    completion(nil)
                }
                
            }
        }
    }
}
