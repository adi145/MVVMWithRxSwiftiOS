//
//  CarsDateFormatter.swift
//  SevenPeaksTask
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import Foundation

/**
 This enum used to return date formats string base on condition
 */
enum CarsDateFormatter{
    static let dateFromApi = "dd.MM.yyyy HH:mm"
    static let sameYearFormat = "dd MMMM"
    static let differentYearFormat = "dd MMMM yyyy"
    static let diviceSettingTime = "jj:mm"
}
