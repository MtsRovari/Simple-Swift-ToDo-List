//
//  Task.swift
//  Taskly
//
//  Created by Mateus Rovari on 18/03/19.
//  Copyright © 2019 Mateus Rovari. All rights reserved.
//

import Foundation

class Task {
    
    var name: String
    var isDone: Bool
    
    init(name: String, isDone: Bool = false) {
        self.name = name
        self.isDone = isDone
    }
    
}
 
