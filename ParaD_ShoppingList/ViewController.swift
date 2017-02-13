//
//  ViewController.swift
//  ParaD_ShoppingList
//
//  Created by David Para on 2/8/17.
//  Copyright © 2017 David Para. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listView: UITextView!
    @IBOutlet var textFields: [UITextField]!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // When a user touches outside of the application view, the keyboard will be hidden. For right now, outside of view is above "Shopping List" title
    @IBAction func backgroundTouched() {
        for tf in textFields {
            tf.resignFirstResponder()
        }
        listView.resignFirstResponder()
    }
    
    // When editting ends inside a user input field, text field resigns as First Responder
    @IBAction func editEnded(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    // Action for when "New List" button is pressed
    @IBAction func newListAction() {
        clearTextFields()
        listView.text = "No Item"
    }
    
    // Action for when "New Item" button is pressed
    @IBAction func newItemAction() {
        clearTextFields()
    }
    
    // Action for when "Add" button is pressed
    @IBAction func addAction() {
        for tf in textFields {
            if tf.text == "" {
                missingField(tf)
                return
            }
        }
        if listView.text == "No Item"  {
            listView.text = ""
        }
        if let quantity = textFields[1].text {
            if Int(quantity) == nil {
                invalidIntAlert()
                return
            } else {
                listView.text.append(addQuantity(quantity))
            }
        }
        if let description = textFields[0].text {
            listView.text.append(addDescription(description))
        }
        clearTextFields()
    }
    
    // Checks to ensure that fields are valid and not empty
    func missingField(_ tf: UITextField) {
        if tf == textFields[0] {
            missingFieldAlert(missing: "Description")
        } else {
            missingFieldAlert(missing: "Quantity")
        }
    }
    
    // Sends invalid interger error alert
    func invalidIntAlert() {
        let message = "Please enter a valid integer!\n(No decimal points)"
        let  title = "Shopping List"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Sends missing field error alert
    func missingFieldAlert(missing tfDescription: String) {
        let message = "\(tfDescription) field is missing!"
        let title = "Shopping List"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // Returns proper quantity string formatting
    func addQuantity(_ quantity: String) -> String {
        let s = "\(quantity)x "
        return s
    }
    
    // Returns proper description string formatting
    func addDescription(_ description: String) -> String {
        let s = "\(description)\n"
        return s
    }

    // Clears all of the text fields of user input
    func clearTextFields() {
        for tf in textFields {
            tf.text = ""
        }
    }
    
}

