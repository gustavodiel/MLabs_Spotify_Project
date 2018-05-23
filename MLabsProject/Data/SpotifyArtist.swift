//
//  SpotifyArtist.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 23/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit

class SpotifyArtist: NSObject {
    let name: String
    let uri: String
    let id: String
    
    init(name: String, uri: String, id: String) {
        self.name = name
        self.uri = uri
        self.id = id
    }
    
}
