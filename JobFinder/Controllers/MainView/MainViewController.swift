//
//  MainViewController.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainViewPresenter(JobService())
        presenter.attatchView(self)
        presenter.getGitHubJobs(description: "String", location: "String")
    }
    


}
extension MainViewController: MainViewDelegate {
    func setFailed(error: Error?) {
        
    }
    
    func setSucceeded() {
        
    }
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    
}
