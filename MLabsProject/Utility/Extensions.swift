//
//  Extensions.swift
//  MLabsProject
//
//  Created by Gustavo Diel on 22/05/18.
//  Copyright © 2018 Gustavo Diel. All rights reserved.
//

import UIKit

/// Just some convenience :v
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat){
        self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: 1)
    }
}

extension UIImageView {
    
    /// Loads a image from a URL and then executes the callback when it's done
    /// - parameter fromURLString: the URL of the image
    /// - parameter callbacK: function to be called everytime the image is loaded
    func loadImage(fromURLString: String, callback: (() -> ())?){
        
        self.image = nil
        
        //retrieve from cache if there is
        if let cachedImage = Constants.ImageCache.object(forKey: fromURLString as AnyObject) {
            self.image = cachedImage
            if let callback = callback {
                callback()
            }
            return
        }
        
        let url = URL(string: fromURLString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    sendOkAlert(((UIApplication.shared.delegate as! AppDelegate).window?.rootViewController)!, title: "Problem loading image", message: (error?.localizedDescription)!, isCritical: true)
                }
                return
            }
            
            DispatchQueue.main.async {
                if let donwloaded = UIImage(data: data!){
                    Constants.ImageCache.setObject(donwloaded, forKey: fromURLString as AnyObject)
                    self.image = donwloaded
                    if let callback = callback {
                        callback()
                    }
                }
            }
        }.resume()
    }
    
}

extension UIViewController {
    
    /// Displays a spinner to indicate something is loading
    /// - parameter onView: The view the spinner will be displayed
    class func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    /// Remove the spinner
    /// - parameter spinner: the spinner to be removed
    class func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

extension UIImage {
    
    /// Compresses the image to a certain amount of MB (or tries to)
    /// - parameter expectedSizeInMB: the expected size
    func compressTo(_ expectedSizeInMb: Double) -> Data? {
        let sizeInBytes = Int(expectedSizeInMb * 1024 * 1024)
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = UIImageJPEGRepresentation(self, compressingValue) {
                if data.count < sizeInBytes {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        
        if let data = imgData {
            if (data.count < sizeInBytes) {
                return data
            }
        }
        return nil
    }
}
