//
//  DetailsViewController.swift
//  NikeRSS
//
//  Created by sai suman Pothedar on 3/22/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit
protocol DetaiVCProtocol {
    func getImage(image: UIImage)
}
class DetailsViewController: UIViewController {
    
    var tableView: UITableView = {
        let tablveiw = UITableView()
        tablveiw.translatesAutoresizingMaskIntoConstraints = false
        return tablveiw
    }()
    
    var copyrightLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var releaseDate: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var thumImageView: UIImageView =  {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var itunesBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Itunes Store", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var result: results?
    var viewModel = DetailViewModel()
    let tableviewCellIdentifier = "GenresCell"
    var container:UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        addSubviews()
        registerTablview()
        updateUI()
        itunesBtn.addTarget(self, action: #selector(itunesBtnAction(_:)), for: .touchUpInside)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.delegate = self
        tableView.dataSource = self
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    private func addSubviews(){
        
        container = UIView(frame: view.frame)
        container?.backgroundColor = UIColor.white
        if let contentView = container {
            self.view.addSubview(contentView)
            
            contentView.addSubview(thumImageView)
            contentView.addSubview(releaseDate)
            contentView.addSubview(copyrightLabel)
            contentView.addSubview(tableView)
            contentView.addSubview(itunesBtn)
            updateConstainst(containerView: contentView)
            
        }
        
    }
    private func updateConstainst(containerView: UIView) {
        containerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        
        
        thumImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100).isActive = true
        thumImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: thumImageView.trailingAnchor, constant: 20).isActive = true
        thumImageView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        releaseDate.topAnchor.constraint(equalTo: thumImageView.bottomAnchor, constant: 20).isActive = true
        releaseDate.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        releaseDate.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 20).isActive = true
        releaseDate.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        copyrightLabel.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 20).isActive = true
        copyrightLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: copyrightLabel.trailingAnchor, constant: 20).isActive = true
        copyrightLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        tableView.topAnchor.constraint(equalTo: copyrightLabel.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 20).isActive = true
        
        itunesBtn.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        
        
        containerView.bottomAnchor.constraint(equalTo: itunesBtn.bottomAnchor, constant: 20).isActive = true
        itunesBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20).isActive = true
        containerView.trailingAnchor.constraint(equalTo: itunesBtn.trailingAnchor, constant: 20).isActive = true
        itunesBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
    }
    // register for TableviewCell
    private func registerTablview() {
        tableView.register(GenresCell.self, forCellReuseIdentifier: tableviewCellIdentifier)
    }
    
    // updating  UI fields
    func updateUI() {
        if let detailData = result {
            if let date = detailData.releaseDate {
                releaseDate.text = "Release Date: \(String(describing: date))"
            }
            copyrightLabel.text = detailData.copyright
            if let url = detailData.artworkUrl100 {
                viewModel.downloadImage(url: url)
            }
        }
    }
    
    // navigate to Itunes Store or Web page
    @objc func itunesBtnAction(_ sender: Any) {
        if let webkitUrl = result?.url {
            if let url = URL(string: webkitUrl) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}


extension DetailsViewController: DetaiVCProtocol {
    
    // getting downoaded image from Viewmodel
    func getImage(image: UIImage) {
        DispatchQueue.main.async {
            self.thumImageView.contentMode = .scaleAspectFit
            self.thumImageView.layer.cornerRadius = 6.0
            self.thumImageView.layer.masksToBounds = true
            self.thumImageView.image = image
        }
    }
}
extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = result?.genres?.count {
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: tableviewCellIdentifier, for: indexPath) as? GenresCell else { return UITableViewCell() }
        cell.updateCell(genre: result?.genres?[indexPath.row])
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
