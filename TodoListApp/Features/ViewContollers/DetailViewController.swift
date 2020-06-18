//
//  DetailViewController.swift
//  TodoListApp
//
//  Created by Valeryia Beizer on 6/14/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  // MARK: - Variables
  private let edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 85, left: 10, bottom: 10, right: 10)
  private let textSize: CGFloat = 18
  var model: [TDLModel]?
  var task: TDLModel?
  var indexOfItem: Int = 0
  var delegate: TaskDelegate?
  
  // MARK: - GUI Variables
  private (set) lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(named: Localization.customColor.rawValue)
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  private (set) lazy var taskName: UILabel = {
    let label = UILabel()
    label.text = Localization.taskName.rawValue
    label.textAlignment = .left
    label.font = UIFont(name: Localization.font.rawValue, size: self.textSize)
    label.textColor = .darkGray
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private (set) lazy var descriptionName: UILabel = {
    let label = UILabel()
    label.text = Localization.descriptionName.rawValue
    label.textAlignment = .left
    label.font = UIFont(name: Localization.font.rawValue, size: self.textSize)
    label.textColor = .darkGray
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private (set) lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.text = Localization.dateLabel.rawValue
    label.textAlignment = .left
    label.font = UIFont(name: Localization.font.rawValue, size: self.textSize)
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
    textField.placeholder = Localization.taskPlaceholder.rawValue
    textField.font = UIFont(name: Localization.font.rawValue, size: self.textSize)
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
    textField.placeholder = Localization.descriptionPlaceholder.rawValue
    textField.font = UIFont(name: Localization.font.rawValue, size: self.textSize)
    textField.contentVerticalAlignment = .bottom
    textField.textColor = .darkGray
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
  }()
  
  private (set) lazy var dateTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .systemGray6
    textField.borderStyle = .none
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.placeholder = Localization.datePlaceholder.rawValue
    textField.font = UIFont(name: Localization.font.rawValue, size: self.textSize)
    textField.contentVerticalAlignment = .bottom
    textField.textColor = .darkGray
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    return textField
  }()
  
  private (set) lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .date
    datePicker.setDate(Date(), animated: true)
    datePicker.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
    
    return datePicker
  }()
  
  private (set) lazy var toolBar: UIToolbar = {
    let toolBar = UIToolbar()
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                     target: self,
                                     action: #selector(self.doneAction))
    let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                    target: self,
                                    action: nil)
    toolBar.setItems([flexSpace, doneButton], animated: true)
    toolBar.sizeToFit()
    
    return toolBar
  }()
  
  //  MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = Localization.detailViewControllerTitle.rawValue
    self.view.backgroundColor = .systemGray5
    self.view.addSubview(self.containerView)
    self.containerView.addSubview(self.taskName)
    self.containerView.addSubview(self.descriptionName)
    self.containerView.addSubview(self.dateLabel)
    self.containerView.addSubview(self.taskTextField)
    self.containerView.addSubview(self.descriptionTextField)
    self.containerView.addSubview(self.dateTextField)
    self.dateTextField.inputView = datePicker
    self.dateTextField.inputAccessoryView = toolBar
    
    self.setUpNavigationBar()
    self.setUpConstraints()
  }
  
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
    
    self.dateLabel.topAnchor.constraint(equalTo: self.descriptionName.bottomAnchor, constant: 20).isActive = true
    self.dateLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 20).isActive = true
    self.dateLabel.rightAnchor.constraint(lessThanOrEqualTo: self.containerView.rightAnchor, constant: -100).isActive = true
    self.dateLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    self.taskTextField.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 16).isActive = true
    self.taskTextField.leftAnchor.constraint(equalTo: self.taskName.rightAnchor, constant: 10).isActive = true
    self.taskTextField.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -10).isActive = true
    self.taskTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
    
    self.descriptionTextField.topAnchor.constraint(equalTo: self.taskTextField.bottomAnchor, constant: 16).isActive = true
    self.descriptionTextField.leftAnchor.constraint(equalTo: self.descriptionName.rightAnchor, constant: 10).isActive = true
    self.descriptionTextField.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -10).isActive = true
    self.descriptionTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
    
    self.dateTextField.topAnchor.constraint(equalTo: self.descriptionTextField.bottomAnchor, constant: 16).isActive = true
    self.dateTextField.leftAnchor.constraint(equalTo: self.dateLabel.rightAnchor, constant: 10).isActive = true
    self.dateTextField.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -10).isActive = true
    self.dateTextField.heightAnchor.constraint(equalToConstant: 25).isActive = true
  }
  
  // MARK: - Actions
  @objc private func saveData() {
    let newTask = TDLModel(taskName: self.taskTextField.text,
                           taskDescription: self.descriptionTextField.text,
                           date: self.dateTextField.text)
    
    if self.model == nil {
      self.model = []
    }
    
    if task == nil {
      self.model?.insert(newTask, at: 0)
    } else {
      self.model?[self.indexOfItem] = newTask
    }
    
    delegate?.updateModelWith(data: self.model)
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc private func doneAction() {
    self.getDateFromPicker()
    self.view.endEditing(true)
  }

  // MARK: - Methods
  private func setUpNavigationBar() {
    let save = UIBarButtonItem(barButtonSystemItem: .save,
                               target: self,
                               action: #selector(self.saveData))
    self.navigationItem.rightBarButtonItem = save
  }
  
  private func getDateFromPicker() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = Localization.dateFormat.rawValue
    dateTextField.text = dateFormatter.string(from: datePicker.date)
  }
}
