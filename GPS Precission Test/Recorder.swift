//
//  Recorder.swift
//  GPS Precission Test
//
//  Created by Pablo Yaniero on 9/8/18.
//  Copyright © 2018 Pablo Yaniero. All rights reserved.
//

import UIKit

enum RecordColumn : String {
    case timestamp = "timestamp"
    case latitude = "latitude"
    case longitude = "longitude"
    case speed = "speed"
    case background = "background"
    
}

protocol Recordable {
    func generateRecord() -> [RecordColumn : String]
    func stringValue() -> String
}

class Recorder: NSObject {
    
    var entries : [[RecordColumn : String]] = []
    
    func setUpRecord () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let folderName = dateFormatter.string(from: Date())
        
        UserDefaults.standard.set(folderName, forKey: "FolderName")
    }
    
    func record(r : Recordable) {
        let rec = r.generateRecord()
        print(r.stringValue())
        entries.append(rec)
        createCSV()
    }
    
    func createCSV() {
        var csvString = "\(RecordColumn.timestamp), \(RecordColumn.latitude), \(RecordColumn.longitude), \(RecordColumn.speed), \(RecordColumn.background)\n"
        for dct in entries {
            csvString = csvString.appending("\(String(dct[RecordColumn.timestamp]!)) ,\(String(dct[RecordColumn.latitude]!)),\(String(dct[RecordColumn.longitude]!)),\(String(dct[RecordColumn.speed]!)),\(String(dct[RecordColumn.background]!))\n")
        }
        
        if let folderName = UserDefaults.standard.value(forKey: "FolderName") as? String {
            let fileManager = FileManager.default
            do {
                let documentsPath = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
                let folderPath = documentsPath.appendingPathComponent(folderName)
                if !fileManager.fileExists(atPath: folderPath.path) {
                    try fileManager.createDirectory(at: folderPath, withIntermediateDirectories: true, attributes: nil)
                }
                
                
                let fileURL = folderPath.appendingPathComponent("Record.csv")
                try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
            } catch {
                print("error creating file")
            }
        }
        
       
        
    }
}
    

