//
//  PersonAPI.swift
//  Star Travia
//
//  Created by Umair Latif on 09/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PersonAPI {
    
    //Web Request with Alamofire and SwiftyJSON
    
    func getRandomPersonAlamo(id : Int, completion : @escaping PersonResponseCompletion){
        
        guard let url = URL(string: "\(PEOPLE_URL)\(id)") else { return }
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.result.error {
                
                print(error)
                completion(nil)
                return
            }
           
            guard let data = response.data else { return completion(nil)}
            
            do{
                
                let json = try JSON(data: data)
                let person = self.parsePersonSwifty(json: json)
                 completion(person)
            }
            catch{
                
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
    // Web Request with Alamofire and Manual Parsing
    
//    func getRandomPersonAlamo(id : Int, completion : @escaping PersonResponseCompletion){
//
//        guard let url = URL(string: "\(PEOPLE_URL)\(id)") else { return }
//
//        Alamofire.request(url).responseJSON { (response) in
//
//            if let error = response.result.error {
//
//                print(error)
//                completion(nil)
//                return
//            }
//            else {
//
//                guard let json = response.result.value as? [String : Any] else {
//
//                    completion(nil)
//                    return
//
//                }
//
//                let person = self.parsePersonManual(json: json)
//                completion(person)
//            }
//        }
//    }
    
    
    // Web Request with URL Session
//    func getRandomPersonUrlSession(id : Int, completion : @escaping PersonResponseCompletion){
//
//        guard let url = URL(string: "\(PEOPLE_URL)\(id)") else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//            guard error == nil else {
//
//                debugPrint(error.debugDescription)
//                completion(nil)
//                return
//            }
//
//            guard let data = data else { return }
//
//            do{
//
//                let jsonAny = try JSONSerialization.jsonObject(with: data, options: [])
//                guard let json = jsonAny as? [String: Any] else { return }
//                let person = self.parsePersonManual(json: json)
//                DispatchQueue.main.async {
//
//                    completion(person)
//                }
//
//
//            } catch {
//
//                debugPrint(error.localizedDescription)
//                return
//            }
//        }
//
//        task.resume()
//    }
    
    
//Parsing Manual
//    private func parsePersonManual(json : [String : Any]) -> Person{
//
//        let name = json["name"] as? String ?? ""
//        let height = json["height"] as? String ?? ""
//        let mass = json["mass"] as? String ?? ""
//        let hair = json["hair_color"] as? String ?? ""
//        let birthYear = json["birth_year"] as? String ?? ""
//        let gender = json["gender"] as? String ?? ""
//        let homeWorldURLS = json["homewrold"] as? String ?? ""
//        let filmURLS = json["films"] as? [String] ?? [String]()
//        let vehicleURLS = json["vehicles"] as? [String] ?? [String]()
//        let starShipURLS = json["starships"] as? [String] ?? [String]()
//
//        return Person(name: name, height: height, mass: mass, hair: hair, birthYear: birthYear, gender: gender, homeWorldURLS: homeWorldURLS, filmURLS: filmURLS, vehicleURLS: vehicleURLS, starShipURLS: starShipURLS)
//    }
    
    
//Parsing with SwiftyJSON
    
        private func parsePersonSwifty(json : JSON) -> Person{
    
            let name = json["name"].stringValue
            let height = json["height"].stringValue
            let mass = json["mass"].stringValue
            let hair = json["hair_color"].stringValue
            let birthYear = json["birth_year"].stringValue
            let gender = json["gender"].stringValue
            let homeWorldURLS = json["homeworld"].stringValue
            let filmURLS = json["films"].arrayValue.map({$0.stringValue})
            let vehicleURLS = json["vehicles"].arrayValue.map({$0.stringValue})
            let starShipURLS = json["starships"].arrayValue.map({$0.stringValue})
    
            return Person(name: name, height: height, mass: mass, hair: hair, birthYear: birthYear, gender: gender, homeWorldURLS: homeWorldURLS, filmURLS: filmURLS, vehicleURLS: vehicleURLS, starShipURLS: starShipURLS)
        }
    
}
