//
//  AboutViewController.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit

class AboutViewController: UITableViewController {
    
    /// Cell ID to requeue cell
    let CellID = "AboutCellID"

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
        
    }

    /// Set up interface of current view.
    fileprivate func setupView() {
        
        // Change the background to color, otherwise its clear
        self.view.backgroundColor = .white
        
        // view title
        self.navigationItem.title = Constants.Language.About
        
        // Prepare Table View
        self.tableView.delegate = self
        self.tableView.allowsSelection = true
        self.tableView.allowsMultipleSelection = false
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: self.CellID)
        self.tableView.separatorStyle = .singleLineEtched
        
        // We currently support iOS 10, and largeTitle is not available there
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    /// MARK: Table View
    /// =====================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue cell for maximum performance
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CellID, for: indexPath)
        
        cell.textLabel?.text = "oiee"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else {return}

    }
    
}
