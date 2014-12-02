//
//  ActivityDetailViewController.swift
//  Taskit
//
//  Created by Carlos Calderon on 11/22/14.
//  Copyright (c) 2014 Calderware. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {

    var detailActivityModel: ActivityModel!
    
    @IBOutlet weak var activityTextField: UITextField!
    @IBOutlet weak var subActivityTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        activityTextField.text = detailActivityModel.activity
        subActivityTextField.text = detailActivityModel.subActivity
        dueDatePicker.date = detailActivityModel.date
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func doneButtonTapped(sender: AnyObject) {
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        detailActivityModel.activity = activityTextField.text
        detailActivityModel.subActivity = subActivityTextField.text
        detailActivityModel.date = dueDatePicker.date
        detailActivityModel.isComplete = detailActivityModel.isComplete
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}
