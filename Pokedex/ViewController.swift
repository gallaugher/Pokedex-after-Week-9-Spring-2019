//
//  ViewController.swift
//  Pokedex
//
//  Created by John Gallaugher on 3/18/19.
//  Copyright © 2019 John Gallaugher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // var pokeArray = ["Pikachu", "Snorlax", "Bulbasaur", "Meetoo", "Prof. G"]
    var pokemon = Pokemon()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        pokemon.getPokemon {
            self.tableView.reloadData()
            self.navigationItem.title = "\(self.pokemon.pokeArray.count) of \(self.pokemon.totalPokemon) Pokemon"
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.pokeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row+1). \(pokemon.pokeArray[indexPath.row].name)"
        
        // should I get more data?
        print("indexPath.row = \(indexPath.row) pokeArray.count-1 = \(pokemon.pokeArray.count-1)")
        if indexPath.row == pokemon.pokeArray.count-1 && pokemon.apiURL.hasPrefix("http") {
            print("👊👊 Making a call to get more data! 👊👊")
            pokemon.getPokemon {
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.pokemon.pokeArray.count) of \(self.pokemon.totalPokemon) Pokemon"
            }
        }
        
        return cell
    }
    
    
}
