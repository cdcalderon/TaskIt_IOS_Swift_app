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
        
        let date1 = Date.from(year: 2014, month: 5, day: 14)
        let date2 = Date.from(year: 2014, month: 7, day: 13)
        let date3 = Date.from(year: 2014, month: 5, day: 10)
        // Do any additional setup after loading the view, typically from a nib.
        let activity1: ActivityModel = ActivityModel(activity: "Limpiar Cuarto", subActivity: "ropa, cama, escritori", date: date1)
        let activity2: ActivityModel = ActivityModel(activity: "wash dishes", subActivity: "acomodar platos", date: date2)

        activityArray = [activity1, activity2, ActivityModel(activity: "study", subActivity: "math", date: date3)]
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showActivityDetail" {
            let activityDetailVC: ActivityDetailViewController = segue.destinationViewController as ActivityDetailViewController
            let indexPath = tableView.indexPathForSelectedRow()
            activityDetailVC.detailActivityModel =  activityArray[indexPath!.row]
            activityDetailVC.mainVC = self
        }
        else if segue.identifier == "showActivityAdd" {
            let addActivityVC: AddActivityViewController = segue.destinationViewController as AddActivityViewController
            addActivityVC.mainVC = self
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
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
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println(indexPath.row)
        var cell: ActivityCell =  tableView.dequeueReusableCellWithIdentifier("activityTempCell") as ActivityCell
        let activ = activityArray[indexPath.row]
        cell.activityLabel.text = activ.activity
        cell.descriptionLabel.text = activ.subActivity
        cell.dateLabel.text = Date.toString(date: activ.date)
        return cell
    }

    //UITableViewDelagate Implemantation
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        performSegueWithIdentifier("showActivityDetail", sender: self)
    }
    
    
}

