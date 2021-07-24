//
//  StepModel.swift
//  GFitStepCount
//
//  Created by Gupta, Rahul @ Gurgaon on 24/07/21.
//

import Foundation

struct StepModel: Codable {
    let bucket: [StepBucket]?
}

struct StepBucket: Codable {
    let startTimeMillis: String?
    let endTimeMillis: String?
    let dataset: [StepDataSet]?
}

struct StepDataSet: Codable {
    let dataSourceId: String?
    let point: [StepPoint]?
}

struct StepPoint: Codable {
    let value: [StepValue]?
}

struct StepValue: Codable {
    let intVal: Int?
}
