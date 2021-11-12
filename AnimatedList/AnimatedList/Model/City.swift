//
//  City.swift
//  AnimatedList
//
//  Created by Kaio Dantas on 12/11/2021.
//

import Foundation

class City {
    
    var name: String?
    var season: String?
    var seasonIcon: String?
    var backgroundImage: String?
    var text: String?

    init() { }
    
    init(name: String,
         season: String,
         seasonIcon: String,
         backgroundImage: String,
         text: String
    ) {
        self.name = name
        self.season = season
        self.seasonIcon = seasonIcon
        self.backgroundImage = backgroundImage
        self.text = text
    }
    
}
