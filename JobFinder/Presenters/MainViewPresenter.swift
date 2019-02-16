//
//  MainViewPresenter.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation
enum FilterEnum: Int {
    case provider
    case location
    case position
}
protocol MainViewDelegate: class {
    func setSucceeded()
    func startLoading()
    func finishLoading()
    func setFailed(error: Error?)
}

class MainViewPresenter {
    private var gitHubJobs = [GitHubJobModel]()
    private var govSearchJobs = [GitHubJobModel]()
    
    var searchActive: Bool = false
    var selectedScope: FilterEnum = .position
    
    private var gitHubFilteredJobs = [GitHubJobModel]()
    private var govSearchFilteredJobs = [GitHubJobModel]()

    
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
    // https://jobs.github.com/positions.json?description=python&location=new+york
    func getGitHubJobs() {
        
        let params = ["":""]
        view?.startLoading()
        service?.getGitHubJobs(params: params, success: {[weak self] model in
            self?.gitHubJobs = model
            self?.view?.setSucceeded()
            self?.view?.finishLoading()
            }, failure: {[weak self] error in
                self?.view?.setFailed(error: error)
                self?.view?.finishLoading()
            }
        )}
    
    func getGitHubJobsData() -> [GitHubJobModel] {
        if searchActive {
            return gitHubFilteredJobs
        }
        return gitHubJobs
    }
    
    func filterGitHubJobsData(searchText: String, key: FilterEnum) {
        gitHubFilteredJobs = gitHubJobs.filter({ (text) -> Bool in
           var tmp: NSString = ""
            switch key {
            case .provider:
                break
            case .location:
                break
            case .position:
                tmp = text.jobTitle as NSString? ?? ""
            }
           
            let range = tmp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        
        if gitHubFilteredJobs.count == 0 {
            searchActive = false
        } else {
            searchActive = true
        }
    }
    
    func getGOVSearchJobs() {
        
    }
    
    func configureSearchBarScope(scopeIndex: Int) {
        selectedScope = FilterEnum(rawValue: scopeIndex) ?? .position
    }
    
    func getSelectedScope() -> FilterEnum {
        return selectedScope
    }
    
}
