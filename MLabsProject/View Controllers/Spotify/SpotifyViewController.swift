//
//  SpotifyViewController.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit

/*!
 SpotifyViewController: creates a view to Login, Logout and check the recomendations for Spotify's service.
 */
class SpotifyViewController: UITableViewController {
    
    /// Cell ID to requeue cell
    let CellID = "SpotifyCellID"
    
    /// Reference to the root tab bar view controller
    var customTabViewController: MainTabBarViewController!
    
    /// Reference to Spotify's Authorization instance
    var spotifyAuth = SPTAuth.defaultInstance()
    
    /// Spotify's Session instance reference
    var session: SPTSession!
    
    /// Spotify's Audio Stream controller reference
    var musicPlayer: SPTAudioStreamingController?
    
    /// Spotify's User reference
    var user: SPTUser?
    
    /// URL used by Spotify to login
    var loginUrl: URL?
    
    /// User's TOP artists
    var artists = [SpotifyArtist]()
    
    /// User's recommended tracks
    var spotifyRecomendations = [SpotifyTrack]()
    
    /// Spinner that indicates that we are loading from the web
    var spinner: UIView!
    
    /// The track object of the current playing song
    var currentPlayingMusic: SpotifyTrack?
    
    /// The cell of the current playing song
    var currentPlayingMusicCell: SpotifyViewCell?
    
    let tableFooterTextView: UITextView = {
        let tx = UITextView()
        tx.translatesAutoresizingMaskIntoConstraints = false
        tx.textAlignment = .center
        tx.tintColor = .lightGray
        tx.font = .preferredFont(forTextStyle: UIFontTextStyle.headline)
        return tx
    }()
    
    let tableFooterView: UIView = {
        let fv = UIView()
        fv.frame = CGRect(x: 0, y: 0, width: 100, height: 256)
        return fv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
        self.setupSpotify()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAfterFirstLogin), name: NSNotification.Name(rawValue: Constants.OnUserLoggedInNotificationID), object: nil)
        
        self.checkForUserSession()
        
    }
    
    /// Set up interface of current view.
    fileprivate func setupView() {
        
        // Change the background to color, otherwise its clear
        self.view.backgroundColor = .white
        
        // Default title
        self.navigationItem.title = "Spotify"
        self.tabBarItem.title = "Spotify"
        
        // Prepare Table View
        self.tableView.delegate = self
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelection = false
        self.tableView.register(SpotifyViewCell.self, forCellReuseIdentifier: self.CellID)
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = tableFooterView
        
        self.configureConstraints()
        
        // Create a left bar item, to login/logoff the user
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.Language.Login, style: .plain, target: self, action: #selector(handleLeftBarButtonItem))
        
        // We currently support iOS 10, and largeTitle is not available there
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    /// Configure the constraints of the UI elements
    fileprivate func configureConstraints() {
        tableFooterView.addSubview(tableFooterTextView)
        tableFooterTextView.text = Constants.Language.PleaseLoginToSpotify
        
        tableFooterTextView.centerXAnchor.constraint(equalTo: tableFooterView.centerXAnchor, constant: 0).isActive = true
        tableFooterTextView.centerYAnchor.constraint(equalTo: tableFooterView.centerYAnchor, constant: 0).isActive = true
        tableFooterTextView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        tableFooterTextView.widthAnchor.constraint(equalTo: tableFooterView.widthAnchor, constant: 0).isActive = true
    }
    
    
    /// MARK: Table View
    /// =====================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.spotifyRecomendations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue cell for maximum performance
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! SpotifyViewCell
        
        // Get the recomendation for the specific cell
        let recomendation = self.spotifyRecomendations[indexPath.row]
        
        cell.recomendation = recomendation
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SpotifyViewCell else {return}
        guard let cellTrack = cell.recomendation else {return}
        
        // Check if there is a cell playing music
        if let currentTrack = self.currentPlayingMusic, let currentCell = self.currentPlayingMusicCell {
            
            // If the cell playing music is the cell we selected, then lets pause
            if currentTrack == cellTrack {
                self.stop(streamer: self.musicPlayer)
                
                currentTrack.isPlaying = false
                currentCell.statusLabel.text = ""
                
                self.currentPlayingMusic = nil
                self.currentPlayingMusicCell = nil
                
            // Otherwise, we want to stop the current music, and start playing the next one
            } else {
                self.stopAndThenPlay(music: cellTrack.uri, streamer: self.musicPlayer)
                
                currentCell.statusLabel.text = ""
                currentTrack.isPlaying = false
                
                self.currentPlayingMusicCell = cell
                self.currentPlayingMusic = cell.recomendation
                
                cell.statusLabel.text = Constants.Language.NowPlaying
                cell.recomendation?.isPlaying = true
            }
            
        // No one is playing
        } else {
            self.play(music: cellTrack.uri, streamer: self.musicPlayer)
            
            self.currentPlayingMusic = cellTrack
            self.currentPlayingMusicCell = cell
            
            cell.statusLabel.text = Constants.Language.NowPlaying
            cell.recomendation?.isPlaying = true
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
}
