//
//  SchoolTableViewCell.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/26/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.08
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // for perfomerce issues we set bezier path
        // and should resize this bezier path when did layout subviews becouse bezier path no auto resize
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: layer.cornerRadius).cgPath
    }
}

class SchoolTableViewCell: UITableViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var school: School? {
        didSet {
            self.reloadView()
        }
    }
    
    func reloadView() {
        self.nameLabel.text = self.school?.name
        self.locationLabel.text = self.school?.neighborhood
        if let string = self.school?.rate, let rate = Double(string) {
            self.rateLabel.text = String(format: "%.1f%%", rate * 100)
        } else {
            self.rateLabel.text = "N/A"
        }
    }
    
}
