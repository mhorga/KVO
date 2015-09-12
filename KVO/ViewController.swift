//
//  ViewController.swift
//  KVO
//
//  Created by Marius Horga on 9/13/15.
//  Copyright (c) 2015 Marius Horga. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let currentBalanceKeyPath = "currentBalance"
    var account = Account()
    
    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    
    @IBAction func submitAction(sender: UIButton) {
        let amount = (amountTextField.text as NSString).doubleValue
        account.update(amount)
        amountTextField.text = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentBalanceLabel.text = "Current balance: \(account.currentBalance)"
        account.addObserver(self, forKeyPath: currentBalanceKeyPath, options: NSKeyValueObservingOptions.Old | NSKeyValueObservingOptions.New, context: nil)
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if keyPath == currentBalanceKeyPath {
            if (account.currentBalance < 0) {
                currentBalanceLabel.textColor = UIColor.redColor()
            } else {
                currentBalanceLabel.textColor = UIColor.blackColor()
            }
            currentBalanceLabel.text = "Current balance: \(account.currentBalance)"
        }
    }
    
    deinit {
        account.removeObserver(self, forKeyPath: currentBalanceKeyPath)
    }
}

