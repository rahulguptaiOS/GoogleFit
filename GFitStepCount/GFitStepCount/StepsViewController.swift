//
//  StepsViewController.swift
//  GFitStepCount
//
//  Created by Gupta, Rahul @ Gurgaon on 24/07/21.
//

import UIKit

class StepsViewController: UIViewController {
    var stepsModel: [StepViewModel]?
    var numOfDays = 1
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        let endDate = floor(Date().timeIntervalSince1970 * 1000)
        let startDate = floor(endDate - Double((numOfDays * 24 * 3600 * 1000)))
        let stepRequest = StepRequestModel(startTimeMillis: startDate, endTimeMillis: endDate)
        NetworkManager().fetchSteps(params: stepRequest) { stepModel, error  in
            self.stepsModel = stepModel
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                
                if error == nil {
                    self.table.reloadData()
                }
            }
        }
    }

}

extension StepsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepsModel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "StepsTableViewCell", for: indexPath) as? StepsTableViewCell, let model = stepsModel?[indexPath.row] {
            cell.configure(model: model)
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

