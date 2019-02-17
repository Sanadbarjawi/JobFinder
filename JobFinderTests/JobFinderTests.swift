//
//  JobFinderTests.swift
//  JobFinderTests
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import XCTest
@testable import JobFinder

class JobFinderTests: XCTestCase {

    func testGitHubServiceWithNilParameters() {
        let presenter = MainViewPresenter(JobService())
        presenter.attachView(self)
        presenter.getGitHubJobsAPI(location: nil, description: nil)
    }
    
    func testGOVSearchServiceWithNilParameters() {
        let presenter = MainViewPresenter(JobService())
        presenter.attachView(self)
        presenter.getGOVSearchJobsAPI(Desc: nil, location: nil)
    }
    
    func testGOVSearchServiceWithMockParameters() {
        let presenter = MainViewPresenter(JobService())
        presenter.attachView(self)
        presenter.getGOVSearchJobsAPI(Desc: "Nurse", location: "new york")
    }
    
    func testGitHubServiceWithMockParameters() {
        let presenter = MainViewPresenter(JobService())
        presenter.attachView(self)
        presenter.getGitHubJobsAPI(location: "Android developer", description: "")
    }
}

extension JobFinderTests: MainViewDelegate {
    func setSearchBarPlaceholderForPositionFilter() {
        
    }
    
    func setSearchBarPlaceholderForLocationFilter() {
        
    }
    
    func setSearchBarPlaceholderForProviderFilter() {
        
    }
    
    func setSearchBarPlaceholderForAllFilter() {
        
    }
    
    func setSucceeded() {
          XCTAssert(true)
    }
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func setFailed(error: Error?) {
        XCTAssert(false)
    }
    
}
