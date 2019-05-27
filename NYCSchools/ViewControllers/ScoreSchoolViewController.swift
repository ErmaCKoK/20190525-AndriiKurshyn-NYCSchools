//
//  ScoreSchoolViewController.swift
//  20190525-AndriiKurshyn-NYCSchools
//
//  Created by Andrii Kurshyn on 5/25/19.
//  Copyright © 2019 Andrii Kurshyn. All rights reserved.
//

import UIKit

class ScoreView: UIView {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
}

class ScoreSchoolViewController: UIViewController {
    
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var scoreStackView: UIStackView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var indic: UIActivityIndicatorView!
    @IBOutlet weak var naLabel: UILabel!
    
    var school: School!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = school.name
        self.overviewTextView.text = school.overview
        
        self.featchScore()
    }
    
    func featchScore() {
        
        self.indic.startAnimating()
        self.reloadView()
        
        self.school.fetchScore { [weak self] (score, error) in
            guard let strongSelf = self else { return }
            
            strongSelf.indic.stopAnimating()
            strongSelf.reloadView()
            
            if let error = error {
                strongSelf.showAlert(with: error)
            }
        }
    }
    
    func reloadView() {
        
        let isScoreNil = self.school.score == nil
        self.backgroundView.isHidden = isScoreNil
        self.scoreStackView.arrangedSubviews.forEach({ $0.isHidden = isScoreNil })
        self.naLabel.isHidden = self.indic.isAnimating || !isScoreNil
        
        guard let score = self.school.score else { return }
        
        let views = self.scoreStackView.arrangedSubviews
        (views[0] as! ScoreView).scoreLabel.text = score.math
        (views[1] as! ScoreView).scoreLabel.text = score.reading
        (views[2] as! ScoreView).scoreLabel.text = score.writing
        
    }

}
