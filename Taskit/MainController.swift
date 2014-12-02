//
//  ViewController.swift
//  Taskit
//
//  Created by Carlos Calderon on 11/21/14.
//  Copyright (c) 2014 Calderware. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{

    @IBOutlet weak var tableView: UITableView!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    var fetchedResultsController: NSFetchedResultsController = NSFetchedResultsController()
    
        override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultsController = getFetchedResultController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showActivityDetail" {
            let activityDetailVC: ActivityDetailViewController = segue.destinationViewController as ActivityDetailViewController
            let indexPath = tableView.indexPathForSelectedRow()
            activityDetailVC.detailActivityModel =  fetchedResultsController.objectAtIndexPath(indexPath!) as ActivityModel
        }
        else if segue.identifier == "showActivityAdd" {
            let addActivityVC: AddActivityViewController = segue.destinationViewController as AddActivityViewController
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        for var i = 0; i < allActivitiesArray.count ; i++ {
//            allActivitiesArray[i] =  allActivitiesArray[i].sorted({
//                $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970
//            })
//        }
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
       return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let thisTask = fetchedResultsController.objectAtIndexPath(indexPath) as ActivityModel
        
        println(thisTask)
        
        var cell: ActivityCell = tableView.dequeueReusableCellWithIdentifier("activityTempCell") as ActivityCell
        
        cell.activityLabel.text = thisTask.activity
        cell.descriptionLabel.text = thisTask.subActivity
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
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
        let currentActivity = fetchedResultsController.objectAtIndexPath(indexPath) as ActivityModel
        
        if indexPath.section == 0 {
            currentActivity.isComplete = true

        }else if indexPath.section == 1 {
            currentActivity.isComplete = false
        }
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    // NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    // Sort Descriptor Helper
    
    func activityFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "ActivityModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        let completedDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
        fetchRequest.sortDescriptors = [completedDescriptor, sortDescriptor]
        
        return fetchRequest
    }
    
    func getFetchedResultController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: activityFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "isComplete", cacheName: nil)
        
        return fetchedResultsController
    }
    
}

