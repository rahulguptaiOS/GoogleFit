//
//  StepViewModel.swift
//  GFitStepCount
//
//  Created by Gupta, Rahul @ Gurgaon on 24/07/21.
//

import Foundation

struct StepViewModel {
    var startTime: String = ""
    var hours: String = ""
    var steps: String = ""
    var totalSteps = 0
    
    init(bucket: StepBucket) {
        if let startTimeMillis = Double(bucket.startTimeMillis ?? ""), let endMilis = Double(bucket.endTimeMillis ?? "") {
            let startDate = Date(timeIntervalSince1970: (startTimeMillis / 1000.0))
            let endDate = Date(timeIntervalSince1970: (endMilis / 1000.0))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd,yyyy"
            startTime = dateFormatter.string(from: startDate)
            hours = "\(StepViewModel.stringFromTimeInterval(interval: startDate.distance(to: endDate))) hours"
            if let dataSet = bucket.dataset {
                for set in dataSet {
                    guard let points = set.point else {
                        return
                    }
                    
                    for point in points {
                        guard let values = point.value else {
                            return
                        }
                        
                        for value in values {
                            totalSteps = totalSteps + (value.intVal ?? 0)
                        }
                    }
                }
            }
        }
        
        steps = "\(totalSteps) steps"
    }
    
    static func stringFromTimeInterval(interval: TimeInterval) -> String {
          let ti = NSInteger(interval)
          let minutes = (ti / 60) % 60
          let hours = (ti / 3600)
          return NSString(format: "%0.2d:%0.2d",hours,minutes) as String
    }
}
