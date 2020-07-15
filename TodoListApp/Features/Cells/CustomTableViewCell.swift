//
//  MyTableViewCell.swift
//  TodoListApp
//
//  Created by Valeryia Beizer on 6/16/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
  // MARK: - Variables
  static let reuseIdentifier: String = "CustomTableViewCell"
  
  private let edgeInsets = UIEdgeInsets(all: 20)
  private let contentEdgeInsets = UIEdgeInsets(all: 10)
  private let radius: CGFloat = 10
  private let sizeOfTitle: CGFloat = 20
  private let fontSize: CGFloat = 15
  
  // MARK: - GUI Variables
  private (set) lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    
    return view
  }()
  
  private (set) lazy var taskTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Apple SD Gothic Neo", size: self.fontSize)
    label.textColor = .black
    label.numberOfLines = 0
    
    return label
  }()
  
  private (set) lazy var taskDescription: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont(name: "Apple SD Gothic Neo", size: self.fontSize)
    label.textColor = .darkGray
    
    return label
  }()
  
  private (set) lazy var taskDate: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: "Apple SD Gothic Neo", size: self.fontSize)
    
    return label
  }()
  
  // MARK: - Initialization
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.initView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func initView() {
    self.setUpContainerView()
    
    self.containerView.addSubview(self.taskTitle)
    self.containerView.addSubview(self.taskDescription)
    self.containerView.addSubview(self.taskDate)
    
    self.setUpConstraints()
  }
  
  // MARK: - Constraints
  private func setUpConstraints() {
    self.containerView.snp.makeConstraints { (make) in
      make.top.left.right.bottom.equalToSuperview().inset(self.contentEdgeInsets)
    }
    self.taskTitle.snp.contentCompressionResistanceHorizontalPriority = 1000
    self.taskTitle.snp.makeConstraints { (make) in
      make.left.top.equalToSuperview().inset(self.edgeInsets)
      make.right.equalTo(self.containerView.snp.right).inset(10)
    }
    self.taskDescription.snp.contentCompressionResistanceHorizontalPriority = 250
    self.taskDescription.snp.makeConstraints { (make) in
      make.top.equalTo(self.taskTitle.snp.bottom).offset(self.edgeInsets.top)
      make.left.bottom.equalToSuperview().inset(self.edgeInsets)
    }
    self.taskDate.snp.makeConstraints { (make) in
      make.top.greaterThanOrEqualTo(self.taskDescription.snp.top)
      make.left.greaterThanOrEqualTo(self.taskDescription.snp.right).offset(10)
      make.right.equalToSuperview().inset(self.edgeInsets)
      make.bottom.equalToSuperview().inset(self.edgeInsets)
    }
  }
  
  // MARK: - Methods
  private func setUpContainerView() {
    self.contentView.addSubview(self.containerView)
    
    self.containerView.layer.shadowOffset = CGSize(width: 1, height: 1)
    self.containerView.layer.shadowRadius = self.radius
    self.containerView.layer.shadowColor = UIColor.gray.cgColor
    self.containerView.layer.shadowOpacity = 1
    self.containerView.layer.masksToBounds = false
    
    self.containerView.layer.cornerRadius = self.radius
    self.containerView.layer.borderWidth = 1
    self.containerView.layer.borderColor = UIColor.systemBlue.cgColor
  }
  
  // MARK: - Setter
  func setUpCell(task: TDLModel) {
    self.taskTitle.text = task.taskName
    self.taskDescription.text = task.taskDescription
    self.taskDate.text = task.date
    
    self.setNeedsUpdateConstraints()
  }
}
