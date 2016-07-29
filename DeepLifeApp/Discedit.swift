//
//  AddEditVC.swift
//  CD-Grocery-Images
//
//  Created by Jason Rybka on 8/16/15.
//  Copyright © 2015 Jason Rybka. All rights reserved.
//

import UIKit
import CoreData

class Discedit: UIViewController, NSFetchedResultsControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var disc : Disciplelistt? = nil
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemNote: UITextField!
    @IBOutlet weak var itemQty: UITextField!
    @IBOutlet weak var imageHolder: UIImageView!
    
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if disc != nil {
            itemName.text = disc?.fullname
            itemNote.text = disc?.country
            itemQty.text = disc?.email
            imageHolder.image = UIImage(data: (disc?.image)!)
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
        
        self.imageHolder.image = image
    }
    
    @IBAction func saveTapped(sender: AnyObject) {
        
        if disc != nil {
            editItem()
        } else {
            createNewItem()
        }
        
        dismissVC()
        
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        
        dismissVC()
        
    }
    
    func dismissVC() {
        
        
        navigationController?.popViewControllerAnimated(true)
        
    }
    
    func createNewItem() {
        
        let entityDescription = NSEntityDescription.entityForName("Disciples", inManagedObjectContext: moc)
        
        let item = Disciplelistt(entity: entityDescription!, insertIntoManagedObjectContext: moc)
        
        item.fullname = itemName.text
        item.country = itemNote.text
        item.email = itemQty.text
        item.image = UIImagePNGRepresentation(imageHolder.image!)
        
        do {
            try moc.save()
        } catch {
            return
        }
        
    }
    
    func editItem() {
        
        disc?.fullname = itemName.text
        disc?.country = itemNote.text
        disc?.email = itemQty.text
        disc!.image = UIImagePNGRepresentation(imageHolder.image!)
        
        do {
            try moc.save()
        } catch {
            return
        }
        
    }
    
}













