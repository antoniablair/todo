//
//  TodoViewController.swift
//  Crowlie
//
//  Created by Antonia Blair on 5/29/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//

import UIKit

class TodoViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate {
    
    // MARK: Properties

    
    @IBOutlet weak var frequencyPicker: UIPickerView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var todo: Todo?
    var frequencyPickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Connect data
        nameTextField.delegate = self
        
        self.frequencyPicker.delegate = self
        self.frequencyPicker.dataSource = self
        
        // Input data into the Array:
        frequencyPickerData = ["Once", "Daily", "Weekly"]
        
        if let todo = todo {
            navigationItem.title = todo.name
            nameTextField.text = todo.name
            // this part is broken
            frequencyPicker.selectRow(1, inComponent: 0, animated: true)
        }
        
        checkValidTodoName()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(frequencyPickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(frequencyPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return frequencyPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(frequencyPickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return frequencyPickerData[row]
    }
    
    // change font :)
    func pickerView(frequencyPickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
            let label = UILabel()
            label.font = UIFont(name: "American Typewriter", size: 16)
            label.text = frequencyPickerData[row]
            return label
    }
    
    // User selects from the picker
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        print ("Resign the keyboard")
        nameTextField.resignFirstResponder()
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        print (textField.text)
        checkValidTodoName()
        // nagivationItem.title = textfield.Text
        print ("Change nav title")
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.enabled = false
    }
    
    func checkValidTodoName() {
        // disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    
    // MARK: Navigation
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        let isPresentingInAddTodoMode = presentingViewController is UINavigationController
        if isPresentingInAddTodoMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else {
            // if it's a push notification, pop it out
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    // This method lets you configure a view controller before it's presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender {
            let name = nameTextField.text ?? ""
            let completed = false
            let frequency = frequencyPickerData[frequencyPicker.selectedRowInComponent(0)]
            
            todo = Todo(name: name, frequency: frequency, completed: completed)
        }
    }
    
    
    // MARK: Actions

}

