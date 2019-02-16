//
//  DateExtensions.swift
//  JobFinder
//
//  Created by Sanad  on 2/16/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension String {
    func string(toFormat: String, fromFormat: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = fromFormat
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = toFormat
        var strDate = ""
        if let date = dateFormatterGet.date(from: self) {
            strDate = dateFormatterPrint.string(from: date)
        } 
        return strDate
        
    }
}

extension UIView {
    /**
     ShowLoader:  loading view ..
     
     - parameter Color:  ActivityIndicator and view loading color .
     
     */
    func showLoader(_ color: UIColor? = UIColor.black.withAlphaComponent(0.5)) {
        let loaderView  = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        loaderView.tag = -3 + self.tag
        loaderView.backgroundColor = color
        let loader = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        loader.center = loaderView.center
        loader.color = UIColor.darkGray
        loader.startAnimating()
        loaderView.addSubview(loader)
        // Disable all action
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.addSubview(loaderView)
    }
    
    /**
     dismissLoader:  hidden loading view  ..
     */
    func dismissLoader() {
        // enable all action
        self.viewWithTag(-3 + self.tag)?.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
        
    }
    
}

extension UIImageView {
    
    func setImage(imageUrl : String) {
        
        if URL(string: imageUrl) != nil && imageUrl.count > 0 {
            let resource = ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl)
            self.contentMode = .scaleAspectFit
//            self.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            self.kf.setImage(with: resource)
        }
        else{
            self.image = UIImage(named : "astronaut_ic.png")
        }
    }
}
