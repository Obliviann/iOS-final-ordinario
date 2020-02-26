//
//  CoreDataService.swift
//  final-ordinario-todolist
//
//  Created by Olivia Sartorius Freschet on 26/2/20.
//  Copyright © 2020 Olivia Sartorius Freschet. All rights reserved.
//

import Foundation
import CoreData

/*Core Data is used to be persistent, to save data throughtout app launches, for offline use, to chache temp data... It is a framework to manage the MODEL LAYER object in our app*/
//we create this class to not have the AppDelegate filled with Core Data Stack code
class CoreDataService {
    
    private init() {}
    static var context: NSManagedObjectContext { return persistentContainer.viewContext }
    
    // MARK: - Core Data stack
    
    static var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "final_ordinario_todolist")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //Fetch form Core Data
    static func fetchFromCoreData() -> Bool {
        let context = persistentContainer.viewContext               //same as*
        var resss:Bool = false
        //Prepare the request of type NSFetchRequest for the entity
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            //Fetch the result from context in the form of array of [NSManagedObject]
            let result = try context.fetch(request)
            //Iterate through array to get value for the specific key
            for data in result as! [NSManagedObject] {
                print("fetched form CD:",data.value(forKey: "email") as! String)
                resss=true
            }
        } catch {
            print("Failed")
        }
        return resss
    }
    
    static func saveOnCoreData(email:String) {
        //create new 'users' record
        let users = Users(context: CoreDataService.context)
        //Set values for the records for each key
        users.setValue(email, forKey: "email")
        print("CD:value ",email," saved")
        if !CoreDataService.saveContext(){
            print("data not saved")
        }
    }
    
    // MARK: - Core Data Saving support
    //added boolean return
    static func saveContext() -> Bool {
        var res:Bool = false
        let context = CoreDataService.context
        if context.hasChanges {
            do {
                try context.save()
                res = true
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        return res
    }
    
    // MARK: - Core Data Delete Codes
    static func deleteAllCodesRecords() {
        let context = persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchReq)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("CD:fetch request deleted")
        } catch {
            print ("Error deleting fetch req")
        }
    }
    
    

}
