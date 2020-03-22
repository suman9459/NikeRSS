//
//  GenresCell.swift
//  NikeRSS
//
//  Created by sai suman Pothedar on 3/22/20.
//  Copyright © 2020 sai suman Pothedar. All rights reserved.
//

import Foundation
import UIKit

class GenresCell: UITableViewCell {
    
    var idLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        addSubViews()
        updateConstraintsToViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    private func addSubViews(){
        addSubview(idLabel)
        addSubview(name)
    }
    
    // Auto Layout Constrains
    private func updateConstraintsToViews() {
        idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        idLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        idLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20).isActive = true
        name.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 10).isActive = true
        name.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func updateCell(genre: genres?) {
        if let id = genre?.genreId {
            idLabel.text = "ID: " + id
        }
        if let name = genre?.name {
            self.name.text = "Name: "+name
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
