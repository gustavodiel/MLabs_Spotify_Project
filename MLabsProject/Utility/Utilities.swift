//
//  Utilities.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit
import MessageUI

/// Send a small pop up message.
/// - parameter view: The view controller the pop up should appear
/// - parameter title: The title of the pop up
/// - parameter message: The message body of the pop up
/// - parameter isCritical: Wheter the message is critical (i.e error) or not
func sendOkAlert(_ view: UIViewController, title: String, message: String, isCritical: Bool = false){
    let ok = UIAlertAction(title: "OK", style: isCritical ? .destructive : .default, handler: nil)
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(ok)
    view.present(alert, animated: true)
}

/// Send email to someone
/// - parameter to: one's email address
/// - parameter viewController: The view controller that will hold the email message pop up
/// - parameter delegate: the object that holds the MailCompose delegate
func sendEmail(to: String, viewController: UIViewController, delegate: MFMailComposeViewControllerDelegate) {
    if MFMailComposeViewController.canSendMail() {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = delegate
        mail.setToRecipients([to])
        
        viewController.present(mail, animated: true)
    }
}
