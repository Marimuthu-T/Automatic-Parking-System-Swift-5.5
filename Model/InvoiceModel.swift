//InvoiceModel.swift


import Foundation

public class Invoice
{
    var invoiceNumber: Int!
    var inTime: Date!
    let vehicleName: String!
    let vehicleNumber: String!
    let driver: String!
    var outTime: Date!
    var totalTime: TimeInterval?
    var Amount : Double?

    public init(vehicleNumber: String , vehicleName: String , driver: String)
    {
        self.invoiceNumber = 0
        self.vehicleName = vehicleName
        self.vehicleNumber = vehicleNumber
        self.driver = driver
        self.inTime = Date()
    }

    public func VehicleOut()
    {
        if outTime == nil 
        {
            outTime = Date()
            
        self.totalTimeCalculator()
        }
        else {
            print("The vhechile is already Out")
        }
    }
     
    public func totalTimeCalculator()
    {
        self.totalTime = outTime.timeIntervalSince(inTime)
        self.Amount = totalTime! * 5.00
    }
    

   public  func prints()
    {
        
    let myCalendar = Calendar(identifier: .gregorian)
        print("VehicleNumber:    \(vehicleNumber!)")
        print("VehicleName:    \(vehicleName!)")
        print("Driver:    \(driver!)")
        print("InvoiceNumber:    \(invoiceNumber!)")
        var ymd = myCalendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: inTime)
        print("InTime:   \(ymd.hour!):\(ymd.minute!):\(ymd.second!)   \(ymd.year!)/\(ymd.month!)/\(ymd.day!)") 
        ymd = myCalendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: outTime)
        print("OutTime:   \(ymd.hour!):\(ymd.minute!):\(ymd.second!)   \(ymd.year!)/\(ymd.month!)/\(ymd.day!)")
        print("totalTime:    \(totalTime!) mins")
        print("TotalAmount : \(Amount!)")       
    }

}

