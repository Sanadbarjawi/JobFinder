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
        presenter.getGitHubJobs()
        jobsTableView.tableFooterView = UIView()
//        jobsTableView.tableHeaderView = searchBar
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        presenter.configureSearchBarScope(scopeIndex: selectedScope)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
                presenter.searchActive = true
                self.presenter.filterGitHubJobsData(searchText: searchText, key: presenter.getSelectedScope())
                jobsTableView.reloadData()

    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchActive = false
        searchBar.endEditing(true)
        jobsTableView.reloadData()

    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
                presenter.searchActive = false
                searchBar.endEditing(true)
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
