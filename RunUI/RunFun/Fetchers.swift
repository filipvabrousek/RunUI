//
//  Fetchers.swift
//  RunFun
//
//  Created by Filip Vabroušek on 30/06/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import UIKit
import CoreData


class Saver {
    
    var ename: String
    var key: String
    var obj: Run
    init(ename: String, key: String, obj: Run){
        self.ename = ename
        self.key = key
        self.obj = obj
    }
    
    
    func save(){
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: ename, in: context)
        let device = NSManagedObject(entity: entity!, insertInto: context)
        
        
        device.setValue(obj, forKey: key)
        
        do {
            try context.save()
        }
        catch {
            // sth went wrong
        }
    }
}


class Fetcher {
    var ename: String
    var key: String
    init(ename: String, key: String){
        self.ename = ename
        self.key = key
    }
    
    func fetchR() -> [Run] {
        
        var runs = [Run]()
        runs.removeAll()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: ename)
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            
            if results.count > 0 {
                for res in results as! [NSManagedObject]{
                    if let run = res.value(forKey: key) as? Run {
                        runs.append(run)
                    }
                    
                }
            }
            
        }
            
        catch {
            print("Error")
        }
        
        return runs
    }
    
}

