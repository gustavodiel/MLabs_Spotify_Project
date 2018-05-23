//
//  Constants.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

struct Constants {
    
    /// Best embrumation to debug view
    static let DebugView = false
    
    /// Spotify's Client ID
    static let ClientID = "d8e56c2b42a14214a4f12a9fe4d99875"
    
    /// The URI Spotify's server will call after the user links the account on our app
    static let ReturnURI = "MLabsProject://loginCallback"
    
    /// User Default key that stores our current session, so that we can close and open the app and the session still opened
    static let SpotifyUserDefaultsSessionCode = "SpotifySession"
    
    /// Key to store the notification internally whenever the user logs in
    static let OnUserLoggedInNotificationID = "userDidSpotifyLogin"
    
    /// Current UserDefault key
    static let SessionUserDefaultsKey = "com.gustavo.spotify.userDefaultKey"
    
    static let SpotifyRecomendetionsURI = "https://api.spotify.com/v1/recommendations"
    static let SpotifyTopArtistURI = "https://api.spotify.com/v1/me/top/artists"
    static let SpotifyFeaturedPlaylistsURI = "https://api.spotify.com/v1/browse/featured-playlists"
    static let SpotifyNewReleasesURI = "https://api.spotify.com/v1//browse/new-releases"
    
    /// Spotify's icon for Tab Bar
    static let SpotifyIconImage = UIImage(named: "spotify")
    
    /// About icon for Tab Bar
    static let AboutIconImage = UIImage(named: "about")
    
    /// Protocol that holds the localization for our app
    static let Language: Language = Portugues()
    
}

/// Here we declare localization text for the string in the app.
/// This is not the right way to do it, but imho it's the most visual pleasing
protocol Language {
    var Logout: String {get}
    var Login: String {get}
    
    var About: String {get}
    
    var TitleRecomendation: String {get}
    
    var NeedToLoginToSpotifyTitle: String {get}
    var NeedToLoginToSpotifyMessage: String {get}
}

struct English : Language {
    var Logout: String = "Logout"
    var Login: String = "Login"
    
    var About: String = "Logout"
    
    var TitleRecomendation: String = "%@'s recomendations"
    
    var NeedToLoginToSpotifyTitle: String = "Login required"
    var NeedToLoginToSpotifyMessage: String = "Please login to your Spotify account using the button at the side"
}

struct Portugues : Language {
    var Logout: String = "Sair"
    var Login: String = "Entrar"
    
    var About: String = "Sobre"
    
    var TitleRecomendation: String = "Recomendações de %@"
    
    var NeedToLoginToSpotifyTitle: String = "Login Necessário"
    var NeedToLoginToSpotifyMessage: String = "Por favor faça login à sua conta do Spotify utilizando o botão ao lado"
}

