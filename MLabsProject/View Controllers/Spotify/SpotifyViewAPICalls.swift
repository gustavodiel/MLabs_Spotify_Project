//
//  SpotifyViewAPICalls.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 23/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit
import Alamofire

/// Everything that calls Spotify's API goes here
extension SpotifyViewController {
    
    /// Calls spotify's API to get user's top artists.
    /// Then calls for the recommendations.
    /// ToDo: separate the functions
    func getTopArtist() {
        
        // If URL is not valid, there is no point in continuing
        guard let url = URL(string: Constants.SpotifyTopArtistURI) else {
            return
        }
        
        // We need that juicy session
        guard let session = self.getUserSession() else {
            sendOkAlert(self, title: Constants.Language.NeedToLoginToSpotifyTitle, message: Constants.Language.NeedToLoginToSpotifyMessage, isCritical: true)
            return
        }
        
        spinner = UIViewController.displaySpinner(onView: self.navigationController!.view)
        
        // Super basic header and the minumum Spotify needs.
        // ToDo: Make constant, static and put it somewhere else
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(session.accessToken!)"
        ]
        
        // The call's params.
        // For the artists, we only care about the quantity.
        // 5 should be fine
        let params = [
            "limit": "5"
        ]
        
        // create a queue so that we make the request on the background
        let queue = DispatchQueue(label: "com.gustavo.diel.MLabs", qos: .background, attributes: .concurrent)
        
        // Use Alamofire to make a GET request to user's top artists
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON(queue: queue) { (response) in
            if let result = response.result.value {
                
                self.artists.removeAll()
                let json = result as! NSDictionary
                
                for artistResponse in json["items"] as! [[String: Any]] {
                    let artistName = artistResponse["name"] as! String
                    let artistURI = artistResponse["uri"] as! String
                    let artistID = artistResponse["id"] as! String
                    
                    let artist = SpotifyArtist(name: artistName, uri: artistURI, id: artistID)
                    
                    self.artists.append(artist)
                }
            }
            /// ToDo: Remove this after testing is done
            self.getRecomended()
        }
    }
    
    /// Uses Spotify's API to get the users recomendations, and send the user's top artists
    /// so that the result fits the user's taste better
    func getRecomended() {
        
        // No point of calling a API without a proper URL
        guard let url = URL(string: Constants.SpotifyRecomendetionsURI) else {
            return
        }
        
        // We need that juicy session
        guard let session = self.getUserSession() else {
            // Can only send visual info from the main thread!
            DispatchQueue.main.async {
                sendOkAlert(self, title: Constants.Language.NeedToLoginToSpotifyTitle, message: Constants.Language.NeedToLoginToSpotifyMessage, isCritical: true)
            }
            return
        }
        
        // Minimum HTTP Header for Spotify
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(session.accessToken!)"
        ]
        
        // Here we limit the amout by 50 (I think that's the maximum it allows us)
        // also we send the user's top artists.
        // About the market, I dont think it is necessary, because of the artists.
        /// ToDo: Try to remove the market param
        let params = [
            "limit": "50",
            "seed_artists": self.artists.map{$0.id}.joined(separator: ","),
            "market": "BR"
        ]
        
        // Make a Queue so that we make the request on the background
        let queue = DispatchQueue(label: "com.gustavo.diel.MLabs", qos: .background, attributes: .concurrent)
        
        // Do the GET request for recomendations
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON(queue: queue) { (response) in
            if let result = response.result.value {
                
                // Now that we have a valid response, we clear the old buffer
                self.recomendation.removeAll()
                
                guard let json = result as? NSDictionary else {
                    return
                }
                
                for trackResponse in json["tracks"] as! [[String: Any]] {
                    
                    // There are two ways of getting the artist here
                    // First one: We already have stored it, and it is on the self.artists table
                    // Second one: We don't have it, so we create a new one :)
                    var trackArtist: SpotifyArtist?
                    
                    let artistsResponse = trackResponse["artists"] as! [[String: Any]]
                    let artistID = artistsResponse[0]["id"] as! String
                    
                    // Check if we have it, based on ID
                    for selfArtist in self.artists {
                        if selfArtist.id == artistID {
                            trackArtist = selfArtist
                            break
                        }
                    }
                    
                    // If we don't, then lets create a new one
                    if trackArtist == nil {
                        let artistName = artistsResponse[0]["name"] as! String
                        let artistURI = artistsResponse[0]["uri"] as! String
                        
                        trackArtist = SpotifyArtist(name: artistName, uri: artistURI, id: artistID)
                    }
                    
                    
                    // Get all track's parameters that we need
                    let trackName = trackResponse["name"] as! String
                    let trackID = trackResponse["id"] as! String
                    let trackURI = trackResponse["uri"] as! String
                    let trackURL = trackResponse["href"] as! String
                    let trackNumber = trackResponse["track_number"] as! Int
                    
                    
                    // Lets find the album
                    let albumResponse = trackResponse["album"] as! [String: Any]
                    let trackAlbumName = albumResponse["name"] as! String
                    
                    // Sometimes the album image is missing, that may be a JSON parsing bug, or a request problem.
                    // Worst case cenario: we dont have a image :c
                    var trackImageURL: String!
                    if let albumImages = albumResponse["images"] as? [[String: Any]] {
                        trackImageURL = albumImages[0]["url"] as! String
                    } else {
                        trackImageURL = ""
                    }
                    
                    // Create the track and store it
                    let track = SpotifyTrack(name: trackName, artist: trackArtist!, id: trackID, uri: trackURI, spotifyURL: trackURL, imageURL: trackImageURL, albumName: trackAlbumName, trackNumber: trackNumber)
                    
                    self.recomendation.append(track)
                }
            }
            
            // Visual elements MUST be executed on the main thread
            DispatchQueue.main.async {
                UIViewController.removeSpinner(spinner: self.spinner)
                // Update our table view to clear old tracks and add new ones
                self.tableView.reloadData()
            }
        }
    }
    
    /// Will get new releases to the user
    /// ToDo: make it better
    func getNew() {
        guard let url = URL(string: Constants.SpotifyNewReleasesURI) else {return}
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.session.accessToken!)"
        ]
        let params = [
            "limit": "10"
        ]
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (data) in
            debugPrint(data)
        }
    }
    
    /// Will get featured playlist for the user
    /// ToDo: make it better
    func getFeatured() {
        guard let url = URL(string: Constants.SpotifyFeaturedPlaylistsURI) else {return}
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(self.session.accessToken!)"
        ]
        let params = [
            "limit": "10"
        ]
        Alamofire.request(url, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (data) in
            debugPrint(data)
        }
    }
    
    /// Initiates Spotify's Music Player to play musics
    /// - Parameter authSession: current Sptify's Session.
    /// - Returns: `true` if the music player was created of `false` if it was not.
    func initializeMusicPlayer(authSession:SPTSession) -> Bool {
        if self.musicPlayer == nil {
            self.musicPlayer = SPTAudioStreamingController.sharedInstance()
            self.musicPlayer!.playbackDelegate = self
            self.musicPlayer!.delegate = self
            try! self.musicPlayer!.start(withClientId: self.spotifyAuth?.clientID)
            self.musicPlayer!.login(withAccessToken: authSession.accessToken)
            return self.musicPlayer != nil
        }
        return true
    }
    
    /// Plays a song using Spotify's API
    /// - Parameter music: Spotify's Music ID.
    /// - Parameter streamer: Spotify's API for Audio Steaming Controller.
    func play(music: String, streamer: SPTAudioStreamingController!) {
        self.musicPlayer?.playSpotifyURI(music, startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print(error!.localizedDescription)
            }
        })
    }
    
}
