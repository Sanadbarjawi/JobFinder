//
//  Utitities.swift
//  JobFinder
//
//  Created by Sanad  on 2/16/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation
import UIKit

func open(url: String) {
    guard let url = URL(string: url) else { return }
    UIApplication.shared.open(url, options: [:])
}
