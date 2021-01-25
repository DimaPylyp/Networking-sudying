//
//  ImageParameters.swift
//  Networking sudying
//
//  Created by DIMa on 25.01.2021.
//  Copyright © 2021 DIMa. All rights reserved.
//

import UIKit

struct ImageParameters {
    let key: String
    let data: Data
    
    init?(image: UIImage, for key: String) {
        self.key = key
        guard let data = image.pngData() else { return nil}
        self.data = data
    }
}
