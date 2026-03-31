//
//  LoginData.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 31/03/26.
//

struct LoginData {
    @ValidatedInput(rules: [ { $0.isEmpty ? "Please enter username" : nil },
                             { $0.count < 3 ? "Please enter valid username" : nil }
                           ])
    var username = ""
    
    @ValidatedInput(rules: [
        { $0.isEmpty ? "Please enter password" : nil }
    ])
    var password = ""
    
    var isEmpty: Bool { username.isEmpty && password.isEmpty }
    
}
