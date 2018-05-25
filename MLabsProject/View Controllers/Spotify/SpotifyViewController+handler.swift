//
//  SpotifyViewController+handler.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit
import Alamofire

/*!
    Extension for the SpotifyViewController to handle all buttons, notifications and any other method's callback.
    Also implements some delegates, used for Spotify's Audio Stream.
 */
extension SpotifyViewController {
    
    /// Handles the left bar button.
    /// Can be Login or Logout.
    /// When it is Login, then it will open a webpage inside the app so that the user may log in.
    /// If its Logout, it will clear anything user related.
    @objc func handleLeftBarButtonItem() {
        if navigationItem.leftBarButtonItem!.title == Constants.Language.Login {
            if UIApplication.shared.canOpenURL(self.loginUrl!){
                UIApplication.shared.open(self.loginUrl!, options: [:], completionHandler: nil)
            }
        } else {
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: Constants.SpotifyUserDefaultsSessionCode)
            navigationItem.leftBarButtonItem?.title = Constants.Language.Login
            self.navigationItem.title = "Spotify"
            self.artists.removeAll()
            self.spotifyRecomendations.removeAll()
            self.tableView.reloadData()
            
            // Remove the Please login to your spotify text
            self.tableFooterTextView.isHidden = false
            self.tableFooterView.frame = CGRect(x: 0, y: 0, width: self.tableFooterView.frame.width, height: 256)
            
            // If there is a music playing, STOP IT
            self.stop(streamer: self.musicPlayer)
        }
    }
    
    /// Handles the notification everytime a user enters the app logged in
    @objc func updateAfterFirstLogin() {

        self.checkForUserSession()
        if !initializeMusicPlayer(authSession: session) {
            print("Failed to initialize Spotify Music Player")
        }
    }
    
}
