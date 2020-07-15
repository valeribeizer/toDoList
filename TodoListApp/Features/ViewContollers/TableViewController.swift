//
//  TodoListViewController.swift
//  TodoListApp
//
//  Created by Valeryia Beizer on 6/16/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit
import SnapKit

//  MARK: - Protocols
protocol TaskDelegate {
  func updateModelWith(data model: [TDLModel]?)
}

class TableViewController: UIViewController {
  // MARK: - Variables
  private let key = "item"
  private let tableViewControllerTitle = "To Do"
  
  var toDoItems: [TDLModel]? {
    set {
      if let data = try? JSONEncoder().encode(newValue) {
        UserDefaults.standard.set(data, forKey: key)
        UserDefaults.standard.synchronize()
      }
    }
    get {
      if let data = UserDefaults.standard.data(forKey: key),
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
    
    return table
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = self.tableViewControllerTitle
    self.view.addSubview(self.tableView)
    
    self.setUpConstraints()
    self.setUpNavigationBar()
  }
  
  // MARK: - Constraints
  private func setUpConstraints() {
    self.tableView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Actions
  @objc private func addToModel() {
    let viewController = DetailViewController()
    viewController.delegate = self
    viewController.model = toDoItems
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  
  // MARK: - Methods
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


