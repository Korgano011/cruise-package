//
//  ContentView.swift
//  cruises
//
//  Created by Thomas Daly on 7/5/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path = [Activity]()
    @Query var activities: [Activity]
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                List {
                    ForEach(activities) { activity in
                        NavigationLink(value: activity) {
                            VStack(alignment: .leading) {
                                Text(activity.activity)
                                    .font(.headline)
                                Text(activity.date.formatted(date: .long, time: .omitted))
                            }
                        }
                    }
                    .onDelete(perform: deleteActivities)
                }
                .navigationTitle("Cruise Activities")
                .navigationDestination(for: Activity.self) { activity in
                    EditActivityView(activity: activity)
                }
                .toolbar {
                    
                        
                        Button("Add day at sea", action: addDayAtSea)
                        
                        Spacer()
                        
                        Button("Add other activity", action: addOtherActivity)
                        Divider()
                            
                    
                }
            }
        }
    }
        func addDayAtSea() {
            let dayasea = Activity(
                activity: "Day at sea",
                speins: "No special instructions necessary",
                date: .now,
                percau: false
            )
            
            modelContext.insert(dayasea)
            path = [dayasea]
        }
               func addOtherActivity() {
            let otheractivity = Activity(
                    activity: "",
                    speins: "Type special instructions here",
                    date: .now,
                    percau: true
                   )
                   
                   modelContext.insert(otheractivity)
                   path = [otheractivity]
        }
         func deleteActivities(_ indexSet: IndexSet) {
             for index in indexSet {
                 let activity = activities[index]
                 modelContext.delete(activity)
             }
        }
                
            }
        
    

#Preview {
    ContentView()
}
