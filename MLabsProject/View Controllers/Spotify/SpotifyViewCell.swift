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
    
    let titleLabel: UITextView = {
        let lb = UITextView()
        lb.font = .preferredFont(forTextStyle: UIFontTextStyle.title1)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isUserInteractionEnabled = false
        if Constants.DebugView {
            lb.backgroundColor = .green
        } else {
            lb.backgroundColor = .clear
        }
        lb.contentInset = UIEdgeInsetsMake(-7.0, 0, 0, 0)
        lb.textAlignment = .left
        return lb
    }()
    
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
    
    let albumNameLabel: UITextView = {
        let lb = UITextView()
        lb.font = .preferredFont(forTextStyle: .headline)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isUserInteractionEnabled = false
        if Constants.DebugView {
            lb.backgroundColor = .yellow
        } else {
            lb.backgroundColor = .clear
        }
        lb.contentInset = UIEdgeInsetsMake(-7.0, 0, 0, 0)
        lb.textAlignment = .left
        return lb
    }()
    
    let artistNameLabel: UITextView = {
        let lb = UITextView()
        lb.font = .preferredFont(forTextStyle: .headline)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isUserInteractionEnabled = false
        if Constants.DebugView {
            lb.backgroundColor = .red
        } else {
            lb.backgroundColor = .clear
        }
        lb.contentInset = UIEdgeInsetsMake(-7.0, 0, 0, 0)
        lb.textAlignment = .left
        return lb
    }()
    
    let statusLabel: UITextView = {
        let lb = UITextView()
        lb.font = .preferredFont(forTextStyle: .headline)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isUserInteractionEnabled = false
        if Constants.DebugView {
            lb.backgroundColor = .red
        } else {
            lb.backgroundColor = .clear
        }
        lb.contentInset = UIEdgeInsetsMake(-7.0, 0, 0, 0)
        lb.textAlignment = .right
        return lb
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
        addSubview(statusLabel)

        self.setupConstraints()
    }
    
    fileprivate func setupConstraints() {
        albumImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        albumImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        albumImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
        albumImageView.widthAnchor.constraint(equalToConstant: 144).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: albumImageView.topAnchor, constant: 0).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 12).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        albumNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        albumNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 12).isActive = true
        albumNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        albumNameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 8).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: 12).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        statusLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 0).isActive = true
        statusLabel.leftAnchor.constraint(equalTo: albumImageView.rightAnchor, constant: -12).isActive = true
        statusLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -8).isActive = true
        statusLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
    }
    
    /// Do any configuration for the UI necessary each time a new content is used for this cell
    func configure() {
        self.albumImageView.image = self.recomendation!.image
        
        self.titleLabel.text = self.recomendation!.name
        self.albumNameLabel.text = self.recomendation!.albumName
        self.artistNameLabel.text = self.recomendation!.artist.name
        
        if let color = self.recomendation!.imageColor {
            self.backgroundColor = color.background
            self.titleLabel.textColor = color.primary
            self.statusLabel.textColor = color.primary
            self.albumNameLabel.textColor = color.secondary
            self.artistNameLabel.textColor = color.detail
        }

    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
