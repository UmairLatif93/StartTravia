//
//  PersonAPI.swift
//  Star Travia
//
//  Created by Umair Latif on 09/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import Foundation

class PersonAPI {
    
    func getRandomPersonUrlSession(id : Int, completion : @escaping PersonResponseCompletion){
        
        guard let url = URL(string: "\(PEOPLE_URL)\(id)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                
                debugPrint(error.debugDescription)
                completion(nil)
                return
            }
            
            guard let data = data else { return }
            
            do{
                
                let jsonAny = try JSONSerialization.jsonObject(with: data, options: [])
                guard let json = jsonAny as? [String: Any] else { return }
                let person = self.parsePersonManual(json: json)
                DispatchQueue.main.async {
                    
                    completion(person)
                }
                
                
            } catch {
                
                debugPrint(error.localizedDescription)
                return
            }
        }
        
        task.resume()
    }
    
    private func parsePersonManual(json : [String : Any]) -> Person{
        
        let name = json["name"] as? String ?? ""
        let height = json["height"] as? String ?? ""
        let mass = json["mass"] as? String ?? ""
        let hair = json["hair_color"] as? String ?? ""
        let birthYear = json["birth_year"] as? String ?? ""
        let gender = json["gender"] as? String ?? ""
        let homeWorldURLS = json["homewrold"] as? String ?? ""
        let filmURLS = json["films"] as? [String] ?? [String]()
        let vehicleURLS = json["vehicles"] as? [String] ?? [String]()
        let starShipURLS = json["starships"] as? [String] ?? [String]()
        
        return Person(name: name, height: height, mass: mass, hair: hair, birthYear: birthYear, gender: gender, homeWorldURLS: homeWorldURLS, filmURLS: filmURLS, vehicleURLS: vehicleURLS, starShipURLS: starShipURLS)
    }
}
