//
//  ContentView.swift
//  MedicReminder Watch App
//
//  Created by Janindu Dissanayake on 2024-06-11.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
        @State private var medications: [Medication] = []
        @State private var showAddMedication = false
        @State private var showHistory = false
    
        var body: some View {
                NavigationView {
                    List {
                        ForEach(medications) { medication in
                            HStack {
                                Text(medication.name)
                                Text("@")
                                    .font(.caption)
                                Text(DateFormatter.twelveHourFormat.string(from: medication.time))
                                    .font(.caption)
                                Spacer()
                                if medication.isTaken {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                }
                            }
                            .onTapGesture {
                                markMedicationAsTaken(medication: medication)
                            }
                        }
                        .onDelete(perform: deleteMedication)
                    }
                    .navigationTitle("Medications")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button(action: {
                                showAddMedication = true
                            }) {
                                Image(systemName: "plus")
                            }
                        }
                        ToolbarItem(placement: .bottomBar) {
                            Button(action: {
                                showHistory = true
                            }) {
                                Image(systemName: "chart.bar.fill")
                            }
                        }
                    }
                    .sheet(isPresented: $showAddMedication) {
                        AddMedicationView(medications: $medications)
                    }
                    .sheet(isPresented: $showHistory) {
                        MedicationHistoryView(medications: medications)
                    }
                    .onAppear {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                            if let error = error {
                                print("Error requesting notification authorization: \(error)")
                            } else if granted {
                                print("Notification permissions granted.")
                            } else {
                                print("Notification permissions denied.")
                            }
                        }
                    }
                }
            }

            private func markMedicationAsTaken(medication: Medication) {
                   guard let index = medications.firstIndex(where: { $0.id == medication.id }) else { return }
                   medications[index].isTaken = true
                   medications[index].takeDose()
               }

            private func deleteMedication(at offsets: IndexSet) {
                medications.remove(atOffsets: offsets)
            }
    }

#Preview {
    ContentView()
}
