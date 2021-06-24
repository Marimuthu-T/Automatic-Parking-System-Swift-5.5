//InvoiceModel.swift


import Foundation

public class Invoice : NSObject
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
    

   public  func printInvoice()
    {       
        let calendar = Calendar(identifier: .gregorian)
        print("VehicleNumber:    \(vehicleNumber!)")
        print("VehicleName:    \(vehicleName!)")
        print("Driver:    \(driver!)")
        print("InvoiceNumber:    \(invoiceNumber!)")
        var DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: inTime)
        print("InTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)") 
        DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: outTime)
        print("OutTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)")
        print("totalTime:    \(totalTime!) mins")
        print("TotalAmount : \(Amount!)")       
    }

}

