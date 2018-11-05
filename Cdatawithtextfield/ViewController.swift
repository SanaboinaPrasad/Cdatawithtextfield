//
//  ViewController.swift
//  Cdatawithtextfield
//
//  Created by Sriram Prasad on 05/11/18.
//  Copyright © 2018 FullStackNet. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UITableViewController {
    var namesArray = [NSManagedObject]()
    let cellId = "cell"
    let appdelegate = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
tableView.backgroundColor = .red
        navigationItem.title = "ADD Names "
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(alertContoller))
        navigationItem.rightBarButtonItem = addButton
        
     tableView.register(Datacell.self, forCellReuseIdentifier: cellId)
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ListArrray")
        do {
            namesArray = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
        }
        catch let err as NSError
        {
            print(err.localizedDescription)
        }
    }
   override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return namesArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
let cell  = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)as! Datacell
        let names = namesArray[indexPath.row]
        cell.textLabel?.text = names.value(forKey: "names") as! String
        
        return cell
    }

    private func save(enteredText: String){
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let managesContext = appdelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ListArrray", in: managesContext)
        let items = NSManagedObject(entity: entity!, insertInto: managesContext)
        items.setValue(enteredText, forKey: "names")
         do {
            try  managesContext.save()
            namesArray.append(items)
        }
         catch var error as NSError {
            print(error.localizedDescription)
        }
        
    }


    @objc func alertContoller(){
    let alert = UIAlertController(title: "Alert", message: "Enter the name", preferredStyle: .alert)
    let saveaction = UIAlertAction(title: "Save", style: .default) { (_) in
     let textField =  alert.textFields?.first
        let textIems = textField?.text
        self.save(enteredText: textIems!)
//        self.namesArray.append(textIems)
        self.tableView.reloadData()
        
    }
    let cancelButton = UIAlertAction(title: "Cncel", style: .cancel, handler: nil)
    
    alert.addAction(saveaction)
    alert.addAction(cancelButton)
    alert.addTextField(configurationHandler: nil)
    present(alert, animated: true, completion: nil)
    }



}
class Datacell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .green
    }
}
