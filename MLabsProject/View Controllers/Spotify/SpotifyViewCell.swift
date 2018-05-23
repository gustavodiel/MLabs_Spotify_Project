//
//  SpotifyViewCell.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit

class SpotifyViewCell: UITableViewCell {
    
    let titleLabel: UITextView = {
        let lb = UITextView()
        lb.font = .preferredFont(forTextStyle: UIFontTextStyle.title1)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.isUserInteractionEnabled = false
        if Constants.DebugView {
            lb.backgroundColor = .green
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
        }
        lb.contentInset = UIEdgeInsetsMake(-7.0, 0, 0, 0)
        lb.textAlignment = .left
        return lb
    }()
    
    var row = 0
    
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

        
    }
    
    func configure() {

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
