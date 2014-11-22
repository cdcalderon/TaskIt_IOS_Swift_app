//
//  ViewController.swift
//  Taskit
//
//  Created by Carlos Calderon on 11/21/14.
//  Copyright (c) 2014 Calderware. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
    var activityArray: [ActivityModel] = []
    //var activityArrayDic:[Dictionary<String, String>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let activity1: ActivityModel = ActivityModel(activity: "Limpiar Cuarto", subActivity: "ropa, cama, escritori", date: "01/05/1979")
        let activity2: ActivityModel = ActivityModel(activity: "wash dishes", subActivity: "acomodar platos", date: "01/05/1979")

        activityArray = [activity1, activity2, ActivityModel(activity: "study", subActivity: "math", date: "01/06/1979")]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //UITableViewSource Implementation
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println(indexPath.row)
        var cell: ActivityCell =  tableView.dequeueReusableCellWithIdentifier("activityTempCell") as ActivityCell
        let actDic = activityArray[indexPath.row]
        cell.activityLabel.text = actDic.activity
        cell.descriptionLabel.text = actDic.subActivity
        cell.dateLabel.text = actDic.date
        return cell
    }

    //UITableViewDelagate Implemantation
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

