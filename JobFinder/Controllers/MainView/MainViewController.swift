//
//  MainViewController.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import UIKit
import DropDown
import GooglePlaces

class MainViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    @IBOutlet weak var jobsTableView: UITableView!
    @IBOutlet weak var filterTitleLabel: UILabel!
    
    var presenter: MainViewPresenter!
    var dropDown: DropDown!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        presenter = MainViewPresenter(JobService())
        presenter.attachView(self)
        presenter.getGitHubJobsAPI()
        presenter.getGOVSearchJobsAPI()
        jobsTableView.tableFooterView = UIView()
        jobsTableView.tableHeaderView = searchBar
        
        dropDownConfig()
        
    }
    
    @IBAction func filterTapped(_ sender: UIBarButtonItem) {
        dropDown.show()
    }
    
    fileprivate func dropDownConfig() {
        dropDown = DropDown()
        dropDown.direction = .bottom
        dropDown.dataSource = presenter.returnDropDownFilterDataSource()
        
        dropDown.selectionAction = {[weak self] (index, item) in
            FilterEnum(rawValue: item) == .Location ? self?.configureAndPresentAutoComplete() : self?.presenter.selectFilter(index: index)
            self?.searchBar.text = ""
            self?.presenter.getGitHubJobsAPI()
            self?.presenter.getGOVSearchJobsAPI()
            self?.view.endEditing(true)
        }
        
        dropDown.anchorView = filterButton
        dropDown.bottomOffset = CGPoint(x: 0, y: filterButton.accessibilityFrame.height)
    }
    
    func configureAndPresentAutoComplete() {
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        present(acController, animated: true, completion: nil)
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        jobsTableView.reloadData()
        
        searchBar.endEditing(true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.configureSelectedFilter(searchText: searchBar.text ?? "")
        searchBar.endEditing(true)
    }
}


extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.returnJobsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(JobTableViewCell.self)", for: indexPath) as? JobTableViewCell & Cellable else { return UITableViewCell() }
            cell.configure(presenter.returnJobsData(indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        open(url: presenter.returnJobsData(indexPath).jobDetailsURL ?? "")
    }
    
}

extension MainViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        // Do something with the selected place.
        presenter.setLocation(place.name ?? "")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // Handle the error
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        // Dismiss when the user canceled the action
        dismiss(animated: true, completion: nil)
    }

}

extension MainViewController: MainViewDelegate {
    func setSearchBarPlaceholderForAllFilter() {
        searchBar.placeholder = "Jobs jobs jobs.."
        filterTitleLabel.text = "All"
    }
    
    func setSucceeded() {
        jobsTableView.reloadData()
    }
    
    func startLoading() {
        self.view.showLoader()
    }
    
    func finishLoading() {
       self.view.dismissLoader()
    }
    
    func setFailed(error: Error?) {
        //handle failed and errors
    }
    
    func setSearchBarPlaceholderForPositionFilter() {
        searchBar.placeholder = "search for a position"
        filterTitleLabel.text = "Position"

    }
    
    func setSearchBarPlaceholderForLocationFilter() {
        searchBar.placeholder = "location.."
        filterTitleLabel.text = "location"
    }
    
    func setSearchBarPlaceholderForProviderFilter() {
        searchBar.placeholder = "GitHub, GOVSearch"
        filterTitleLabel.text = "provider"

    }
  
}
