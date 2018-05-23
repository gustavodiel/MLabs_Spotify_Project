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
    var recomendation = [SpotifyTrack]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
        self.setupSpotify()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAfterFirstLogin), name: NSNotification.Name(rawValue: Constants.OnUserLoggedInNotificationID), object: nil)
        
        self.checkForUserSession()
        
    }

    /// Set up Spotify's Authorization variables with our own provided on their app registration website
    func setupSpotify() {
        SPTAuth.defaultInstance().clientID = Constants.ClientID
        SPTAuth.defaultInstance().redirectURL = URL(string: Constants.ReturnURI)
        // Yeah, Spotify's API is not updated :v
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthUserFollowReadScope, "user-top-read", SPTAuthStreamingScope, SPTAuthUserLibraryReadScope, SPTAuthPlaylistReadPrivateScope, SPTAuthUserReadEmailScope, SPTAuthUserReadPrivateScope]
        
        self.loginUrl = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()
        
    }
    
    /// Check if user is logged in and do whatever it is needed to
    func checkForUserSession() {
        guard let session = self.getUserSession() else { return }
        
        self.navigationItem.leftBarButtonItem?.title = Constants.Language.Logout
        self.navigationItem.title = String(format: Constants.Language.TitleRecomendation, session.canonicalUsername.uppercased())
    }
    
    /// Returns the current Spotify's session for logged user. `nil` if there is none.
    /// - Returns: current SPTSession if any. `nil` if the user is not logged in Spotify.
    func getUserSession() -> SPTSession? {
        
        // If we have a session, check if it's valid. If so, return it. Else just get a new one
        if let session = self.session {
            if session.isValid() {
                return session
            }
            // Dont return. Let it run
            self.session = nil
        }
        
        // Get a new session
        let userDefaults = UserDefaults.standard
        if let sessionObj:AnyObject = userDefaults.object(forKey: Constants.SpotifyUserDefaultsSessionCode) as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = firstTimeSession
            do {
                let request = try SPTUser.createRequestForCurrentUser(withAccessToken: self.session.accessToken)
                let task = URLSession.shared.dataTask(with: request) {data, response, error in
                    guard let data = data, error == nil else {
                        return
                    }
                    do {
                        self.user = try SPTUser(from: data, with: response)
                    } catch {
                        print("ERROR: Can't create user with current data and request: \(error.localizedDescription)")
                    }
                }
                
                task.resume()
            } catch {
                print("ERROR: Can't create request for user: \(error.localizedDescription)")
            }
            if self.session.isValid() {
                return self.session
            }
        }
        return nil
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
        
        
        // Create a left bar item, to login/logoff the user
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: Constants.Language.Login, style: .plain, target: self, action: #selector(handleLeftBarButtonItem))
        
        // Create a left bar item, to login/logoff the user
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Test", style: .plain, target: self, action: #selector(handleRightBarButtonItem))
        
        // We currently support iOS 10, and largeTitle is not available there
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    
    /// MARK: Table View
    /// =====================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recomendation.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue cell for maximum performance
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID, for: indexPath) as! SpotifyViewCell
        
        // Get the recomendation for the specific cell
        let recommendation = self.recomendation[indexPath.row]
        
        cell.albumImageView.loadImage(fromURLString: recommendation.imageURL)
        
        cell.titleLabel.text = recommendation.name
        cell.albumNameLabel.text = recommendation.albumName
        cell.artistNameLabel.text = recommendation.artist.name
        
        cell.configure()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SpotifyViewCell else {return}
        print(cell.titleLabel.text)
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
}
