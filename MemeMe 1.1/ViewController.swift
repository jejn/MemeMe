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
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    
    
    
    
    
    
    // Actions
    
    @IBAction func accessCamera(sender: AnyObject) {
    }
    
    @IBAction func accessPhotoAlbum(sender: AnyObject) {
    }
    
    @IBAction func shareMeme(sender: AnyObject) {
    }

    @IBAction func cancelAction(sender: AnyObject) {
    }


}

