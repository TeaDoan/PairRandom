//
//  GroupTableViewController.swift
//  PairRandom
//
//  Created by Thao Doan on 6/22/18.
//  Copyright © 2018 Thao Doan. All rights reserved.
//

import UIKit
import CoreData

class GroupTableViewController: UITableViewController {
    let fetchRequestController : NSFetchedResultsController<Group> = {
        let internalFetchRequest : NSFetchRequest<Group> = Group.fetchRequest()
        internalFetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: false)]
        return NSFetchedResultsController(fetchRequest: internalFetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRequestController.delegate = self
        do {
            try fetchRequestController.performFetch()
        } catch let error {
            print("Error fetching from fetch request controller: \(error.localizedDescription)")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let sections = fetchRequestController.sections else {
        return 0
    }
    let sectionInfo = sections[section]
//    return fetchRequestController.fetchedObjects?.count ?? 0
    return sectionInfo.numberOfObjects
   }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let nameAtIndex = fetchRequestController.object(at: indexPath)
        cell.textLabel?.text = nameAtIndex.name
        return cell
    }
//
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
        } else if editingStyle == .insert {
        }    
    }
    @IBAction func addButtonClick(_ sender: UIBarButtonItem) {
        addNameNotification()
        
    }
}
extension GroupTableViewController : NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        case .move: return
        }
    }
}
extension GroupTableViewController {
    func addNameNotification() {
        let notification = UIAlertController(title: "Add person", message: "Add someone new to the list", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let textField = notification.textFields!.first,
            let nameToSave = textField.text, !nameToSave.isEmpty else {return}
            GroupModelController.shared.add(name: nameToSave, title: "Group")
            }
        notification.addTextField { (textField) in
            textField.placeholder = "Enter your name"
            textField.textColor = .blue
        }
        notification.addAction(cancelAction)
        notification.addAction(action)
        self.present(notification,animated: true, completion: nil)
    }
}
