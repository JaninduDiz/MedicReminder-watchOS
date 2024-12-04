//
//  AddMedicationView.swift
//  MedicReminder Watch App
//
//  Created by Janindu Dissanayake on 2024-06-11.
//

import SwiftUI
import UserNotifications

struct AddMedicationView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var medications: [Medication]
    @State private var name = ""
    @State private var time = Date()
    @State private var repeatOption: RepeatOption = .none
    
    enum RepeatOption: String, CaseIterable {
        case none = "None"
        case hourly = "Hourly"
        case daily = "Daily"
        case custom = "Custom"
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Medication Details")) {
                    TextField("Medication Name", text: $name)
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                }
                Section(header: Text("Repeat")) {
                    Picker("Repeat", selection: $repeatOption) {
                        ForEach(RepeatOption.allCases, id: \.self) { option in
                            Text(option.rawValue)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                Section {
                    Button("Add Medication") {
                        let newMedication = Medication(name: name, time: time)
                        medications.append(newMedication)
                        scheduleNotification(for: newMedication)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Add Medication")
        }
    }
    
    func scheduleNotification(for medication: Medication) {
        let content = UNMutableNotificationContent()
        content.title = "Medication Reminder"
        content.body = "It's time to take your medication: \(DateFormatter.twelveHourFormat.string(from: medication.time))"
        content.sound = UNNotificationSound.default
        
        var trigger: UNNotificationTrigger?
        
        switch repeatOption {
        case .hourly:
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3600, repeats: true)
        case .daily:
            let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: medication.time)
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        case .custom:
            break
        default:
            let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: medication.time)
            trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        }
        
        if let trigger = trigger {
            let request = UNNotificationRequest(identifier: medication.id.uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error adding notification: \(error)")
                } else {
                    print("Notification scheduled for \(medication.name) at \(medication.time)")
                }
            }
        }
    }
}

struct AddMedicationView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicationView(medications: .constant([]))
    }
}
