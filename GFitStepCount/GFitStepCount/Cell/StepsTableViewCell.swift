//
//  StepsTableViewCell.swift
//  GFitStepCount
//
//  Created by Gupta, Rahul @ Gurgaon on 24/07/21.
//

import UIKit

class StepsTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(model: StepViewModel) {
        dateLabel.text = model.startTime
        hoursLabel.text = model.hours
        stepsLabel.text = model.steps
    }

    
}
