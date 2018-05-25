//
//  AboutViewController.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit
import SafariServices

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
        self.tableView.separatorStyle = .singleLine
        self.tableView.tableFooterView = UIView()
        
        // We currently support iOS 10, and largeTitle is not available there
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .automatic
        }
    }
    
    /// MARK: Table View
    /// =====================================
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 1
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Dequeue cell for maximum performance
        // Don't use the cell for a certain indexPath, because we want to change the style of the cell
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: self.CellID)
        
        // Changing the style (or, rather, creating the cell with a specific one)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: self.CellID)
            cell.selectionStyle = .none
        }
        
        // For each row of each section, there is a different info
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = Constants.Language.AboutName
                cell.detailTextLabel?.text = "Gustavo Diel"
                break
            case 1:
                cell.textLabel?.text = "Github"
                cell.detailTextLabel?.text = "gustavodiel"
                cell.accessoryType = .disclosureIndicator
                break
            case 2:
                cell.textLabel?.text = "Email"
                cell.detailTextLabel?.text = "gustavodiel@hotmail.com"
                cell.accessoryType = .disclosureIndicator
                break
            case 3:
                cell.textLabel?.text = "LinkedIn"
                cell.accessoryType = .disclosureIndicator
                break
            default:
                break
            }
        case 1:
            cell.textLabel?.text = "Magrathea Labs"
            cell.accessoryType = .disclosureIndicator
            break
        case 2:
            if indexPath.row == 0 {
                cell.textLabel?.text = "Alamofire"
            } else {
                cell.textLabel?.text = "UIImageColors"
            }
            cell.accessoryType = .disclosureIndicator
            cell.detailTextLabel?.text = Constants.Language.AboutOpenGithub
            
            break
        default:
            break
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return Constants.Language.AboutDeveloper
        case 1:
            return Constants.Language.AboutAck
        case 2:
            return Constants.Language.AboutThirdParties
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var strUrl: String!
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return
            case 1:
                strUrl = "https://github.com/gustavodiel"
                break
            case 2:
                sendEmail(to: "gustavodiel@hotmail.com", viewController: self, delegate: self)
                return
            case 3:
                strUrl = "https://linkedin.com/in/gustavodiel"
            default:
                break
            }
        case 1:
            strUrl = "http://www.magrathealabs.com"
            break
        case 2:
            if indexPath.row == 0 {
                strUrl = "https://github.com/Alamofire/Alamofire"
                break
            } else {
                strUrl = "https://github.com/jathu/UIImageColors"
                break
            }
        default:
            break
        }
        
        guard let url = URL(string: strUrl) else {return}
        
        let svc = SFSafariViewController(url: url)
        self.present(svc, animated: true, completion: nil)
    }
    
}
