//
//  SignUpModel.swift
//  Project_SqlLite
//
//  Created by Tanmay N Gandhi on 25/07/24.
//

import Foundation

struct SignUpModel {
    
    let email: String
    let name: String
 
    init(email: String, name: String) {
            self.email = email
            self.name = name
        }
}

enum SignUpError: Error {
        case emailExists
        case saveFailed
    }
