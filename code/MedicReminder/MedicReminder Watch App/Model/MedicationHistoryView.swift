//
//  MedicationHistoryView.swift
//  MedicReminder Watch App
//
//  Created by Janindu Dissanayake on 2024-06-11.
//

import SwiftUI

struct MedicationHistoryView: View {
    var medications: [Medication]

        var body: some View {
            NavigationView {
                List {
                    ForEach(medications) { medication in
                        HStack {
                            Text(medication.name)
                                .font(.footnote)
                            Spacer()
                            Text("\(medication.dosesTaken)/\(medication.totalDoses) doses taken")
                                .font(.footnote)
                        }
                    }
                }
                .navigationTitle("Medication History")
            }
        }
}

struct MedicationHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let medications = [
            Medication(name: "Medication A", time: Date(), isTaken: true, dosesTaken: 3, totalDoses: 5),
            Medication(name: "Medication B", time: Date(), isTaken: false, dosesTaken: 0, totalDoses: 10)
        ]

        return MedicationHistoryView(medications: medications)
    }
}

