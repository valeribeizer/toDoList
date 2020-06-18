//
//  TodoListViewController.swift
//  TodoListApp
//
//  Created by Valeryia Beizer on 6/16/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit

protocol TaskDelegate {
  func updateModelWith(data model: [TDLModel]?)
}

class TableViewController: UIViewController {
  // MARK: - Variables
  private var toDoItems: [TDLModel]? {
    set {
      if let data = try? JSONEncoder().encode(newValue) {
        UserDefaults.standard.set(data, forKey: Localization.key.rawValue)
        UserDefaults.standard.synchronize()
      }
    }
    get {
      if let data = UserDefaults.standard.data(forKey: Localization.key.rawValue),
        let model = try? JSONDecoder().decode([TDLModel]?.self, from: data) {
        self.toDoItems = model
        return model
      } else {
        return []
      }
    }
  }
  
  // MARK: - GUI Variables
  private (set) lazy var tableView: UITableView = {
    let table = UITableView()
    table.delegate = self
    table.dataSource = self
    table.register(CustomTableViewCell.self,
                   forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
    table.separatorStyle = .singleLine
    table.tableFooterView = UIView()
    table.translatesAutoresizingMaskIntoConstraints = false
    
    return table
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = Localization.tableViewControllerTitle.rawValue
    self.view.addSubview(self.tableView)
    
    self.setUpNavigationBar()
    self.setUpConstraints()
  }
  
  // MARK: - Constraints
  private func setUpConstraints() {
    NSLayoutConstraint.activate([
      self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
      self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
      self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
      self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
    ])
  }
  
  // MARK: - Methods
  @objc private func addToModel() {
    let viewController = DetailViewController()
    viewController.delegate = self
    viewController.model = toDoItems
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  private func removeFromModel(at index: Int) {
    self.toDoItems?.remove(at: index)
  }
  
  private func setUpNavigationBar() {
    self.navigationItem.rightBarButtonItem = self.editButtonItem
    let add = UIBarButtonItem(barButtonSystemItem: .add,
                              target: self,
                              action: #selector(self.addToModel))
    self.navigationItem.rightBarButtonItems = [self.editButtonItem, add]
  }
}

  // MARK: - UITableViewDelegate, UITableViewDataSource
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
    (cell as? CustomTableViewCell)?.set(
      title: Localization.customCellTitle.rawValue,
      description: Localization.customCellDescription.rawValue,
      date: Localization.customCellDate.rawValue)
    cell.selectionStyle = .none
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewController = DetailViewController()
    viewController.delegate = self
    viewController.model = self.toDoItems
    viewController.task = self.toDoItems?[indexPath.row]
    viewController.indexOfItem = indexPath.row
    self.navigationController?.pushViewController(viewController, animated: true)
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

extension TableViewController: TaskDelegate {
  func updateModelWith(data model: [TDLModel]?) {
    self.toDoItems = model
    self.tableView.reloadData()
  }
}
