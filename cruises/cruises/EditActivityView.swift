//
//  EditActivityView.swift
//  cruises
//
//  Created by Thomas Daly on 7/5/25.
//

import SwiftUI
import SwiftData

struct EditActivityView: View {
    @Bindable var activity: Activity
    var body: some View {
        Form {
            TextField("Activity", text: $activity.activity)
            TextField("Special instructions", text: $activity.speins, axis: .vertical)
            DatePicker("Date", selection: $activity.date)
            
            Section("Special instructions") {
                Picker("Special instructions", selection: $activity.speins) {
                    Text("No").tag(false)
                    Text("Yes").tag(true)
                }
                .pickerStyle(.segmented)
            }
        }
        .navigationTitle("Edit activity")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Activity.self, configurations: config)
        let example = Activity(activity: "Example activity", speins: "Place special instructions here and follow them carefully", date: .now, percau: true)
        return EditActivityView(activity: example)
            .modelContainer(container)
    } catch {
        fatalError("bruuuuuuuuu")
    }
}
