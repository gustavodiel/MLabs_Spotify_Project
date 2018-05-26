//
//  SpotifyViewCell.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit
import UIImageColors

class SpotifyViewCell: UITableViewCell {
    
    /// Track's title
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.minimumScaleFactor = 0.5
        lb.font = .preferredFont(forTextStyle: UIFontTextStyle.title1)
        lb.translatesAutoresizingMaskIntoConstraints = false
        if Constants.DebugView {
            lb.backgroundColor = .green
        } else {
            lb.backgroundColor = .clear
        }
        lb.textAlignment = .left
        return lb
    }()
    
    /// Track's album
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 0
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        if Constants.DebugView {
            imageView.backgroundColor = .blue
        }
        return imageView
    }()
    
    /// Track's album name
    let albumNameLabel: UILabel = {
        let lb = UILabel()
        lb.minimumScaleFactor = 0.5
        lb.font = .preferredFont(forTextStyle: .headline)
        lb.translatesAutoresizingMaskIntoConstraints = false
        if Constants.DebugView {
            lb.backgroundColor = .yellow
        } else {
            lb.backgroundColor = .clear
        }
        lb.textAlignment = .left
        return lb
    }()
    
    /// Track's artist name
    let artistNameLabel: UILabel = {
        let lb = UILabel()
        lb.minimumScaleFactor = 0.6
        lb.font = .preferredFont(forTextStyle: .headline)
        lb.translatesAutoresizingMaskIntoConstraints = false
        if Constants.DebugView {
            lb.backgroundColor = .red
        } else {
            lb.backgroundColor = .clear
        }
        lb.textAlignment = .left
        return lb
    }()
    
    /// Whether is playing or not
    let statusImageView: UIImageView = {
        let lb = UIImageView()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isUserInteractionEnabled = false
        if Constants.DebugView {
            lb.backgroundColor = .red
        } else {
            lb.backgroundColor = .clear
        }
        lb.image = Constants.PlayingIconImage!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        lb.contentMode = .scaleAspectFit
        return lb
    }()
    
    let openOnSpotifyButton: UIButton = {
        let bt = UIButton(type: .system)
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.setTitle("Open on Spotify", for: .normal)
        return bt
    }()
    
    
    var recomendation: SpotifyTrack? {
        didSet {
            self.configure()
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        if Constants.DebugView {
            self.backgroundColor = .black
        }
        
        addSubview(albumImageView)
        addSubview(titleLabel)
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
        addSubview(statusImageView)
        addSubview(openOnSpotifyButton)

        self.setupConstraints()
        
        openOnSpotifyButton.addTarget(self, action: #selector(self.handleOpenOnSpotifyButtonInsidePress), for: .touchUpInside)
    }
    
    fileprivate func setupConstraints() {
        
        // LEFT
        albumImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        albumImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        albumImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 6).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: 144).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: albumImageView.topAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 6).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -38).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        albumNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        albumNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 6).isActive = true
        albumNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        albumNameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 4).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 6).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        
        // RIGHT
        
        statusImageView.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0).isActive = true
        statusImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -6).isActive = true
        statusImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        statusImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        
        openOnSpotifyButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        openOnSpotifyButton.rightAnchor.constraint(equalTo: statusImageView.rightAnchor, constant: 0).isActive = true
        openOnSpotifyButton.widthAnchor.constraint(equalToConstant: 144).isActive = true
        openOnSpotifyButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    /// Do any configuration for the UI necessary each time a new content is used for this cell
    func configure() {
        self.albumImageView.image = self.recomendation!.image
        
        // Set the text and make it adjust its size to the frame's size
        self.titleLabel.text = self.recomendation!.name
        self.titleLabel.font = .preferredFont(forTextStyle: UIFontTextStyle.title1)
        self.titleLabel.adjustsFontSizeToFitWidth = true
        
        // Set the text and make it adjust its size to the frame's size
        self.albumNameLabel.text = self.recomendation!.albumName
        self.albumNameLabel.font = .preferredFont(forTextStyle: UIFontTextStyle.headline)
        self.albumNameLabel.adjustsFontSizeToFitWidth = true
        
        // Set the text and make it adjust its size to the frame's size
        self.artistNameLabel.text = self.recomendation!.artist.name
        self.artistNameLabel.font = .preferredFont(forTextStyle: UIFontTextStyle.headline)
        self.artistNameLabel.adjustsFontSizeToFitWidth = true
        
        self.statusImageView.isHidden = !self.recomendation!.isPlaying
        
        if let color = self.recomendation!.imageColor {
            self.backgroundColor = color.background
            self.titleLabel.textColor = color.primary
            self.statusImageView.tintColor = color.primary
            self.albumNameLabel.textColor = color.secondary
            self.artistNameLabel.textColor = color.detail
            self.openOnSpotifyButton.tintColor = color.detail
        }

    }

    @objc func handleOpenOnSpotifyButtonInsidePress() {
        self.recomendation!.openOnSpotify()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
