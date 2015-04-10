//
//  ExerciseDetailViewController.swift
//  Weit
//
//  Created by Edwin Rodriguez on 2/10/15.
//  Copyright (c) 2015 Edwin Rodriguez. All rights reserved.
//

import UIKit

protocol ExerciseDetailViewControllerDelegate: class {
    func exerciseDetailViewControllerDidCancel(controller: ExerciseDetailViewController)
    func exerciseDetailViewController(controller: ExerciseDetailViewController, didFinishAddingItem item: Exercises)
    func exerciseDetailViewController(controller: ExerciseDetailViewController, didFinishEditingItem item: Exercises)
}

class ExerciseDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: ExerciseDetailViewControllerDelegate?
    
    var itemToEdit: Exercises?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        
        if let item = itemToEdit {
            title = "Edit Exercise"
            textField.text = item.name
            doneBarButton.enabled = true
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
        delegate?.exerciseDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.name = textField.text
            delegate?.exerciseDetailViewController(self, didFinishEditingItem: item)
            
        } else {
            let item = Exercises(name: textField.text)
            item.name = textField.text
            delegate?.exerciseDetailViewController(self, didFinishAddingItem: item)
        }
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
    
    func textField(textField: UITextField,shouldChangeCharactersInRange range: NSRange,replacementString string: String) -> Bool {
        
        let oldText: NSString = textField.text
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton.enabled = (newText.length > 0)
        return true
    }
}
