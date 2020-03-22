//
//  AlbumTableViewCell.swift
//  NikeRSS
//
//  Created by sai suman Pothedar on 3/22/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit
class AlbumTableViewCell: UITableViewCell {
    
    var authorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var thumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    var index: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    func setupViews() {
        addSubview(thumImage)
        addSubview(authorName)
        addSubview(name)
        addConstaints()
    }
    
    func addConstaints() {
        
        thumImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        thumImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        thumImage.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        thumImage.widthAnchor.constraint(equalToConstant: 120).isActive = true
        thumImage.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        
        authorName.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        
        addConstraint(NSLayoutConstraint(item: authorName, attribute: .leading, relatedBy: .equal, toItem: thumImage, attribute: .trailing, multiplier: 1, constant: 20))
        
        addConstraint(NSLayoutConstraint(item: name, attribute: .top, relatedBy: .equal, toItem: authorName, attribute: .bottom, multiplier: 1, constant: 20))
        
        addConstraint(NSLayoutConstraint(item: name, attribute: .leading, relatedBy: .equal, toItem: thumImage, attribute: .trailing, multiplier: 1, constant: 20))
        
          addConstraint(NSLayoutConstraint(item: contentView, attribute: .trailing, relatedBy: .equal, toItem: name, attribute: .trailing, multiplier: 1, constant: 20))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // Update table view cell and get image data
    func updateData(result: results) {
        authorName.text = result.artistName
        name.text = result.name
        if let url = result.artworkUrl100 {
            NetWorkManager.shared().downloadImage(imageUrl: url) { (image) in
                DispatchQueue.main.async {
                    self.thumImage.layer.cornerRadius = 6.0
                    self.thumImage.layer.masksToBounds = true
                    self.thumImage.image = image
                }
            }
        }
        
        
    }

    
}
