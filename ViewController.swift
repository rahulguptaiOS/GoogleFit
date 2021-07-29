//
//  ViewController.swift
//  GFitStepCount
//
//  Created by Gupta, Rahul @ Gurgaon on 24/07/21.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    let additionalScopes = ["https://www.googleapis.com/auth/fitness.sleep.write",
    "https://www.googleapis.com/auth/fitness.sleep.read",
    "https://www.googleapis.com/auth/fitness.reproductive_health.write",
    "https://www.googleapis.com/auth/fitness.reproductive_health.read",
    "https://www.googleapis.com/auth/fitness.oxygen_saturation.write",
    "https://www.googleapis.com/auth/fitness.oxygen_saturation.read",
    "https://www.googleapis.com/auth/fitness.nutrition.write",
    "https://www.googleapis.com/auth/fitness.activity.read",
    "https://www.googleapis.com/auth/fitness.activity.write",
    "https://www.googleapis.com/auth/fitness.blood_glucose.read",
    "https://www.googleapis.com/auth/fitness.blood_glucose.write",
    "https://www.googleapis.com/auth/fitness.blood_pressure.read",
    "https://www.googleapis.com/auth/fitness.blood_pressure.write",
    "https://www.googleapis.com/auth/fitness.body.read",
    "https://www.googleapis.com/auth/fitness.body.write",
    "https://www.googleapis.com/auth/fitness.body_temperature.read",
    "https://www.googleapis.com/auth/fitness.body_temperature.write",
    "https://www.googleapis.com/auth/fitness.heart_rate.read",
    "https://www.googleapis.com/auth/fitness.heart_rate.write",
    "https://www.googleapis.com/auth/fitness.location.read",
    "https://www.googleapis.com/auth/fitness.location.write",
    "https://www.googleapis.com/auth/fitness.nutrition.read"]
    
    let googleClientId = "994584469542-v0ajujei23eugclumet86r20kn4o4not.apps.googleusercontent.com"
    
    @IBOutlet weak var durationTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func signIn(_ sender: Any) {
        let signInConfig = GIDConfiguration(clientID: googleClientId)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            if user != nil {
                GIDSignIn.sharedInstance.addScopes(self.additionalScopes, presenting: self) { user, error in
                    guard error == nil else { return }
                    guard let user = user else { return }

                    do {
                        try KeychainManager.save(item: user.authentication.accessToken)
                        if let stepsViewController = self.storyboard?.instantiateViewController(identifier: "StepsViewController") as? StepsViewController {
                            stepsViewController.numOfDays = Int(self.durationTextField.text ?? "0") ?? 0
                            self.navigationController?.pushViewController(stepsViewController, animated: true)
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            // If sign in succeeded, display the app's main content View.
          }
    }
    
}

