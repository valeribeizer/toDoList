//
//  GreetingsView.swift
//  TodoListApp
//
//  Created by Valeryia Beizer on 6/16/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit
import SnapKit

class GreetingsView: UIView {
  
  // MARK: - Variables
  private let edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 150, right: 20)
  
  // MARK: - GUI Variables
  private (set) lazy var label: UILabel = {
    let label = UILabel()
    label.text = "Hello, Flash!"
    label.font = UIFont(name: "Apple SD Gothic Neo", size: 20)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = .yellow
    label.backgroundColor = .red
    label.translatesAutoresizingMaskIntoConstraints = false
     
    return label
  }()
  
  private (set) lazy var accountPhoto: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: "flashIcon")
    image.contentMode = .scaleAspectFill
    image.layer.masksToBounds = true
    image.layer.cornerRadius = 40 
    image.translatesAutoresizingMaskIntoConstraints = false

    return image
  }()


  // MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.initView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func initView() {
    self.addSubview(self.label)
    self.addSubview(self.accountPhoto)
    
    self.constraints()
  }
  
  // MARK: - Constraints
  private func constraints() {
    self.accountPhoto.snp.makeConstraints { (make) in
      make.edges.equalToSuperview().inset(self.edgeInsets)
    }
    
    self.label.topAnchor.constraint(equalTo: self.accountPhoto.bottomAnchor, constant: 50).isActive = true
    self.label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
    self.label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
    self.label.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
}
