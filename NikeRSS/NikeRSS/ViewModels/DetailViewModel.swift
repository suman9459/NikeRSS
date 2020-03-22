//
//  DetailViewModel.swift
//  NikeRSS
//
//  Created by sai suman Pothedar on 3/22/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit

class DetailViewModel: NSObject {
    var delegate: DetaiVCProtocol?
    
    // download Image
    func downloadImage(url: String) {
        NetWorkManager.shared().downloadImage(imageUrl: url) { (image) in
            self.delegate?.getImage(image: image)
        }
    }
}
