//
//  ViewController.swift
//  MemeMe 1.1
//
//  Created by Jim Nording on 27/11/15.
//  Copyright © 2015 Jim Nording. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    // Global variables
    
    let imagePicker = UIImagePickerController()
    
    let memeTextAttributes: [String: AnyObject] = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]
    
    
    
    // Outlets
    
    @IBOutlet weak var memeView: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    
    
    
    
    // View Lifecycles
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Delegates
        imagePicker.delegate = self
        
        // Enable cameraButton if camera is available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        
        // Set text fields
        topTextField.attributedText = NSAttributedString(string: "TOP", attributes: memeTextAttributes)
        bottomTextField.attributedText = NSAttributedString(string: "BOTTOM", attributes: memeTextAttributes)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }

    
    
    
    
    // Methods
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.clearsOnBeginEditing = true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeigth(notification)
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomTextField.isFirstResponder() {
            view.frame.origin.y += getKeyboardHeigth(notification)
        }
    }
    
    func getKeyboardHeigth(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        memeView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(false, completion: nil)
        
        // Found good tutorial: ( https://www.youtube.com/watch?v=1EmGRVlifhw )
    }
    
    func alertMessage(title: String, message: String) {
        
        let alertMessage = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        
        alertMessage.addAction(okAction)
        
        self.presentViewController(alertMessage, animated: true, completion: nil)
        
        // Found tutorial: https://www.youtube.com/watch?v=3vMTpBCFljY
    }


    
    
    
    
    
    // Actions
    
    @IBAction func accessCamera(sender: AnyObject) {
        
        if (UIImagePickerController.isSourceTypeAvailable(.Camera)) {
            if (UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil) {
                imagePicker.sourceType = .Camera
                imagePicker.cameraCaptureMode = .Photo
                presentViewController(imagePicker, animated: true, completion: nil)
                
            } else {
                alertMessage("Error", message: "There is a problem to access the camera")
            }
            
        } else {
            alertMessage("Access Required", message: "Allow Access to camera to take photo")
        }
    }
    
    @IBAction func accessPhotoAlbum(sender: AnyObject) {
        
        imagePicker.sourceType = .PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
    }

    @IBAction func cancelAction(sender: AnyObject) {
    }


}

