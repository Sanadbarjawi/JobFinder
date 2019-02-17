//
//  MainViewPresenter.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation

enum FilterEnum: String {
    case Position
    case Location
    case Provider
    case All
}

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

class MainViewPresenter {
    private var jobsArray = [JobsModel]()
    
    private var dropDownData = [FilterEnum.All, FilterEnum.Location, FilterEnum.Provider, FilterEnum.Position]
    private var selectedFilter = FilterEnum.All
    weak var view: MainViewDelegate?
    var service: JobService?
    private var location = ""
    
    init(_ service: JobService) {
        
        self.service = service
    }
    
    func attatchView(_ view: MainViewDelegate) {
        self.view = view
    }
    
    func detachView() {
        self.view = nil
    }

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
    
    func filterOnProvider(_ provider: String) {
       
        let matchingTerms = jobsArray.filter({
            $0.jobDetailsURL?.range(of: provider, options: .caseInsensitive) != nil
        })
        jobsArray = matchingTerms
        self.view?.setSucceeded()
    }

    func returnDropDownFilterDataSource() -> [FilterEnum.RawValue] {
        return dropDownData.map{$0.rawValue}
    }
    
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
    
    func setLocation(_ location: String) {
        self.location = location
    }
    
    func returnSelectedFilter() -> FilterEnum  {
        return selectedFilter
    }
    
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
    
    func returnJobsData(_ indexPath: IndexPath) -> JobsModel {
        
        return jobsArray[indexPath.row]
    }
    func returnJobsCount() -> Int {
        
        return jobsArray.count
    }
}
