//
//  MainViewPresenter.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation

protocol MainViewDelegate: class {
    func setSucceeded()
    func startLoading()
    func finishLoading()
    func setFailed(error: Error?)
}

class MainViewPresenter {
    private var gitHubJobs = [GitHubJobModel]()
    private var govSearchJobs = [GitHubJobModel]()
    
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
    func getGitHubJobs(description: String, location: String) {
        
        let params = ["description": description,
                      "location": location]
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
        return gitHubJobs
    }
    
    func getGOVSearchJobs() {
        
    }
    
}
