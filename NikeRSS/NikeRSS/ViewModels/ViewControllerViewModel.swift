//
// ViewControllerViewModel.swift
//  NikeRSS
//
//  Created by sai suman Pothedar on 3/22/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerViewModel: NSObject {
    
    var delegate: ViewControllerProtocol?
    
    // get Music List
    func getMusicsList(url: String) {
        NetWorkManager.shared().getData(url: url) { [unowned self] (data) in
            let jsonDecode = JSONDecoder()
            do {
                let feeddata = try jsonDecode.decode(FeedModel.self, from: data)
                self.delegate?.getdata(feed: feeddata)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
    }
}
