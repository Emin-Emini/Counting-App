//
//  ViewController.swift
//  Counting App
//
//  Created by Emin on 12/25/15.
//  Copyright © 2015 Emin Emini. All rights reserved.
//

import UIKit
import WatchConnectivity

@available(iOS 9.0, *)
class ViewController: UIViewController, WCSessionDelegate {
    
    var watchSession : WCSession?

    @IBAction func resetButton(sender: AnyObject) {
        NSUserDefaults().removeObjectForKey("counter")
        countedLabel.text = "\(counter)"
    }
    
    @IBOutlet var countedLabel: UILabel!
    
    var counter: Int {
        return NSUserDefaults().integerForKey("counter")
    }
    
    @IBAction func countUpButton(sender: AnyObject) {
        NSUserDefaults().setInteger(counter+1, forKey: "counter")
        countedLabel.text = "\(counter)"
        
        
        
        if let message : String = countedLabel.text {
            do {
                try watchSession?.updateApplicationContext(
                    ["message" : message]
                )
            } catch let error as NSError {
                NSLog("Updating the context failed: " + error.localizedDescription)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if(WCSession.isSupported()){
            watchSession = WCSession.defaultSession()
            watchSession!.delegate = self
            watchSession!.activateSession()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


