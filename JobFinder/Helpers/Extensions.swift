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
    func string(format: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "E MMM d HH:mm:ss Z yy"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        var strDate = ""
        if let date = dateFormatterGet.date(from: self) {
            print(dateFormatterPrint.string(from: date))
            strDate = dateFormatterPrint.string(from: date)
        } else {
            print("There was an error decoding the string")
        }
        return strDate
        
    }
}



extension UIImageView {
    
    func setImage(imageUrl : String) {
        
        if URL(string: imageUrl) != nil && imageUrl.count > 0 {
            let resource = ImageResource(downloadURL: URL(string: imageUrl)!, cacheKey: imageUrl)
            self.contentMode = .scaleAspectFit
            self.kf.setImage(with: resource, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        }
        else{
            self.image = UIImage(named : "astronaut_ic.png")
        }
    }
}
