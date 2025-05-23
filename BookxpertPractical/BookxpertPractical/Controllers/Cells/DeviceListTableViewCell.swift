//
//  DeviceListTableViewCell.swift
//  BookxpertPractical
//
//  Created by MACM13 on 15/04/25.
//

import UIKit

class DeviceListTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLbl: UILabel!
    @IBOutlet private weak var descLbl: UILabel!
    
    static let reuseIdentifier = "DeviceListCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setDetails(with data: DeviceListDetails) {
        nameLbl.text = data.name
        
        var descParts: [String] = []
        
        if let description = data.deviceDescription {
            descParts.append(description)
        }
        if let color = data.color {
            descParts.append("Color - \(color)")
        }
        if let price = data.devicePrice {
            descParts.append("Price - \(price)")
        }
        if let capacity = data.capacity {
            descParts.append("Capacity - \(capacity)")
        }
        if let generation = data.generation {
            descParts.append("Generation - \(generation)")
        }
        
        let desc = descParts.isEmpty ? "No Description" : descParts.joined(separator: "\n")
        descLbl.text = desc
    }
    
}
