//
//  LoginData.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 31/03/26.
//

import Foundation

struct LoginCredentials {
    @Username var username
    @Password var password
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    var isEmpty: Bool { username.isEmpty && password.isEmpty }
}
