//
//  SpotifyTrack.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 23/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit
import UIImageColors

class SpotifyTrack: NSObject {
    let name: String
    let artist: SpotifyArtist
    let id: String
    let uri: String
    let spotifyURL: String
    let imageURL: String
    let albumName: String
    let trackNumber: Int
    var image: UIImage
    var imageColor: UIImageColors?
    
    var isPlaying = false
    
    init(name: String, artist: SpotifyArtist, id: String, uri: String, spotifyURL: String, imageURL: String, albumName: String, trackNumber: Int){
        self.name = name
        self.artist = artist
        self.id = id
        self.uri = uri
        self.spotifyURL = spotifyURL
        self.imageURL = imageURL
        self.albumName = albumName
        self.trackNumber = trackNumber
        self.image = UIImage()
        self.imageColor = nil
    }
    
    /// Downloads a Image async and notify a task group that it is done.
    /// - parameter taskGroup: that task group that is handling the threads
    func downloadImage(withTaskGroup taskGroup: DispatchGroup) {
        taskGroup.enter()
        if self.imageURL != "" {
            let url = URL(string: self.imageURL)
            URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    return
                }
                if let donwloaded = UIImage(data: data!){
                    self.image = donwloaded
                    self.imageColor = self.image.getColors(quality: .low)
                    taskGroup.leave()
                    DispatchQueue.main.async {
                        Constants.ImageCache.setObject(donwloaded, forKey: self.imageURL as AnyObject)
                    }
                }
            }.resume()
        }
    }
    
    /// Opens the track on Spotify (Safari if Spotify is not installed)
    func openOnSpotify() {
        var url = URL(string:"https://open.spotify.com/track/\(self.id)")!
        if isSpotifyInstalled() {
            url = URL(string:"spotify:track:\(self.id)")!
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
        
    }
    
}
