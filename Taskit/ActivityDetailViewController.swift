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
    var mainVC: ViewController!
    
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
        var activity = ActivityModel(activity: activityTextField.text, subActivity: subActivityTextField.text, date: dueDatePicker.date)
        mainVC.activityArray[mainVC.tableView.indexPathForSelectedRow()!.row] = activity
        self.navigationController?.popViewControllerAnimated(true)
    }
}
