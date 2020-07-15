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
  private let greetingsLabelText = "Hello, darling!"
  private let font = "Apple SD Gothic Neo"
  private let imageName = "batmanIcon"
  
  // MARK: - GUI Variables
  private (set) lazy var label: UILabel = {
    let label = UILabel()
    label.text = self.greetingsLabelText
    label.font = UIFont(name: self.font, size: 20)
    label.textAlignment = .center
    label.numberOfLines = 0
    label.textColor = .white
    label.backgroundColor = .systemBlue
    label.layer.cornerRadius = 10
    label.layer.masksToBounds = true
    
    return label
  }()
  
  private (set) lazy var accountPhoto: UIImageView = {
    let image = UIImageView()
    image.image = UIImage(named: self.imageName)
    image.contentMode = .scaleAspectFill
    image.layer.masksToBounds = true
    image.layer.cornerRadius = 40
    
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
    self.label.snp.makeConstraints { (make) in
      make.top.equalTo(self.accountPhoto.snp.bottom).offset(50)
      make.centerX.equalToSuperview()
      make.height.equalTo(50)
      make.width.equalTo(350)
    }
  }
}
