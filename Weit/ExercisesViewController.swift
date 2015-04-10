//
//  ExercisesViewController.swift
//  Weit
//
//  Created by Edwin Rodriguez on 2/9/15.
//  Copyright (c) 2015 Edwin Rodriguez. All rights reserved.
//

import UIKit

class ExercisesViewController: UITableViewController, ExerciseDetailViewControllerDelegate {
    
    var dataModel: DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = 44
        let logo = UIImage(named: "weit.png")
        navigationItem.titleView = UIImageView(image:logo)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.exercises.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ExercisesCell") as UITableViewCell

        let item = dataModel.exercises[indexPath.row]
        cell.textLabel!.text = item.name
        cell.detailTextLabel!.text = "\(item.weight[0])" + " - \(item.weight[1]) - " + "\(item.weight[2])"
        
//      configureTextForCell(cell, withChecklistItem: item)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let exercises = dataModel.exercises[indexPath.row]
        performSegueWithIdentifier("ShowSets", sender: exercises)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.exercises.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: Exercises) {
        let label = cell.viewWithTag(1001) as UILabel
        label.text = item.name
    }
    
    func exerciseDetailViewControllerDidCancel(controller: ExerciseDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func exerciseDetailViewController(controller: ExerciseDetailViewController, didFinishAddingItem item: Exercises) {
        let newRowIndex = dataModel.exercises.count
        
        dataModel.exercises.append(item)
        
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)
        let indexPaths = [indexPath]
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func exerciseDetailViewController(controller: ExerciseDetailViewController, didFinishEditingItem item: Exercises) {
        if let index = find(dataModel.exercises, item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) {
                configureTextForCell(cell, withChecklistItem: item)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddExercise" {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as ExerciseDetailViewController
            controller.delegate = self
        } else if segue.identifier == "EditExercise" {
            let navigationController = segue.destinationViewController as UINavigationController
            let controller = navigationController.topViewController as ExerciseDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as UITableViewCell) {
                controller.itemToEdit = dataModel.exercises[indexPath.row]
            }
        } else if segue.identifier == "ShowSets" {
            let controller = segue.destinationViewController as SetsViewController
            controller.exercises = sender as Exercises
        }
    }
}
