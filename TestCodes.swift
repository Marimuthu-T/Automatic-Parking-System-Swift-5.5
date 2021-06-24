//Mark: Time and Date

let date = Date()

let myCalendar = Calendar(identifier: .gregorian)
let ymd = myCalendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: Date())
print("               \(ymd.year!)/\(ymd.month!)/\(ymd.day!)")
print("               \(ymd.hour!):\(ymd.minute!):\(ymd.second!)")
if let _ = readLine()
{
    
let date2 = Date()
let distanceBetweenDates: TimeInterval? = date2.timeIntervalSince(date)
print(distanceBetweenDates!)
}


//Mark: Welcome Message
print("------------Welcom to Auto Parker------------------")
print("       Enter Your Vehicle Type      ")
print("       Enter Your Vehicle Number      ")