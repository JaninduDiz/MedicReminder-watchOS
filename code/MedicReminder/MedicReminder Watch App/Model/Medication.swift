//
//  Medication.swift
//  MedicReminder Watch App
//
//  Created by Janindu Dissanayake on 2024-06-11.
//

import Foundation

struct Medication: Identifiable, Codable {
      var id = UUID()
      var name: String
      var time: Date
      var isTaken: Bool = false
      var dosesTaken: Int = 0 // Track doses taken
      var totalDoses: Int = 0 // Track total doses

      mutating func takeDose() {
          dosesTaken += 1
      }
}
