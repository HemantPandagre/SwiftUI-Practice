//
//  CategoriesEnum.swift
//  VfloraEnterprices
//
//  Created by Hemant Kumar Pandagre on 13/03/26.
//

enum CategoriesEnum: CaseIterable {
    case cars, bikes, Properties, Mobiles, Jobs, Electronics, Sports, Fashion, Books, Other
    
    var title: String {
        switch self {
        case .cars: return "Cars"
        case .bikes: return "Bikes"
        case .Properties: return "Properties"
        case .Mobiles: return "Mobiles"
        case .Jobs: return "Jobs"
        case .Electronics: return "Electronics"
        case .Sports: return "Sports"
        case .Fashion: return "Fashion"
        case .Books: return "Books"
        case .Other: return "Other"
        }
    }
    
    var imageName: String {
        switch self {
        case .cars: return "car"
        case .bikes: return "bicycle"
        case .Properties: return "house.fill"
        case .Mobiles: return "phone.pause.fill"
        case .Jobs: return "house.badge.wifi.fill"
        case .Electronics: return "lightbulb.led.fill"
        case .Sports: return "figure.disc.sports"
        case .Fashion: return "camera.shutter.button.fill"
        case .Books: return "camera.macro"
        case .Other: return "arrowshape.right.fill"
        }
    }
}
