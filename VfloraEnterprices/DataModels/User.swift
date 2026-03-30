//
//  User.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 13/03/26.
//


struct User: Codable, Equatable {
    enum LoginStatus: Codable {
        case notLoggedIn, loggedIn, signup
    }
    
    var firstName: String
    var lastName: String
    var fullName: String { "\(firstName) \(lastName)" }
    var profilePicture: String?
    var loginStatus: LoginStatus = .notLoggedIn
    var email: String
    var designation: String
    var phone: String
    var address: String
    
    static func empty() -> User {
        return User(
            firstName: "",
            lastName: "",
            profilePicture: nil,
            loginStatus: .notLoggedIn,
            email: "",
            designation: "",
            phone: "",
            address: ""
        )
    }
    
    func isEmpty() -> Bool {
        if firstName.isEmpty,
            lastName.isEmpty,
            profilePicture == nil,
           loginStatus == .notLoggedIn,
            email.isEmpty,
            designation.isEmpty,
            phone.isEmpty,
           address.isEmpty {
            return true
        } else {
            return false
        }
    }
}
