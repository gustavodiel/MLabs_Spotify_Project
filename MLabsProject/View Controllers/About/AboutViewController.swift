//
//  AboutViewController.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    let aboutText: UITextView = {
        let lb = UITextView()
        lb.font = .preferredFont(forTextStyle: UIFontTextStyle.body)
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.contentInset = UIEdgeInsetsMake(-7.0, 0, 0, 0)
        lb.textAlignment = .left
        return lb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
        self.view.addSubview(self.aboutText)
        
        self.setupConstraints()
    }
    
    /// Set up all the constraints
    fileprivate func setupConstraints() {
        
    }
    
    /// Set up interface of current view.
    fileprivate func setupView() {
        
        // Change the background to color, otherwise its clear
        self.view.backgroundColor = .white
        
        // view title
        self.navigationItem.title = Constants.Language.About
        
        // We currently support iOS 10, and largeTitle is not available there
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
}
