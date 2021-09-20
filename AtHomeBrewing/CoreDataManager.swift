//
//  CoreDataManager.swift
//  AtHomeBrewing
//
//  Created by Ryan Helgeson on 9/16/21.
//

import UIKit
import CoreData

public class CoreDataManager {
    static let shared = CoreDataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
}
