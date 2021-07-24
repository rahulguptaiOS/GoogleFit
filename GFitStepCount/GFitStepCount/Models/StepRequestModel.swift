//
//  StepRequestModel.swift
//  GFitStepCount
//
//  Created by Gupta, Rahul @ Gurgaon on 24/07/21.
//

import Foundation

struct StepRequestModel: Codable {
    var aggregateBy = [AggregateData()]
    var bucketByTime = Duration()
    let startTimeMillis: Double?
    let endTimeMillis: Double?
}

struct Duration: Codable {
    var durationMillis = 24 * 3600 * 1000
}

struct AggregateData: Codable {
    var dataTypeName = "com.google.step_count.delta"
    var dataSourceId = "derived:com.google.step_count.delta:com.google.android.gms:estimated_steps"
}
