//
//  AboutViewControllerMailDelegate.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 24/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit
import MessageUI

extension AboutViewController : MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
