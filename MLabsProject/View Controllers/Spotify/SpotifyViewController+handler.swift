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
extension SpotifyViewController : SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {
    
    /// Handles the right navigation button
    @objc func handleRightBarButtonItem() {
        self.getTopArtist()
    }
    
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
