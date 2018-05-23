//
//  Utilities.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit

func sendOkAlert(_ view: UIViewController, title: String, message: String, isCritical: Bool = false){
    let ok = UIAlertAction(title: "OK", style: isCritical ? .destructive : .default, handler: nil)
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(ok)
    view.present(alert, animated: true)
}
