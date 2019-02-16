//
//  MainViewPresenter.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation

enum FilterEnum: Int {
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
//    private var govSearchJobs = [GOVSearchModel]()

//    var searchActive: Bool = false
//
//    private var gitHubFilteredJobs = [GitHubJobModel]()
//    private var govSearchFilteredJobs = [GOVSearchModel]()

    
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
    
    func getGitHubJobsAPI() {
        
        let params = ["":""]
        view?.startGitHubServiceLoading()
        service?.getGitHubJobs(params: params, success: {[weak self] model in
            model.forEach{self?.gitHubJobs.append($0)}
            self?.view?.setGitHubServiceSucceeded()
            self?.view?.finishGitHubServiceLoading()
            }, failure: {[weak self] error in
                self?.view?.setGitHubServiceFailed(error: error)
                self?.view?.finishGitHubServiceLoading()
            }
        )}
    
    func getGOVSearchJobsAPI() {
        
        let params = ["":""]
        view?.startGOVSearchServiceLoading()
        service?.getGOVSearchJobs(params: params, success: { [weak self] model in
            model.forEach{self?.gitHubJobs.append($0)}
            self?.view?.setGitHubServiceSucceeded()
            self?.view?.finishGOVSearchServiceLoading()
            }, failure: {[weak self] error in
                self?.view?.setGOVSearchServiceFailed(error: error)
                self?.view?.finishGOVSearchServiceLoading()
            }
        )}
    
    func returnGitHubJobsData() -> [JobsModel] {
//        if searchActive {
//            return gitHubFilteredJobs
//        }
        return gitHubJobs
    }
    
//    func returnGOVSearchJobsData() -> [GOVSearchModel] {
//        if searchActive {
//            return govSearchFilteredJobs
//        }
//        return govSearchJobs
//    }
//
//    func filterGitHubJobsData(searchText: String) {
//        gitHubFilteredJobs = gitHubJobs.filter({ (text) -> Bool in
//
//                 let tmp: NSString = text.jobTitle as NSString? ?? ""
//
//
//            let range = tmp.range(of: searchText, options: .caseInsensitive)
//            return range.location != NSNotFound
//        })
//
//        if gitHubFilteredJobs.count == 0 {
//            searchActive = false
//        } else {
//            searchActive = true
//        }
//    }
    
//    func filterGOVSearchJobsData(searchText: String) {
//        govSearchFilteredJobs = govSearchJobs.filter({ (text) -> Bool in
//
//                let tmp: NSString = text.positionTitle as NSString? ?? ""
//
//            let range = tmp.range(of: searchText, options: .caseInsensitive)
//            return range.location != NSNotFound
//        })
//
//        if govSearchFilteredJobs.count == 0 {
//            searchActive = false
//        } else {
//            searchActive = true
//        }
//    }


}
