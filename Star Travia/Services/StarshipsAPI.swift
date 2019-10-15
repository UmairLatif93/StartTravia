//
//  StarshipsAPI.swift
//  Star Travia
//
//  Created by Umair Latif on 15/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import Foundation
import Alamofire

class StarshipsAPI {
    
    func GetStarShips(url : String, completion : @escaping StarshipsResponseCompletion){
        
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
                    let starships = try jsonDecoder.decode(Starships.self, from: data)
                    completion(starships)
                    
                }catch{
                    
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
    }
}
