//
//  Log.swift
//  iClaim
//
//  Created by Ertan Sinik on 8.06.2020.
//  Copyright © 2020 Terra Bilgi İşlem. All rights reserved.
//

import Foundation
import UIKit

enum Logging {
    case Enabled
    case Disabled
}


var logging: Logging = .Enabled
var memoryLogging: Logging = .Enabled
var networkLogging: Logging = .Enabled


enum LogEvent: String {
    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[🦟]" // debug
    case v = "[💬]" // verbose
    case w = "[⚠️]" // warning
    case s = "[🔥]" // severe
    
    case m = "[💾]" // memory
    case n = "[🌐]" // network
}


/// Wrapping Swift.print() within DEBUG flag
///
/// - Note: *print()* might cause [security vulnerabilities](https://codifiedsecurity.com/mobile-app-security-testing-checklist-ios/)
///
/// - Parameter object: The object which is to be logged
///
func print(_ object: Any) {
    Swift.print(object)
}



///
struct WriteToFile: TextOutputStream {

    
    static var log: WriteToFile = WriteToFile()
    private init() {}
    
    /// Appends the given string to the stream.
    mutating func write(_ string: String) {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .allDomainsMask)
        let documentDirectoryPath = paths.first!
        let log = documentDirectoryPath.appendingPathComponent("log_\(Date().toStringSimple()).txt")
        
        let strWithNewLine = string.appending("\n")
        
        
        do {
            let handle = try FileHandle(forWritingTo: log)
            handle.seekToEndOfFile()
            handle.write(strWithNewLine.data(using: .utf8)!)
            handle.closeFile()
        } catch {
            print(error.localizedDescription)
            do {
                try strWithNewLine.data(using: .utf8)?.write(to: log)
            } catch {
                print(error.localizedDescription)
            }
        }

    }

}




class Log {
    // 1. The date formatter
    static var dateFormat = "yyyy-MM-dd hh:mm:ss.SSS" // Use your own
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    
    // 1. The date formatter
    static var dateFormatSimple = "dd-MM-yyyy" // Use your own
    static var dateFormatterSimple: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatSimple
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    
    
    private static var isLoggingEnabled: Bool {
        
        if logging == .Enabled {
            return true
        }
        
        return false
        
    }
    
    private static var isMemoryLoggingEnabled: Bool {
        
        if memoryLogging == .Enabled {
            return true
        }
        
        return false
        
    }
    
    private static var isNetworkLoggingEnabled: Bool {
        
        if networkLogging == .Enabled {
            return true
        }
        
        return false
        
    }
    
    
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    
    // 1.
    class func e( _ object: Any,// 1
                  filename: String = #file, // 2
                  line: Int = #line, // 3
                  column: Int = #column, // 4
                  funcName: String = #function) {
        if isLoggingEnabled {
            let str = "\(Date().toString()) \(LogEvent.e.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)"
            print(str)
            WriteToFile.log.write(str)
        }
    }
    
    // 2.
    class func i( _ object: Any,// 1
                  filename: String = #file, // 2
                  line: Int = #line, // 3
                  column: Int = #column, // 4
                  funcName: String = #function) {
        if isLoggingEnabled {
            let str = "\(Date().toString()) \(LogEvent.i.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)"
            print(str)
            WriteToFile.log.write(str)
        }
    }
    
    // 3.
    class func d( _ object: Any,// 1
                  filename: String = #file, // 2
                  line: Int = #line, // 3
                  column: Int = #column, // 4
                  funcName: String = #function) {
        if isLoggingEnabled {
            let str = "\(Date().toString()) \(LogEvent.d.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)"
            print(str)
            WriteToFile.log.write(str)
        }
    }
    
    // 4.
    class func v( _ object: Any,// 1
                  filename: String = #file, // 2
                  line: Int = #line, // 3
                  column: Int = #column, // 4
                  funcName: String = #function) {
        if isLoggingEnabled {
            let str = "\(Date().toString()) \(LogEvent.v.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)"
            print(str)
            WriteToFile.log.write(str)
        }
    }
    
    // 5.
    class func w( _ object: Any,// 1
                  filename: String = #file, // 2
                  line: Int = #line, // 3
                  column: Int = #column, // 4
                  funcName: String = #function) {
        if isLoggingEnabled {
            let str = "\(Date().toString()) \(LogEvent.w.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)"
            print(str)
            WriteToFile.log.write(str)
        }
    }
    
    // 6.
    class func s( _ object: Any,// 1
                  filename: String = #file, // 2
                  line: Int = #line, // 3
                  column: Int = #column, // 4
                  funcName: String = #function) {
        if isLoggingEnabled {
            let str = "\(Date().toString()) \(LogEvent.s.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)"
            print(str)
            WriteToFile.log.write(str)
            
        }
    }
    
    
    // 7.
    class func m( _ object: Any = "",// 1
                  filename: String = #file, // 2
                  line: Int = #line, // 3
                  column: Int = #column, // 4
                  funcName: String = #function) {
        if isMemoryLoggingEnabled {
            
            let message = "\(object)" == "" ? "" : "Message: \(object)"
            let str = "\(Date().toString()) \(LogEvent.m.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(message) *** \(formattedMemoryFootprint()) *** "
            print(str)
            WriteToFile.log.write(str)
        }
    }
    
    
    // 7.
    class func n( _ object: Any,// 1
                  filename: String = #file, // 2
                  line: Int = #line, // 3
                  column: Int = #column, // 4
                  funcName: String = #function) {
        if isNetworkLoggingEnabled && isLoggingEnabled {
            let str = "\(Date().toString()) \(LogEvent.n.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)"
            print(str)
            WriteToFile.log.write(str)
        }
    }
    
}
// 2. The Date to String extension
extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
    
    func toStringSimple() -> String {
        return Log.dateFormatterSimple.string(from: self as Date)
    }
}

func memoryFootprint() -> Float? {
    // The `TASK_VM_INFO_COUNT` and `TASK_VM_INFO_REV1_COUNT` macros are too
    // complex for the Swift C importer, so we have to define them ourselves.
    let TASK_VM_INFO_COUNT = mach_msg_type_number_t(MemoryLayout<task_vm_info_data_t>.size / MemoryLayout<integer_t>.size)
    let TASK_VM_INFO_REV1_COUNT = mach_msg_type_number_t(MemoryLayout.offset(of: \task_vm_info_data_t.min_address)! / MemoryLayout<integer_t>.size)
    var info = task_vm_info_data_t()
    var count = TASK_VM_INFO_COUNT
    let kr = withUnsafeMutablePointer(to: &info) { infoPtr in
        infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { intPtr in
            task_info(mach_task_self_, task_flavor_t(TASK_VM_INFO), intPtr, &count)
        }
    }
    guard
        kr == KERN_SUCCESS,
        count >= TASK_VM_INFO_REV1_COUNT
    else { return nil }
    
    let usedBytes = Float(info.phys_footprint)
    return usedBytes
    
}

func formattedMemoryFootprint() -> String {
    let usedBytes: UInt64? = UInt64(memoryFootprint() ?? 0)
    let usedMB = Double(usedBytes ?? 0) / 1024 / 1024
    //let usedMBAsString: String = "Memory Used by App: \(usedMB)MB"
    let usedMBAsString: String = "Memory Used by App: \(usedMB)MB"
    return usedMBAsString
}
