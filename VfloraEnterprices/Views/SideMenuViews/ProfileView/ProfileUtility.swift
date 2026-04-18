//
//  ProfileUtility.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 18/04/26.
//

enum ProfileField {
    case firstname, lastname, designation, email, phone, address
}

enum ProfileMessages {
    case noChange, successfull, signupPending, signupSuccess, emailInvalid, phoneInvalid
    
    var title: String {
        switch self {
        case .noChange: return "No changes made"
        case .successfull: return "Profile updated successfully"
        case .signupPending: return "Profile Pending"
        case .signupSuccess: return "Profile updated successfully"
        case .emailInvalid: return "Email is invalid"
        case .phoneInvalid: return "Phone is invalid"
        }
    }
    
    var message: String {
        switch self {
        case .noChange: return "Please make changes to update your profile."
        case .successfull: return "Your profile has been updated successfully."
        case .signupPending: return "Please fill all fields to create your profile."
        case .signupSuccess: return "Hurry! Profile created successfully 🚀"
        case .emailInvalid: return "Please enter valid email"
        case .phoneInvalid: return "Please enter valid phone number"
        }
    }
}
