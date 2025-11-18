//
//  Activity.swift
//  cruises
//
//  Created by Thomas Daly on 7/5/25.
//

import Foundation
import SwiftData

@Model
class Activity {
    var activity: String
    var speins: String
    var date: Date
    var percau: Bool
    
    init(activity: String, speins: String, date: Date, percau: Bool) {
        self.activity = activity
        self.speins = speins
        self.date = date
        self.percau = percau
    }
}
