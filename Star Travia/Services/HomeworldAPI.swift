//
//  HomeworldAPI.swift
//  Star Travia
//
//  Created by Umair Latif on 15/10/2019.
//  Copyright © 2019 Umair Latif. All rights reserved.
//

import Foundation
import Alamofire

class HomeworldAPI {
    
    func getHomeWorld(url : String, completion : @escaping HomeworldResponseCompletion){
        
        guard let url = URL(string: url) else { return }
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.result.error {
                
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            else {
                
                guard let data = response.data else { return completion(nil)}
                let jsonDecoder = JSONDecoder()
                do{
                    
                    let homeworld = try jsonDecoder.decode(Homeworld.self, from: data)
                    completion(homeworld)
                    
                } catch {
                    
                    debugPrint(error.localizedDescription)
                    completion(nil)
                }
            }
        }
    }
}
