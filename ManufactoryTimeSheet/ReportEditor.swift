//
//  ReportEditor.swift
//  ManufactoryTimeSheet
//
//  Created by Artem Denisov  on 14-07-2024.
//

import SwiftUI

struct ReportEditor: View {
    let report: Report?
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var start_at: Date = Date()
    @State private var end_at: Date = Date()
    @State private var lunch_time: Int8 = 60
    @State private var created_at: Date = Date()
    
    private var editorTitle: String {
        report == nil ? "Add Report": "Edit Report"
    }
    
    private var limitRange: ClosedRange<Date> {
        let yearAgo = Calendar.current.date(byAdding: .year, value: -1, to:Date())!
        return yearAgo...Date.now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Current date:", selection: $created_at, in: limitRange, displayedComponents: .date)
                
                DatePicker("Start at:",  selection: $start_at, displayedComponents: .hourAndMinute)
                DatePicker("End at:", selection: $end_at, displayedComponents: .hourAndMinute)
                
                HStack {
                    Text("Lunch duration:")
                    
                    Spacer()
                    
                    TextField(
                        "in minutes",
                        value: $lunch_time,
                        format: .number
                    )
                        .keyboardType(.numberPad)
                        .frame(width: 100)
                        .multilineTextAlignment(.trailing)
                    
                }
                
            }
            .onAppear{
                if let report {
                    created_at = report.created_at
                    start_at = report.start!
                    end_at = report.end!
                    lunch_time = report.lunch_duration!
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation{
                            save()
                            dismiss()
                        }
                    }
                }
                if report == nil {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            withAnimation{
                                dismiss()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func save() {
        if let report {
            report.start = start_at
            report.end = end_at
            report.lunch_duration = lunch_time
            report.created_at = created_at
        } else {
            let newReport = Report(created_at: created_at)
            newReport.start = start_at
            newReport.end = end_at
            newReport.lunch_duration = lunch_time
            modelContext.insert(newReport)
        }
        
    }
    
}

#Preview {
    ReportEditor(report: nil)
}
