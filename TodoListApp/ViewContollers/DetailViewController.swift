//
//  DetailViewController.swift
//  TodoListApp
//
//  Created by Valeryia Beizer on 6/14/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
//  MARK: - Variables
  private let edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 85, left: 10, bottom: 10, right: 10)
//  private var dataModel: TDModel?
  
//  MARK: - GUI Variables
  private (set) lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(named: "lightYellow")
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  private (set) lazy var taskName: UILabel = {
    let label = UILabel()
    label.text = "TASK:"
    label.textAlignment = .left
    label.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
    label.textColor = .darkGray
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private (set) lazy var descriptionName: UILabel = {
     let label = UILabel()
     label.text = "DESCRIPTION:"
     label.textAlignment = .left
     label.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
     label.textColor = .darkGray
     label.translatesAutoresizingMaskIntoConstraints = false
     
     return label
   }()
  
  private (set) lazy var taskTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .systemGray6
    textField.borderStyle = .none
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.placeholder = "Enter the task"
    textField.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
    textField.contentVerticalAlignment = .bottom
    textField.textColor = .darkGray
    
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
  }()
  
  private (set) lazy var descriptionTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .systemGray6
    textField.borderStyle = .none
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.placeholder = "Description here"
    textField.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
    textField.contentVerticalAlignment = .bottom
    textField.textColor = .darkGray
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
  }()
  
  private lazy var datePicker: UIDatePicker = {
      let datePicker = UIDatePicker()
      datePicker.datePickerMode = .dateAndTime
      datePicker.setDate(Date(), animated: true)
      datePicker.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
      datePicker.layer.cornerRadius = 20
      return datePicker
  }()
//  MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = .systemGray5
    self.view.addSubview(self.containerView)
    self.containerView.addSubview(self.taskName)
    self.containerView.addSubview(self.descriptionName)
    self.containerView.addSubview(self.taskTextField)
    self.containerView.addSubview(self.descriptionTextField)
    self.containerView.addSubview(self.datePicker)
//    self.dataModel = TDModel(taskTextField: "", descriptionTextField: "")
    
    self.setUpNavigationBar()
    self.setUpConstraints()
  }
  // MARK: - Actions
  @objc private func saveData() {
//    self.archievingToUDWithNSCoding()
  }
  
  // MARK: - Methods
  private func setUpNavigationBar() {
    let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(self.saveData))
    self.navigationItem.rightBarButtonItem = save
  }
  
//  @discardableResult
//   private func archievingToUDWithNSCoding() -> Bool {
//     if let model = self.dataModel {
//       do {
//         print("archiveWithNSCoding -> \(model.taskTextField)")
//         print("archiveWithNSCoding -> \(model.descriptionTextField)")
//
//         let data = try NSKeyedArchiver.archivedData(withRootObject: model, requiringSecureCoding: false)
//         UserDefaults.standard.set (data, forKey: "user")
//         return true
//       } catch {
//         print("Archieving error")
//       }
//       return false
//     }
//     return false
//   }
//
//   private func unarchievingFromUDWithNSCoding() -> TDModel? {
//     if let data = UserDefaults.standard.data(forKey: "user") {
//       do {
//         let profile = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? TDModel
//         return profile
//       } catch {
//         print("Unarchiving error")
//       }
//       return nil
//     }
//     return nil
//   }
  //  MARK: - Constraints
  private func setUpConstraints() {
    self.containerView.snp.makeConstraints { (make) in
      make.edges.equalToSuperview().inset(self.edgeInsets)
    }
    
    self.taskName.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 20).isActive = true
    self.taskName.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 20).isActive = true
    self.taskName.rightAnchor.constraint(lessThanOrEqualTo: self.containerView.rightAnchor, constant: -90).isActive = true
    self.taskName.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    self.descriptionName.topAnchor.constraint(equalTo: self.taskName.bottomAnchor, constant: 20).isActive = true
    self.descriptionName.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 20).isActive = true
    self.descriptionName.rightAnchor.constraint(lessThanOrEqualTo: self.containerView.rightAnchor, constant: -100).isActive = true
    self.descriptionName.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    self.taskTextField.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16).isActive = true
    self.taskTextField.leftAnchor.constraint(equalTo: self.taskName.rightAnchor, constant: 10).isActive = true
    self.taskTextField.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -10).isActive = true
    self.taskTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
    
    self.descriptionTextField.topAnchor.constraint(equalTo: self.taskTextField.bottomAnchor, constant: 16).isActive = true
    self.descriptionTextField.leftAnchor.constraint(equalTo: self.descriptionName.rightAnchor, constant: 10).isActive = true
    self.descriptionTextField.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -10).isActive = true
    self.descriptionTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
    
    
    self.datePicker.topAnchor.constraint(equalTo: self.descriptionTextField.bottomAnchor, constant: 20).isActive = true
    self.datePicker.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 10).isActive = true
    self.datePicker.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -10).isActive = true
    self.datePicker.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10).isActive = true
  }
}
