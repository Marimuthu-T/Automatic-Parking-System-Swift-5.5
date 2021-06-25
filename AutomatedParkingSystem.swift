//InvoiceModel.swift


import Foundation



var homeString = """

                                       -Home-   
                         1 -> Vehicle IN
                         2 -> Vehicle Out
                         3 -> Other Options
                         4 -> Exit
        """

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
    let vehicleName: String!
    let vehicleNumber: String!

    public init(vehicleNumber: String , vehicleName: String )
    {
        self.vehicleName = vehicleName
        self.vehicleNumber = vehicleNumber
    }
}
public class InvoiceModel
{
    weak var register: InOutRegister!
    init(for register: InOutRegister)
    {
        self.register = register
    }
   public  func printInvoice()
    {       
        let calendar = Calendar(identifier: .gregorian)
        print("VehicleNumber:    \(register.vehicle.vehicleNumber!)")
        print("VehicleName:    \(register.vehicle.vehicleName!)")
        print("Driver:    \(register.driver!)")
        var DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: register.inTime)
        print("InTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)") 
        DateTime = calendar.dateComponents([.year, .month, .day , .hour ,.minute , .second ], from: register.outTime)
        print("OutTime:   \(DateTime.hour!):\(DateTime.minute!):\(DateTime.second!)   \(DateTime.year!)/\(DateTime.month!)/\(DateTime.day!)")
        print("totalTime:    \(register.totalTime!) mins")
        print("TotalAmount : \(register.Amount!) rupees" )       
    }

}

class InOutRegister
{
    var RegisterId: String!
    var vehicle: VehicleDetails!
    let driver: String!
    var inTime: Date!
    var outTime: Date!
    var totalTime: TimeInterval?
    var Amount : Double?
    var vehicleType: VehicleType = .car
    var invoice: InvoiceModel?

    init()
    {
        self.driver = "est"
    }

    init (vehicleNumber: String , vehicleName: String ,driver: String )
    {
        self.driver = driver
        self.vehicle = VehicleDetails(vehicleNumber: vehicleNumber , vehicleName: vehicleName)
        self.inTime = Date()
    }

    
    public func vehicleOut()
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



//Mark: Model Parking Slot

struct ParkingFloor
{
    var parkingFloor = [[Int]](repeating: [Int](repeating: 0, count: 5), count: 4)
    var isFloorAvailable: Bool = true

}

var ParkingArea = [ParkingFloor](repeating: ParkingFloor(), count: 5)





//Mark: viewModel




struct EntryExit
{
    
    var register: [Int : InOutRegister] = [0 : InOutRegister()] 
    var registerCount: Int = 10000
    mutating func entry()
    {
        let InVehicle = InOutRegister(vehicleNumber: "TN 35 RD 3423" , vehicleName: "Car" , driver: "Mr.Rick")
        registerCount = registerCount + 1
        print(registerCount)
        self.register.updateValue(InVehicle, forKey:registerCount )
        print("VehicleIn")
        print(registerCount)
    }

    mutating func out(RegisterId: Int)
    {
        let outVehicle = register[RegisterId]!
        outVehicle.vehicleOut()
        outVehicle.invoice = InvoiceModel(for: outVehicle)
        outVehicle.invoice!.printInvoice()
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
        print(homeString) 
        if let choice = Int(readLine() ?? "4")
        {
            switch choice
            {
                case 1:
                vehicleIn()
                case 2:
                vehicleOut()
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
    var counter = EntryExit()
    func vehicleIn()
    {
        self.counter.entry()            
    }

    func vehicleOut()
    {
        print("Enter Your RegisterID")
        if let RegisterID = Int(readLine() ?? "Not")
        {
        self.counter.out(RegisterId: 10001)
        }
        else
        {
            print("Enter proper RegisterID")
        }
    }

    func others()
    {

    }
}

var start = HomeView()
start.Home()