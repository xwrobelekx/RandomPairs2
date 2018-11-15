//
//  RandomPairsTableViewController.swift
//  RandomPairs2
//
//  Created by Kamil Wrobel on 11/15/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class RandomPairsTableViewController: UITableViewController {
    
    var pairs = [[String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        convertToDoubleArray()
 
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \(section + 1)"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return pairs.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pairs[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let person = pairs[indexPath.section][indexPath.row]
        cell.textLabel?.text = person
        return cell
    }
    

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let index = calculateIndex(index: indexPath)
            RandomPairController.shared.remove(at: index)
            convertToDoubleArray()
            tableView.reloadData()
        }
    }
    


    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (nameTextField) in
            nameTextField.placeholder = "Enter a name..."
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            guard let nameTextField = alert.textFields?.first else {return}
            guard let name = nameTextField.text, name != "" else {return}
            RandomPairController.shared.add(person: name)
            self.convertToDoubleArray()
            self.tableView.reloadData()
        }))
        present(alert, animated: true)
    }
    
    
    @IBAction func shuffleButtonTapped(_ sender: Any) {
        if RandomPairController.shared.people.count > 1{
            var temporaryArray = [String]()
        for number in 0...(RandomPairController.shared.people.count - 1) {
            
            let randomNumber : Int = Int(arc4random_uniform(UInt32(RandomPairController.shared.people.count)))
            let element = RandomPairController.shared.people.remove(at: randomNumber)
                temporaryArray.append(element)
        }
       RandomPairController.shared.people = temporaryArray
            convertToDoubleArray()
            tableView.reloadData()
        }
    }
    
    ///converts regular array into an array of arrays of pairs
    func convertToDoubleArray(){
        pairs = RandomPairController.shared.splitInPairs(array: RandomPairController.shared.people)
    }
    
    ///calculates index based on sections and rows
    func calculateIndex(index: IndexPath) -> Int {
        return ((index.section * 2) + index.row)
    }
    
}
