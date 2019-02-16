//
//  JobTableViewCell.swift
//  JobFinder
//
//  Created by Sanad  on 2/16/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell, Cellable {
    func configure(_ object: Codable) {
        if let jobsModel = object as? JobsModel {
            jobTitleLabel.text = jobsModel.jobTitle
            companyNameLabel.text = jobsModel.companyName
            companyLocationLabel.text = jobsModel.location?.first
            postDateLabel.text = jobsModel.postDate
            companyImageView.setImage(imageUrl: jobsModel.companyLogo ?? "")
        }
    }
    
    
    @IBOutlet weak var companyImageView: UIImageView!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companyLocationLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
