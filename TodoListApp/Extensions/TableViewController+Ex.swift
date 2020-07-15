//
//  TableViewController+Ex.swift
//  ToDoListApp
//
//  Created by Valeryia Beizer on 7/15/20.
//  Copyright © 2020 Igor Novoseltsev. All rights reserved.
//

import UIKit

extension TableViewController: TaskDelegate {
  func updateModelWith(data model: [TDLModel]?) {
    self.toDoItems = model
    self.tableView.reloadData()
  }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    self.tableView.setEditing(self.tableView.isEditing ? false : true, animated: true)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    self.toDoItems?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = self.tableView.dequeueReusableCell(
      withIdentifier: CustomTableViewCell.reuseIdentifier,
      for: indexPath)
    guard let task = self.toDoItems?[indexPath.row] else { return cell }
    (cell as? CustomTableViewCell)?.setUpCell(task: task)
    cell.selectionStyle = .none
    
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      self.toDoItems?.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
      
    }
  }
  
  func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
    true
  }
  
  func tableView(_ tableView: UITableView,
                 moveRowAt sourceIndexPath: IndexPath,
                 to destinationIndexPath: IndexPath) {
    self.toDoItems?.swapAt(sourceIndexPath.row, destinationIndexPath.row)
  }
}

