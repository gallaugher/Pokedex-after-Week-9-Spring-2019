//
//  Pokemon.swift
//  Pokedex
//
//  Created by John Gallaugher on 3/18/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Pokemon {
    struct PokeData {
        var name: String
        var url: String
    }
    
    var pokeArray: [PokeData] = []
    var apiURL = "https://pokeapi.co/api/v2/pokemon"
    var totalPokemon = 0
    
    func getPokemon(completed: @escaping () -> () ) {
        Alamofire.request(apiURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.totalPokemon = json["count"].intValue
                self.apiURL = json["next"].stringValue
                let numberOfPokemon = json["results"].count
                for index in 0..<numberOfPokemon {
                    let name = json["results"][index]["name"].stringValue
                    let url = json["results"][index]["url"].stringValue
                    self.pokeArray.append(PokeData(name: name, url: url))
                }
            case .failure(let error):
                print("ERROR: \(error.localizedDescription) failed to get data from url \(self.apiURL)")
            }
            completed()
        }
    }
}
