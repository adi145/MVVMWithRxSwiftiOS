//
//  CarsModel.swift
//  SevenPeaksTask
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import Foundation

/**
 * Cars:
 *
 * Cars Details Model
 */
struct Cars: Codable {
    var content: [CarContent]?
}

struct CarContent: Codable {
    var id: Double?
    var title, dateTime: String?
    var ingress: String?
    var image: String?
    var created, changed: Double?
}

struct CarsDisplayViewModel:Equatable{
    var id: Double!
    var title: String!
    var dateTime: String!
    var ingress: String!
    var imageUrl: String!
}

struct ErrorViewModel {
    var title: String?
    var message: String?
}
