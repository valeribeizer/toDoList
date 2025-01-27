//
//  ViewController.swift
//  TodoListApp
//
//  Created by Valeryia Beizer on 6/16/20.
//  Copyright © 2020 Valeryia Beizer. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {
  // MARK: - Variables
  private let navigationItemTitle = "Welcome"
  private let buttonTitle = "Continue"
  
  // MARK: - GUI Variables
  private (set) lazy var customView: GreetingsView = {
    let view = GreetingsView()
    view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
    
    return view
  }()
  
  private (set) lazy var continueButton: UIButton = {
    let button = UIButton()
    button.setTitle(self.buttonTitle, for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .darkGray
    button.layer.cornerRadius = 10
    button.layer.masksToBounds = true
    button.addTarget(self,
                     action: #selector(self.continueButtonPressed),
                     for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    
    return button
  }()
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationItem.title = self.navigationItemTitle
    self.view.backgroundColor = .systemGray5
    self.view.addSubview(self.customView)
    self.view.addSubview(self.continueButton)
    self.setUpConstraints()
  }
  
  // MARK: - Constraints
  private func setUpConstraints() {
    self.continueButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
    self.continueButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
    self.continueButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
    self.continueButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    self.customView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 80).isActive = true
    self.customView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
    self.customView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -20).isActive = true
    self.customView.bottomAnchor.constraint(equalTo: self.continueButton.topAnchor, constant: -20).isActive = true
  }
  
  // MARK: - Actions
  @objc private func continueButtonPressed() {
    let viewContriller = TableViewController()
    self.navigationController?.pushViewController(viewContriller, animated: true)
  }
}

