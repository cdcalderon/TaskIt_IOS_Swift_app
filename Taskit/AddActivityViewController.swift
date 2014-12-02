//
//  AddActivityViewController.swift
//  Taskit
//
//  Created by Carlos Calderon on 11/23/14.
//  Copyright (c) 2014 Calderware. All rights reserved.
//

import UIKit
import CoreData
class AddActivityViewController: UIViewController {

    
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
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        
        
        
        let entityDescription = NSEntityDescription.entityForName("ActivityModel", inManagedObjectContext: managedObjectContext!)
        
        
        
        let activity = ActivityModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        activity.activity = activityTextField.text
        activity.subActivity = subActivityTextField.text
        activity.date = dueDateTextField.date
        activity.isComplete = false
        
        appDelegate.saveContext()
        
        var request = NSFetchRequest(entityName: "ActivityModel")
        var error: NSError? = nil
        var results: NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
    
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
