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
    
    //var activityArrayDic:[Dictionary<String, String>] = []
    var allActivitiesArray: [[ActivityModel]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date1 = Date.from(year: 2014, month: 5, day: 14)
        let date2 = Date.from(year: 2014, month: 7, day: 13)
        let date3 = Date.from(year: 2014, month: 5, day: 10)
        // Do any additional setup after loading the view, typically from a nib.
        let activity1: ActivityModel = ActivityModel(activity: "Do Homework", subActivity: "Math Problems", date: date1, isComplete: false)
        let activity2: ActivityModel = ActivityModel(activity: "Clean Room", subActivity: "Bed, Floor, Desk", date: date2, isComplete: false)

        let incompleteActivityArray = [activity1, activity2, ActivityModel(activity: "Wash Dishes", subActivity: "Dishes", date: date3, isComplete: false)]
        
        let completedActivityArray = [ActivityModel(activity: "Program", subActivity: "Swift", date: date2, isComplete: true)]
        
        allActivitiesArray = [incompleteActivityArray, completedActivityArray]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showActivityDetail" {
            let activityDetailVC: ActivityDetailViewController = segue.destinationViewController as ActivityDetailViewController
            let indexPath = tableView.indexPathForSelectedRow()
            activityDetailVC.detailActivityModel =  allActivitiesArray[indexPath!.section][indexPath!.row]
            activityDetailVC.mainVC = self
        }
        else if segue.identifier == "showActivityAdd" {
            let addActivityVC: AddActivityViewController = segue.destinationViewController as AddActivityViewController
            addActivityVC.mainVC = self
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        for var i = 0; i < allActivitiesArray.count ; i++ {
            allActivitiesArray[i] =  allActivitiesArray[i].sorted({
                $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970
            })
        }
        
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func addButtonTapped(sender: AnyObject) {
        self.performSegueWithIdentifier("showActivityAdd", sender: self)
    }
    
    
    //UITableViewSource Implementation
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return allActivitiesArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allActivitiesArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println(indexPath.row)
        var cell: ActivityCell =  tableView.dequeueReusableCellWithIdentifier("activityTempCell") as ActivityCell
        let activ = allActivitiesArray[indexPath.section][indexPath.row]
        cell.activityLabel.text = activ.activity
        cell.descriptionLabel.text = activ.subActivity
        cell.dateLabel.text = Date.toString(date: activ.date)
        return cell
    }

    //UITableViewDelagate Implementation
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        performSegueWithIdentifier("showActivityDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Activities to do"
        } else {
            return "Completed Activities"
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let currentActivity = allActivitiesArray[indexPath.section][indexPath.row]
        
        let completedTask = ActivityModel(activity: currentActivity.activity, subActivity: currentActivity.subActivity, date: currentActivity.date, isComplete: true)
        
        allActivitiesArray[indexPath.section].removeAtIndex(indexPath.row)
        allActivitiesArray[1].append(completedTask)
        
        tableView.reloadData()
    }
    
    //Note: Activity Helper Functions, move this to a service class
    
    func sortByDate(activityone: ActivityModel, activitytwo: ActivityModel) -> Bool{
        return activityone.date.timeIntervalSince1970 < activitytwo.date.timeIntervalSince1970
    }
    
}

