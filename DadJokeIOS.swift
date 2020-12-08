//
//  DadJokeIOS.swift
//  DadJokeIOS
//
//  Created by Andreas Liebich on 2020-12-08.
//

import Foundation

struct Joke: Decodable {
    var id: String
    var joke: String
    var status: Int
}
