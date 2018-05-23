//
//  SpotifyTrack.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 23/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit

class SpotifyTrack: NSObject {
    let name: String
    let artist: SpotifyArtist
    let id: String
    let uri: String
    let spotifyURL: String
    let imageURL: String
    let albumName: String
    let trackNumber: Int
    
    init(name: String, artist: SpotifyArtist, id: String, uri: String, spotifyURL: String, imageURL: String, albumName: String, trackNumber: Int){
        self.name = name
        self.artist = artist
        self.id = id
        self.uri = uri
        self.spotifyURL = spotifyURL
        self.imageURL = imageURL
        self.albumName = albumName
        self.trackNumber = trackNumber
    }
    
}
