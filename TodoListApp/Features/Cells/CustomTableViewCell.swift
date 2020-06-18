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
  private let edgeInsets = UIEdgeInsets(all: 20)
  private let contentEdgeInsets = UIEdgeInsets(all: 10)
  private let radius: CGFloat = 10
  private let sizeOfTitle: CGFloat = 20
  private let fontSize: CGFloat = 15
  
  static let reuseIdentifier: String = "CustomTableViewCell"
  
  // MARK: - GUI Variables
  private (set) lazy var containerView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(named: Localization.customColor.rawValue)
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  private (set) lazy var taskTitle: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Localization.font.rawValue, size: self.sizeOfTitle)
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private (set) lazy var taskDescription: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = UIFont(name: Localization.font.rawValue, size: self.fontSize)
    label.textColor = .darkGray
    label.translatesAutoresizingMaskIntoConstraints = false
    
    return label
  }()
  
  private (set) lazy var taskDate: UILabel = {
    let label = UILabel()
    label.font = UIFont(name: Localization.font.rawValue, size: self.fontSize)
    label.translatesAutoresizingMaskIntoConstraints = false
    
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
    self.containerView.snp.updateConstraints { (make) in
      make.top.equalToSuperview().inset(40)
      make.left.right.bottom.equalToSuperview().inset(self.edgeInsets)
    }
    
    self.taskTitle.snp.updateConstraints { (make) in
      make.top.left.equalToSuperview().inset(self.contentEdgeInsets)
    }
    
    self.taskDescription.snp.updateConstraints { (make) in
      make.top.equalTo(self.taskTitle.snp.bottom).offset(10)
      make.left.equalToSuperview().inset(self.contentEdgeInsets)
    }
    
    self.taskDate.snp.updateConstraints { (make) in
      make.top.equalTo(self.taskDescription.snp.bottom).offset(10)
      make.left.bottom.equalToSuperview().inset(self.contentEdgeInsets)
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
    self.containerView.layer.borderColor = UIColor.systemYellow.cgColor
  }
  
  // MARK: - Setter
  func set(title: String, description: String, date: String) {
    self.taskTitle.text = title
    self.taskDescription.text = description
    self.taskDate.text = date
    
    self.setNeedsUpdateConstraints()
  }
}
