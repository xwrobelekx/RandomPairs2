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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

   
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
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


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
        
        //shuffle players
    }
    
    
    func convertToDoubleArray(){
        pairs = RandomPairController.shared.splitInPairs(array: RandomPairController.shared.people)
    }
    
    func calculateIndex(index: IndexPath) -> Int {
        print("❌ \(((index.section * 2) + index.row))")
        return ((index.section * 2) + index.row)
    }
    
}
