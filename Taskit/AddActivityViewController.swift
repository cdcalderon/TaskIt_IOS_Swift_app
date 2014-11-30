//
//  AddActivityViewController.swift
//  Taskit
//
//  Created by Carlos Calderon on 11/23/14.
//  Copyright (c) 2014 Calderware. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {

    var mainVC: ViewController!
    
    @IBOutlet weak var activityTextField: UITextField!
    @IBOutlet weak var subActivityTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addActivityButtonTapped(sender: AnyObject) {
        var activity = ActivityModel(activity: activityTextField.text, subActivity: subActivityTextField.text, date: dueDateTextField.date, isComplete: false)
    
        mainVC.allActivitiesArray[0].append(activity)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
