//
//  MainViewController.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var jobsTableView: UITableView!
    
    var presenter: MainViewPresenter!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainViewPresenter(JobService())
        presenter.attatchView(self)
        presenter.getGitHubJobsAPI()
        presenter.getGOVSearchJobsAPI()
        jobsTableView.tableFooterView = UIView()
        jobsTableView.tableHeaderView = searchBar
        
    }
    
}

extension MainViewController: UISearchBarDelegate {
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//                presenter.searchActive = true
//                self.presenter.filterGitHubJobsData(searchText: searchText)
//                jobsTableView.reloadData()

    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        presenter.searchActive = false
//        searchBar.endEditing(true)
//        jobsTableView.reloadData()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//                presenter.searchActive = false
//                searchBar.endEditing(true)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.returnGitHubJobsData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(JobTableViewCell.self)", for: indexPath) as? JobTableViewCell else { return UITableViewCell() }
        
        cell.jobTitleLabel.text = presenter.returnGitHubJobsData()[indexPath.row].jobTitle
        cell.companyNameLabel.text = presenter.returnGitHubJobsData()[indexPath.row].companyName
        cell.companyLocationLabel.text = presenter.returnGitHubJobsData()[indexPath.row].location?.first
        cell.postDateLabel.text = presenter.returnGitHubJobsData()[indexPath.row].postDate
        cell.companyImageView.setImage(imageUrl: presenter.returnGitHubJobsData()[indexPath.row].companyLogo ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        open(url: presenter.returnGitHubJobsData()[indexPath.row].jobDetailsURL ?? "")
    }
    
}


extension MainViewController: MainViewDelegate {
    func configureSearchBarPlaceholderText(text: String) {
        searchBar.placeholder = text
    }
    
  
    func setGitHubServiceSucceeded() {
        jobsTableView.reloadData()
    }
    
    func startGitHubServiceLoading() {
        
    }
    
    func finishGitHubServiceLoading() {
        
    }
    
    func setGitHubServiceFailed(error: Error?) {
        
    }
    
    func setGOVSearchServiceSucceeded() {
        
    }
    
    func startGOVSearchServiceLoading() {
        
    }
    
    func finishGOVSearchServiceLoading() {
        
    }
    
    func setGOVSearchServiceFailed(error: Error?) {
        
    }
    
    
}
