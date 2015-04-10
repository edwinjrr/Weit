//
//  SetsViewController.swift
//  Weit
//
//  Created by Edwin Rodriguez on 2/11/15.
//  Copyright (c) 2015 Edwin Rodriguez. All rights reserved.
//

import UIKit

class SetsViewController: UIViewController {

    var exercises: Exercises!
    let weightChange = WeitModel()
    
    @IBOutlet weak var setOne: UILabel!
    @IBOutlet weak var setTwo: UILabel!
    @IBOutlet weak var setThree: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = exercises.name
        setOne.text = String(exercises.weight[0])
        setTwo.text = String(exercises.weight[1])
        setThree.text = String(exercises.weight[2])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func setOneUp(sender: AnyObject) {
        exercises.weight[0] = weightChange.addOne(exercises.weight[0])
        setOne.text = String(exercises.weight[0])
    }
    
    @IBAction func setOneDown(sender: AnyObject) {
        exercises.weight[0] = weightChange.removeOne(exercises.weight[0])
        setOne.text = String(exercises.weight[0])
    }
    
    @IBAction func setTwoUp(sender: AnyObject) {
        exercises.weight[1] = weightChange.addOne(exercises.weight[1])
        setTwo.text = String(exercises.weight[1])
    }
    
    @IBAction func setTwoDown(sender: AnyObject) {
        exercises.weight[1] = weightChange.removeOne(exercises.weight[1])
        setTwo.text = String(exercises.weight[1])
    }
    
    @IBAction func setThreeUp(sender: AnyObject) {
        exercises.weight[2] = weightChange.addOne(exercises.weight[2])
        setThree.text = String(exercises.weight[2])
    }
    
    @IBAction func setThreeDown(sender: AnyObject) {
        exercises.weight[2] = weightChange.removeOne(exercises.weight[2])
        setThree.text = String(exercises.weight[2])
    }
    
    @IBAction func resetWeight(sender: AnyObject) {
        let alertController = UIAlertController(title: "¿Start Over?", message: "It's never too late to start again.", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        
        let resetAction = UIAlertAction(title: "Restart", style: .Destructive, handler: {action in
            self.exercises.weight[0] = self.weightChange.resetCount(self.exercises.weight[0])
            self.exercises.weight[1] = self.weightChange.resetCount(self.exercises.weight[1])
            self.exercises.weight[2] = self.weightChange.resetCount(self.exercises.weight[2])
            self.setOne.text = String(self.exercises.weight[0])
            self.setTwo.text = String(self.exercises.weight[1])
            self.setThree.text = String(self.exercises.weight[2])
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(resetAction)
        
        presentViewController(alertController, animated: true, completion: nil)
    }
}
