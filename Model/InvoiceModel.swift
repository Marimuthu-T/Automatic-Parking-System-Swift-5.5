//InvoiceModel.swift


import Foundation

enum VehicleType: Int {

    case bycycle = 1  
    case bike
    case car
    case sUV
    case van
    case bus
}


public class InvoiceModel
{
    var inTime: Date!
    let vehicleName: String!
    let vehicleNumber: String!
    let driver: String!
    var outTime: Date!
    var totalTime: TimeInterval?
    var Amount : Double?
    var vehicleType: VehicleType = .car


    public init(vehicleNumber: String , vehicleName: String , driver: String)
    {
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
        var DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: inTime)
        print("InTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)") 
        DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: outTime)
        print("OutTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)")
        print("totalTime:    \(totalTime!) mins")
        print("TotalAmount : \(Amount!) rupees" )       
    }

}



var k = InvoiceModel(vehicleNumber: "gs", vehicleName: "dvsdv" , driver: "vsdv")

var out = readLine()

k.VehicleOut()

k.printInvoice()

