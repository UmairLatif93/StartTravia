//
//  FilmsAPI.swift
//  Star Travia
//
//  Created by Umair Latif on 15/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import Foundation
import Alamofire

class FilmsAPI {

func GetFilms(url : String, completion : @escaping FilmsResponseCompletion){
       
       guard let url = URL(string: url) else {return}
       Alamofire.request(url).responseJSON { (response) in
           
           if let error = response.result.error {
               
               print(error.localizedDescription)
               completion(nil)
               return
           }
           else {
               
               guard let data = response.data else {return}
               let jsonDecoder = JSONDecoder()
               
               do{
                   let films = try jsonDecoder.decode(Films.self, from: data)
                   completion(films)
                   
               }catch{
                   
                   print(error.localizedDescription)
                   completion(nil)
               }
           }
       }
   }
}
