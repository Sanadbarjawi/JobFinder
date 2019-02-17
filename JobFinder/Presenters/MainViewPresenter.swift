//
//  MainViewPresenter.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation

//enum associated with the filter values
enum FilterEnum: String {
    case Position
    case Location
    case Provider
    case All
}
// protocol to config the view
protocol MainViewDelegate: class {
    func setSucceeded()
    func startLoading()
    func finishLoading()
    func setFailed(error: Error?)
    
    func setSearchBarPlaceholderForPositionFilter()
    func setSearchBarPlaceholderForLocationFilter()
    func setSearchBarPlaceholderForProviderFilter()
    func setSearchBarPlaceholderForAllFilter()
}

// the presenter that handles the mainview's logic
class MainViewPresenter {
    private var jobsArray = [JobsModel]()
    
    private var dropDownData = [FilterEnum.All, FilterEnum.Location, FilterEnum.Provider, FilterEnum.Position]
    private var selectedFilter = FilterEnum.All
    weak var view: MainViewDelegate?
    var service: JobService?
    private var location = ""
    
    //dependency injection to inject the service
    init(_ service: JobService) {
        
        self.service = service
    }
    
    //settings the view as the delegate
    func attachView(_ view: MainViewDelegate) {
        self.view = view
    }
    
    //detaching the delegate
    func detachView() {
        self.view = nil
    }
    
    
    //getting data from provider regarding queries as well
    func getGitHubJobsAPI(location: String? = nil, description: String? = nil) {
        jobsArray.removeAll()
        let params = ["":""]
        let queryLocationItem = URLQueryItem(name: "location", value: location)
        let queryPositionItem = URLQueryItem(name: "description", value: description)
        
        view?.startLoading()
        service?.getGitHubJobs(params: params, queryItems: [queryLocationItem, queryPositionItem], success: {[weak self] model in
            model.forEach{self?.jobsArray.append($0)}
            self?.view?.setSucceeded()
            self?.view?.finishLoading()
            }, failure: {[weak self] error in
                self?.view?.setFailed(error: error)
                self?.view?.finishLoading()
            }
        )}
    
    //getting data from second provider regarding queries as well
    func getGOVSearchJobsAPI(Desc: String? = nil, location: String? = nil) {
        jobsArray.removeAll()
        let params = ["":""]
        let queryLocationItem = URLQueryItem(name: "query", value: Desc)
        let queryDescItem = URLQueryItem(name: "in", value: location)
        
        view?.startLoading()
        service?.getGOVSearchJobs(params: params, queryItems: [queryDescItem, queryLocationItem], success: { [weak self] model in
            model.forEach{self?.jobsArray.append($0)}
            self?.view?.setSucceeded()
            self?.view?.finishLoading()
            }, failure: {[weak self] error in
                self?.view?.setFailed(error: error)
                self?.view?.finishLoading()
            }
        )}
    
    //local filtering on on the provider
    func filterOnProvider(_ provider: String) {
        
        let matchingTerms = jobsArray.filter({
            $0.jobDetailsURL?.range(of: provider, options: .caseInsensitive) != nil
        })
        jobsArray = matchingTerms
        self.view?.setSucceeded()
    }
    
    //returning dropdown list data
    func returnDropDownFilterDataSource() -> [FilterEnum.RawValue] {
        return dropDownData.map{$0.rawValue}
    }
    
    //handle filter selection and its affects on the search bar
    func selectFilter(index: Int) {
        selectedFilter = dropDownData[index]
        switch selectedFilter {
            
        case .Position:
            view?.setSearchBarPlaceholderForPositionFilter()
        case .Location:
            view?.setSearchBarPlaceholderForLocationFilter()
        case .Provider:
            view?.setSearchBarPlaceholderForProviderFilter()
        case .All:
            view?.setSearchBarPlaceholderForAllFilter()
        }
    }
    
    //assigning the location
    func setLocation(_ location: String) {
        self.location = location
    }
    
    //returns the selected filter
    func returnSelectedFilter() -> FilterEnum  {
        return selectedFilter
    }
    
    //handle filter selection and its business logic
    func configureSelectedFilter(searchText: String) {
        switch selectedFilter {
            
        case .Position:
            getGitHubJobsAPI(location: location, description: searchText)
            getGOVSearchJobsAPI(Desc: searchText, location: location)
        case .Location:
            getGitHubJobsAPI(location: location, description: searchText)
            getGOVSearchJobsAPI(Desc: searchText, location: location)
        case .Provider:
            filterOnProvider(searchText)
        case .All:
            getGitHubJobsAPI(location: location, description: searchText)
            getGOVSearchJobsAPI(Desc: searchText, location: location)
        }
    }
    
    //return jobs data
    func returnJobsData(_ indexPath: IndexPath) -> JobsModel {
        
        return jobsArray[indexPath.row]
    }
    
    //return jobs count
    func returnJobsCount() -> Int {
        
        return jobsArray.count
    }
}
