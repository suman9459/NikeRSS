//
//  ViewController.swift
//  NikeRSS
//
//  Created by sai suman Pothedar on 3/22/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerProtocol {
    func getdata(feed: FeedModel)
}

class ViewController: UITableViewController {
    
    let tableviewCellIdentifier = "albumcell"
    var feedDataModel: FeedModel?
    let viewModel = ViewControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.getMusicsList(url: Constants.baseUrl)
        registerTableViewCell()
    }
    
    // register for TableviewCell
    private func registerTableViewCell() {
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: tableviewCellIdentifier)
    }

}
extension ViewController: ViewControllerProtocol {
    
    // getting responce from viewmodel
    func getdata(feed: FeedModel) {
        self.feedDataModel = feed
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
       
    }
}
extension ViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = feedDataModel?.feed?.results?.count {
            return count
        }
        return 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableviewCellIdentifier, for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        if let result = feedDataModel?.feed?.results?[indexPath.row] {
            cell.updateData(result: result)
        }
        return cell
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailVC = DetailsViewController()
        detailVC.result = feedDataModel?.feed?.results?[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    
    }
    
    
}
