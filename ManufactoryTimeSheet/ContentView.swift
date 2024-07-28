//
//  ContentView.swift
//  ManufactoryTimeSheet
//
//  Created by Artem Denisov  on 14-07-2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var reports: [Report]
    
    @State var isAddPresented = false

    var body: some View {
        NavigationStack{
            List {
                ForEach(reports.sorted{ $0.created_at > $1.created_at}) { report in
                    NavigationLink {
                        ReportEditor(report: report)
                    } label: {
                        
                        Text("\(DateFormatter.localizedString(from: report.created_at, dateStyle: .long, timeStyle: .none)) - \(report.calculateWorkingHours())")
                    }
                    
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Time sheet reports")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        isAddPresented = true
                    } label: {
                        Label("Add Report", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddPresented) {
                ReportEditor(report: nil)
                
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(reports[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Report.self, inMemory: true)
}
