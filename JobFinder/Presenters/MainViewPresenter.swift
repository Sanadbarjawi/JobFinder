//
//  MainViewPresenter.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation

enum FilterEnum: String {
    case position
    case location
    case provider
}

protocol MainViewDelegate: class {
    func setGitHubServiceSucceeded()
    func startGitHubServiceLoading()
    func finishGitHubServiceLoading()
    func setGitHubServiceFailed(error: Error?)
    
    func setGOVSearchServiceSucceeded()
    func startGOVSearchServiceLoading()
    func finishGOVSearchServiceLoading()
    func setGOVSearchServiceFailed(error: Error?)
    
}

class MainViewPresenter {
    
    private var gitHubJobs = [JobsModel]()
    private var dropDownData = [FilterEnum.location, FilterEnum.provider, FilterEnum.position]
    private var selectedFilter = FilterEnum.position
    weak var view: MainViewDelegate?
    var service: JobService?
   
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
        
        let params = ["":""]
        let queryLocationItem = URLQueryItem(name: "location", value: location)
        let queryPositionItem = URLQueryItem(name: "description", value: description)

        view?.startGitHubServiceLoading()
        service?.getGitHubJobs(params: params, queryItems: [queryLocationItem, queryPositionItem], success: {[weak self] model in
            model.forEach{self?.gitHubJobs.append($0)}
            self?.view?.setGitHubServiceSucceeded()
            self?.view?.finishGitHubServiceLoading()
            }, failure: {[weak self] error in
                self?.view?.setGitHubServiceFailed(error: error)
                self?.view?.finishGitHubServiceLoading()
            }
        )}
    
    func getGOVSearchJobsAPI(searchQuery: String? = nil) {
        
        let params = ["":""]
        let queryItem = URLQueryItem(name: "query", value: searchQuery)
        view?.startGOVSearchServiceLoading()
        service?.getGOVSearchJobs(params: params, queryItems: [queryItem], success: { [weak self] model in
            model.forEach{self?.gitHubJobs.append($0)}
            self?.view?.setGitHubServiceSucceeded()
            self?.view?.finishGOVSearchServiceLoading()
            }, failure: {[weak self] error in
                self?.view?.setGOVSearchServiceFailed(error: error)
                self?.view?.finishGOVSearchServiceLoading()
            }
        )}
    
    func resetSearch() {
        gitHubJobs.removeAll()
    }
    
    func returnDropDownFilterDataSource() -> [FilterEnum.RawValue] {
        return dropDownData.map{$0.rawValue}
    }

    func selectFilter(index: Int) {
       selectedFilter = dropDownData[index]
    }
    
    func returnSelectedFilter() -> FilterEnum  {
        return selectedFilter
    }
    
    func returnGitHubJobsData() -> [JobsModel] {

        return gitHubJobs
    }
    
}
