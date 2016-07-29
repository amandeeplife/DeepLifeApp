//
//  AddEditVC.swift
//  CD-Grocery-Images
//
//  Created by Jason Rybka on 8/16/15.
//  Copyright © 2015 Jason Rybka. All rights reserved.
//

import UIKit
import CoreData


class Discadd: UIViewController,NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var disc : Disciplelistt? = nil
    
    
    
    
    
    
    
    
    var Country: String = ""
    @IBOutlet weak var discemail: UITextField!
    @IBOutlet weak var discname: UITextField!
    
    @IBOutlet weak var disccountry: UITextField!
    
   // @IBOutlet weak var imageHolder: UIImageView!
    //@IBOutlet weak var discname: UITextField!
    //@IBOutlet weak var discemail: UITextField!
    //@IBOutlet weak var disccountry: UITextField!
    //@IBOutlet weak var imageHolder: UIImageView!
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // imageHolder.layer.cornerRadius = imageHolder.frame.size.width/2
        //imageHolder.clipsToBounds = true
                
        if disc != nil {
            discname.text = disc?.fullname
            discemail.text = disc?.country
            disccountry.text = disc?.email
      //    imageHolder.image = UIImage(data: (disc?.image)!)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addImage(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        pickerController.allowsEditing = true
        
        self.presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func addImageFromCamera(sender: AnyObject) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
        pickerController.allowsEditing = true
        
        self.presentViewController(pickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
   //     self.imageHolder.image = image
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        
        if disc != nil {
            editDisc()
        } else {
            createNewDisc()
        }
        
        dismissVC()
        
    }
    
    
    
    @IBAction func cancelTapped(sender: AnyObject) {
        
        dismissVC()
        
    }
    
    func dismissVC() {
        
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    func createNewDisc() {
        
        let entityDescription = NSEntityDescription.entityForName("Disciples", inManagedObjectContext: moc)
        
        let disclistattributes = Disciplelistt(entity: entityDescription!, insertIntoManagedObjectContext: moc)
        
        disclistattributes.fullname = discname.text
        disclistattributes.country = discemail.text
        disclistattributes.email = disccountry.text
     //   disclistattributes.image = UIImagePNGRepresentation(imageHolder.image!)
        
        do {
            try moc.save()
        } catch {
            return
        }
        
    }
    
    func editDisc() {
        
        disc?.fullname = discname.text
        disc?.country = discemail.text
        disc?.email = disccountry.text
     //  disc!.image = UIImagePNGRepresentation(imageHolder.image!)
        
        do {
            try moc.save()
        } catch {
            return
        }
        
    }
    
}













