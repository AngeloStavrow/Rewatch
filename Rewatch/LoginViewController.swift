//
//  ViewController.swift
//  Rewatch
//
//  Created by Romain Pouclet on 2015-10-15.
//  Copyright © 2015 Perfectly-Cooked. All rights reserved.
//

import UIKit
import ReactiveCocoa

class LoginViewController: UIViewController {
    var client: Client!

    @IBAction func authenticate(sender: AnyObject) {
        client.authenticate()
            .on(next: { (client) -> () in
                if let token = client.token {
                    print("Storing token \(token)")
                    storeToken(token)
                }
            })
            .observeOn(UIScheduler())
            .startWithNext { (authenticatedClient) -> () in
                self.performSegueWithIdentifier("DownloadSegue", sender: self)
            }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let vc = segue.destinationViewController as? DownloadViewController {
            vc.client = client
        }
    }
}
