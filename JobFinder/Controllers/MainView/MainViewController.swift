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
    @IBOutlet weak var jobsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainViewPresenter(JobService())
        presenter.attatchView(self)
        presenter.getGitHubJobs(description: "java", location: "New york")
        jobsTableView.tableFooterView = UIView()

    }
    
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getGitHubJobsData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(JobTableViewCell.self)", for: indexPath) as? JobTableViewCell else { return UITableViewCell() }
            cell.jobTitleLabel.text = presenter.getGitHubJobsData()[indexPath.row].jobTitle
            cell.companyNameLabel.text = presenter.getGitHubJobsData()[indexPath.row].companyName
            cell.companyLocationLabel.text = presenter.getGitHubJobsData()[indexPath.row].location
            cell.postDateLabel.text = presenter.getGitHubJobsData()[indexPath.row].postDate?.string(format: "dd/MM/yyyy")
            cell.companyImageView.setImage(imageUrl: presenter.getGitHubJobsData()[indexPath.row].companyLogo ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        open(url: presenter.getGitHubJobsData()[indexPath.row].jobDetailsURL ?? "")
    }
    
    
}


extension MainViewController: MainViewDelegate {
    func setFailed(error: Error?) {
        
    }
    
    func setSucceeded() {
        jobsTableView.reloadData()
    }
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    
}
