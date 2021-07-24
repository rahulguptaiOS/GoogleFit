//
//  NetworkManager.swift
//  GFitStepCount
//
//  Created by Gupta, Rahul @ Gurgaon on 24/07/21.
//

import Foundation

class NetworkManager {
    
    func fetchSteps(params: StepRequestModel, completion:@escaping ((_ model: [StepViewModel]?, _ error: Error?) -> Void)) {
        if let user = URL(string: "https://www.googleapis.com/fitness/v1/users/me/dataset:aggregate") {
            var request = URLRequest(url: user)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = getHeader()
            do {
                request.httpBody =  try JSONEncoder().encode(params)
            } catch  {
                
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                     if let responseData = data {
                        let step = try JSONDecoder().decode(StepModel.self, from: responseData)
                        guard let buckets = step.bucket else {
                            return
                        }
                        
                        var stepModel = [StepViewModel]()
                        for bucket in buckets {
                            stepModel.append(StepViewModel(bucket: bucket))
                        }
                        completion(stepModel, nil)
                    }
                } catch {}
            }
            
            task.resume()
        }
    }
    
    func getHeader() -> [String : String] {
        var headerDict = ["Content-type": "application/json"]
        do {
            try headerDict["Authorization"] = "Bearer \(KeychainManager.getAuthToken())"
        } catch {
        }
        
        return headerDict
    }
}
