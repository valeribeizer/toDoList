//
//  DetailViewController.swift
//  TodoListApp
//
//  Created by Valeryia Beizer on 6/14/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {
  // MARK: - Variables
  private let edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 85, left: 10, bottom: 10, right: 10)
  private let textSize: CGFloat = 18
  private let detailViewControllerTitle = "Detail"
  private let taskNameLabel = "TASK:"
  private let descriptionNameLabel = "DESCRIPTION:"
  private let dateNameLabel = "DATE:"
  private let taskPlaceholder = "Enter the task"
  private let descriptionPlaceholder = "Description here"
  private let datePlaceholder = "Date here"
  private let dateFormat = "MMM d, h:mm a"
  var model: [TDLModel]?
  var task: TDLModel?
  var indexOfItem: Int = 0
  var delegate: TaskDelegate?
  
  // MARK: - GUI Variables
  private (set) lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
  }()
  
  private (set) lazy var taskName: UILabel = {
    let label = UILabel()
    label.text = self.taskNameLabel
    label.textAlignment = .left
    label.font = UIFont(name: "Apple SD Gothic Neo", size: self.textSize)
    label.textColor = .darkGray
    
    return label
  }()
  
  private (set) lazy var descriptionName: UILabel = {
    let label = UILabel()
    label.text = self.descriptionNameLabel
    label.textAlignment = .left
    label.font = UIFont(name: "Apple SD Gothic Neo", size: self.textSize)
    label.textColor = .darkGray
    
    return label
  }()
  
  private (set) lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.text = self.dateNameLabel
    label.textAlignment = .left
    label.font = UIFont(name: "Apple SD Gothic Neo", size: self.textSize)
    label.textColor = .darkGray
    
    return label
  }()
  
  private (set) lazy var taskTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .systemGray6
    textField.borderStyle = .none
    textField.layer.cornerRadius = 5
    textField.layer.borderWidth = 0.5
    textField.layer.borderColor = UIColor.systemBlue.cgColor
    textField.layer.masksToBounds = true
    textField.placeholder = self.taskPlaceholder
    textField.font = UIFont(name: "Apple SD Gothic Neo", size: self.textSize)
    textField.contentVerticalAlignment = .bottom
    textField.textColor = .darkGray
    
    return textField
  }()
  
  private (set) lazy var descriptionTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .systemGray6
    textField.borderStyle = .none
    textField.layer.cornerRadius = 5
    textField.layer.borderWidth = 0.5
    textField.layer.borderColor = UIColor.systemBlue.cgColor
    textField.layer.masksToBounds = true
    textField.placeholder = self.descriptionPlaceholder
    textField.font = UIFont(name: "Apple SD Gothic Neo", size: self.textSize)
    textField.contentVerticalAlignment = .bottom
    textField.textColor = .darkGray
    
    return textField
  }()
  
  private (set) lazy var dateTextField: UITextField = {
    let textField = UITextField()
    textField.backgroundColor = .systemGray6
    textField.borderStyle = .none
    textField.layer.cornerRadius = 5
    textField.layer.borderWidth = 0.5
    textField.layer.borderColor = UIColor.systemBlue.cgColor
    textField.layer.masksToBounds = true
    textField.placeholder = self.datePlaceholder
    textField.font = UIFont(name: "Apple SD Gothic Neo", size: self.textSize)
    textField.contentVerticalAlignment = .bottom
    textField.textColor = .darkGray
    
    return textField
  }()
  
  private (set) lazy var datePicker: UIDatePicker = {
    let datePicker = UIDatePicker()
    datePicker.datePickerMode = .dateAndTime
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
    
    self.navigationItem.title = self.detailViewControllerTitle
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
    self.taskName.snp.makeConstraints { (make) in
      make.top.equalTo(self.containerView.snp.top).offset(20)
      make.left.equalTo(self.containerView.snp.left).offset(20)
      make.width.equalTo(150)
      make.height.equalTo(20)
    }
    self.descriptionName.snp.makeConstraints { (make) in
      make.top.equalTo(self.taskName.snp.bottom).offset(20)
      make.left.equalTo(self.containerView.snp.left).inset(20)
      make.width.equalTo(150)
      make.height.equalTo(20)
    }
    self.dateLabel.snp.makeConstraints { (make) in
      make.top.equalTo(self.descriptionName.snp.bottom).offset(20)
      make.left.equalTo(self.containerView.snp.left).inset(20)
      make.width.equalTo(150)
      make.height.equalTo(20)
    }
    self.taskTextField.snp.makeConstraints { (make) in
      make.left.equalTo(self.taskName.snp.right).inset(10)
      make.right.equalTo(self.containerView.snp.right).inset(10)
      make.height.equalTo(25)
      make.centerY.equalTo(self.taskName)
    }
    self.descriptionTextField.snp.makeConstraints { (make) in
      make.left.equalTo(self.descriptionName.snp.right).inset(10)
      make.right.equalTo(self.containerView.snp.right).inset(10)
      make.height.equalTo(25)
      make.centerY.equalTo(self.descriptionName)
    }
    self.dateTextField.snp.makeConstraints { (make) in
      make.left.equalTo(self.dateLabel.snp.right).inset(10)
      make.right.equalTo(self.containerView.snp.right).inset(10)
      make.height.equalTo(25)
      make.centerY.equalTo(self.dateLabel)
    }
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
      delegate?.updateModelWith(data: self.model)
    } else {
      self.model?[self.indexOfItem] = newTask
    }
    
    self.navigationController?.popViewController(animated: true)
  }
  
  @objc private func doneAction() {
    self.getDateFromPicker()
    self.view.endEditing(true)
  }
  
  // MARK: - Methods
  func setTask(task: TDLModel) {
    self.taskTextField.text = task.taskName
    self.descriptionTextField.text = task.taskDescription
    self.dateTextField.text = task.date
  }
  
  private func setUpNavigationBar() {
    let save = UIBarButtonItem(barButtonSystemItem: .save,
                               target: self,
                               action: #selector(self.saveData))
    self.navigationItem.rightBarButtonItem = save
  }
  
  private func getDateFromPicker() {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = self.dateFormat
    dateTextField.text = dateFormatter.string(from: datePicker.date)
  }
}
