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

public class VehicleDetails
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
}
public class InvoiceModel
{
    var vehicle: VehicleDetails!
    init(vehicle: VehicleDetails)
    {
        self.vehicle = vehicle
    }
   public  func printInvoice()
    {       
        let calendar = Calendar(identifier: .gregorian)
        print("VehicleNumber:    \(vehicle.vehicleNumber!)")
        print("VehicleName:    \(vehicle.vehicleName!)")
        print("Driver:    \(vehicle.driver!)")
        var DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: vehicle.inTime)
        print("InTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)") 
        DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: vehicle.outTime)
        print("OutTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)")
        print("totalTime:    \(vehicle.totalTime!) mins")
        print("TotalAmount : \(vehicle.Amount!) rupees" )       
    }

}

//Mark: Model Parking Slot

struct ParkingFloor
{
    var parkingFloor = [[Int]](repeating: [Int](repeating: 0, count: 5), count: 4)
    var isFloorAvailable: Bool = true

}

var ParkingArea = [ParkingFloor](repeating: ParkingFloor(), count: 5)





//Mark: viewModel




class Controller
{
     var vehicles:  
     func vehicleController()
     {

     }
}

















//Mark: Welcome Message
class HomeView
{
    init()
    {
        print(" -----------------------WELCOME TO AUTO PARKER-----------------------------")
    }
    func Home()
    {
        print("""

                                       -Home-   
                         1 -> Vehicle IN
                         2 -> Vehicle Out
                         3 -> Other Options
                         4 -> Exit
        """) 
        if let choice = Int(readLine() ?? "4")
        {
            switch choice
            {
                case 1:
                VehicleIn()
                case 2:
                VehicleOut()
                case 3:
                others()
                case 4:
                print("  ---------------------  Thank You -----------------------")
                return 
                default:
                return Home()
            }
            Home()
        }
        else{
            print("Enter Proper Input")
            Home()
        }
    }

    func VehicleIn()
    {        
            let car = VehicleDetails(vehicleNumber: "TN 35 RD 3423" , vehicleName: "Car" , driver: "Mr.Rick")
           
            car.VehicleOut()
            
            let carInvoice = InvoiceModel(vehicle: car)
            carInvoice.printInvoice()
            
    }

    func VehicleOut()
    {
    }

    func others()
    {

    }
}

var start = HomeView()
start.Home()