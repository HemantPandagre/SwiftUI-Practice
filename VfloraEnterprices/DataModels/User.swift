//
//  User.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 13/03/26.
//


struct User: Codable {
    enum LoginStatus: Codable {
        case notLoggedIn, loggedIn, signup
    }
    var userId: String
    var firstName: String
    var lastName: String
    var fullName: String { "\(firstName) \(lastName)" }
    var profilePicture: String?
    var loginStatus: LoginStatus = .notLoggedIn
    @Email var email: String
    var designation: String
    @Phone var phone: String
    var address: String
     
    init(
        userId: String = "",
        firstName: String = "",
        lastName: String = "",
        profilePicture: String? = nil,
        loginStatus: LoginStatus = .notLoggedIn,
        email: String = "",
        designation: String = "",
        phone: String = "",
        address: String = ""
    ) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.profilePicture = profilePicture
        self.loginStatus = loginStatus
        self.designation = designation
        self.address = address
        self._email = Email(email)
        self._phone = Phone(phone)
    }
    
    mutating func setDummyData() {
        self.userId = "123456789"
        self.firstName = "Hemant"
        self.lastName = "Pandagre"
        self.profilePicture = "https://avatars.githubusercontent.com/u/400000?s=200&v=4"
        self.designation = "Senior iOS Developer"
        self.address = "Ulwe, navi mumbai, 410206"
        self._email = Email("hemant@gmail.com")
        self._phone = Phone("99269-90876")
                        
    }
    
    func isEmpty() -> Bool {
        if userId.isEmpty,
           firstName.isEmpty,
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

extension User: Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.userId == rhs.userId &&
        lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.profilePicture == rhs.profilePicture &&
        lhs.loginStatus == rhs.loginStatus &&
        lhs.email == rhs.email &&
        lhs.designation == rhs.designation &&
        lhs.phone == rhs.phone &&
        lhs.address == rhs.address
    }
}
