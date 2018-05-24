//
//  MainTabBarViewController.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    /// Temporary variable to store the TabViewController view controllers
    var controllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate to self, so that we can override all the tab bar functionality
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.viewControllers?.count != 2 {
            self.viewControllers?.removeAll()
            self.controllers.removeAll()
            self.createSpotifyViewController()
            self.createAbooutViewController()
        }
        
        self.viewControllers = self.controllers
    }
    
    /// Generates all requirements to create and instantiate the Spotify view in our Tab Bar
    /// Make fileprivate so that only self can access it
    fileprivate func createSpotifyViewController() {

        let spotifyViewController = SpotifyViewController()
        
        // Embed the spotify view controller on a Navigation view controller.
        // We do this so that we can access features like title and the all powerfull navigation bar
        let spotifyNavigationViewController = UINavigationController(rootViewController: spotifyViewController)
        
        // If we need the reference of the navigation controller on spotify's view
        spotifyViewController.customTabViewController = self
        
        // Currently supporting iOS 10 and up. iOS 10 does not support large titles
        if #available(iOS 11.0, *) {
            spotifyNavigationViewController.navigationBar.prefersLargeTitles = true
        }
        
        // Creates the icon shown on the bottom of the tab bar view.
        // Also set a image and a title for it
        let spotifyIcon = UITabBarItem(title: "Spotify", image: Constants.SpotifyIconImage, tag: 1)
        spotifyNavigationViewController.tabBarItem = spotifyIcon
        
        // 
        self.controllers.append(spotifyNavigationViewController)
    }
    
    /// Generates all requirements to create and instantiate the about view in our Tab Bar
    /// Make fileprivate so that only self can access it
    fileprivate func createAbooutViewController() {
        
        let aboutViewController = AboutViewController()
        
        // Embed the spotify view controller on a Navigation view controller.
        // We do this so that we can access features like title and the all powerfull navigation bar
        let aboutNavigationViewController = UINavigationController(rootViewController: aboutViewController)
        
        // Currently supporting iOS 10 and up. iOS 10 does not support large titles
        if #available(iOS 11.0, *) {
            aboutNavigationViewController.navigationBar.prefersLargeTitles = true
        }
        
        // Creates the icon shown on the bottom of the tab bar view.
        // Also set a image and a title for it
        let aboutTabBarIcon = UITabBarItem(title: Constants.Language.About, image: Constants.AboutIconImage, tag: 2)
        aboutNavigationViewController.tabBarItem = aboutTabBarIcon
        
        self.controllers.append(aboutNavigationViewController)
    }

}
