//
//  Joke.swift
//  DadJokeIOS
//
//  Created by Andreas Liebich on 2020-12-09.
//

import Foundation

struct FavouriteJoke: Identifiable, Codable {
    var id = UUID()
    var joke: String
    
}
