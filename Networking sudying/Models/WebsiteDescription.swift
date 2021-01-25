//
//  WebsiteDescription.swift
//  Networking sudying
//
//  Created by DIMa on 24.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import Foundation

struct WebsiteDescription: Decodable {
    let websiteDescription: String
    let websiteName: String?
    let courses: [Course]
}
