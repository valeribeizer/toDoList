//
//  TDModel.swift
//  TodoListApp
//
//  Created by Valeryia Beizer on 6/15/20.
//  Copyright © 2020 Igor Novoseltsev. All rights reserved.
//

import Foundation

class TDModel: NSObject, NSCoding {
  
  struct PropertyKey: Codable {
    static let taskTextField = "TaskTextField"
    static let descriptionTextField = "DescriptionTextField"
  }
  
  var taskTextField: String
  var descriptionTextField: String
  
  init(taskTextField: String, descriptionTextField: String) {
    self.taskTextField = taskTextField
    self.descriptionTextField = descriptionTextField
  }
  
  func encode(with coder: NSCoder) {
    coder.encode(self.taskTextField, forKey: PropertyKey.taskTextField)
    coder.encode(self.descriptionTextField, forKey: PropertyKey.descriptionTextField)
  }
  
  required init?(coder: NSCoder) {
    self.taskTextField = coder.decodeObject(forKey: PropertyKey.taskTextField) as! String
    self.descriptionTextField = coder.decodeObject(forKey: PropertyKey.descriptionTextField) as! String
  }
}
