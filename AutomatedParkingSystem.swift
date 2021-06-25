//InvoiceModel.swift


import Foundation


//assign(vehicle: 34)
var homeString = """

                                       -Home-   
                         1 -> Vehicle IN
                         2 -> Vehicle Out
                         3 -> Other Options
                         4 -> Exit
        """

var vehicleTypeString = """

                                       -Enter Your Vehicle Type-   
                        1 -> bycycle  
                        2 -> bike
                        3 -> car
                        4 -> van
                        5 -> bus
        """

enum VehicleType: Int {

    case bycycle = 1  
    case bike
    case car
    case van
    case bus
}

//Mark: Model Parking Slot

class ParkingFloor
{
    var parkingFloor = [[Int]](repeating: [Int](repeating: 0, count: 4), count: 5)
    var isFloorAvailable: Bool = true
    var isBusAvailable: Bool = true
    var isCarAvailable: Bool = true
    var isVanAvailable: Bool = true
    var isBikeAvailable: Bool = true
    var isBycycleAvailable: Bool = true
    var vehicleCount = 0

    func park(lengthRequired: Int , Id: Int) -> (row: Int, line: Int)?
    {
        var lengthAvailable = 0
        var start = 0
        var linenumber = 0
        for line in parkingFloor
        {
            if(line[2] == 0)
            {
                lengthAvailable += 1
            }
            else
            {
                lengthAvailable = 0
                start = linenumber + 1
            }
            if(lengthAvailable ==  lengthRequired)
            {
                for i in 0...lengthRequired - 1
                {
                    parkingFloor[start + i][2] = Id
                    parkingFloor[start + i][3] = Id
                }
                return (1 , start)
            }
            linenumber += 1
        }
        return nil
    }
}

var ParkingArea = [ParkingFloor() , ParkingFloor() , ParkingFloor() , ParkingFloor() , ParkingFloor()]

func park(vehicle: Int , id: Int) -> (floor: Int , Row: Int, line: Int)?
{
    var floorNo = 0 
   for floor in ParkingArea
   {
      if floor.isFloorAvailable
      {

          if let slotassigned = floor.park(lengthRequired: vehicle , Id: id)
          {
             floor.vehicleCount = floor.vehicleCount + vehicle                 
             return (floorNo , slotassigned.row , slotassigned.line)       
          }
      } 
      floorNo += 1

   }  
   return nil
}


func displacing(vehicle: InOutRegister)
{
    let parkingFloor = ParkingArea[vehicle.parkedSlot.floor]
    let start = vehicle.parkedSlot.line
    let requiredLength = vehicle.vehicleType.rawValue
    print("\(vehicle.vehicleType.rawValue)       \(vehicle.parkedSlot.line)   \(vehicle.parkedSlot.floor)")
    for i in 0...requiredLength - 1
         {
            parkingFloor.parkingFloor[start + i][2] = 0
            parkingFloor.parkingFloor[start + i][3] = 0
         }
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
    var driver: String!
    var inTime: Date!
    var outTime: Date!
    var totalTime: TimeInterval?
    var Amount : Double?
    var vehicleIn: Bool = false
    var vehicleType: VehicleType = .car
    var invoice: InvoiceModel?
    var floorNo: Int?
    var parkedSlot: (floor: Int, Row: Int, line: Int)!

    init (){}

    init (vehicleType: VehicleType , vehicleNumber: String , vehicleName: String ,driver: String )
    {
        self.driver = driver
        self.vehicle = VehicleDetails(vehicleNumber: vehicleNumber , vehicleName: vehicleName )
        self.vehicleType = vehicleType
        self.inTime = Date()
        self.vehicleIn = true
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


func printslot(Floor requiredfloor: Int)
{
    let floor = ParkingArea[requiredfloor].parkingFloor
    for line in floor
    {
        for row in line
        {
            print(row)
        }
        print("---")
    }
}



//Mark: viewModel




struct EntryExit
{
    
    var register: [Int : InOutRegister] = [0 : InOutRegister()] 
    var registerCount: Int = 10000
    mutating func entry(vehicleType: VehicleType , vehicleNumber: String , vehicleName: String ,driver: String )
    {
        let InVehicle = InOutRegister(vehicleType: vehicleType , vehicleNumber: vehicleNumber  , vehicleName: vehicleName , driver: driver )
        registerCount = registerCount + 1
        self.register.updateValue(InVehicle, forKey:registerCount )       
         InVehicle.parkedSlot = park(vehicle: vehicleType.rawValue , id: registerCount)
        if InVehicle.parkedSlot != nil
        {
        print("VehicleParkedIn")
        print("Floor: \(InVehicle.parkedSlot.floor + 1) Row: 1 line: \(InVehicle.parkedSlot.line + 1)") 
        printslot(Floor: InVehicle.parkedSlot.floor)
        }
        else
        {
            print("No slot Available")
        }
    }

    mutating func out(registerId: Int)
    {
        guard registerId > 10000 && registerId <= registerCount else
        {
            print("Enter Valid Register ID ")
            return 
        }
        
        let outVehicle = register[registerId]!
        guard outVehicle.vehicleIn else {
            print("Your Vehicle is already out")
            return 
        }
        outVehicle.vehicleOut()
        outVehicle.invoice = InvoiceModel(for: outVehicle)
        outVehicle.invoice!.printInvoice()
        outVehicle.vehicleIn = false
        displacing(vehicle: outVehicle)
        printslot(Floor: outVehicle.parkedSlot.floor)
         
    }
}

















//Mark: Welcome Message
class HomeView
{
    var counter: EntryExit!
    init(){
        print(" -----------------------WELCOME TO AUTO PARKER-----------------------------")
        self.counter = EntryExit()
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

    func vehicleIn()
    {
        var vehicleType: VehicleType!
        var vehicleNumber: String!
        var driverName: String!

        print(vehicleTypeString)
        if let givenVehicletype = Int(readLine() ?? "k")
        {
            switch givenVehicletype
            {
                case VehicleType.bycycle.rawValue:
                vehicleType = .bycycle
                case VehicleType.bike.rawValue:
                vehicleType = .bike
                case VehicleType.car.rawValue:
                vehicleType = .car
                case VehicleType.van.rawValue:
                vehicleType = .van
                case VehicleType.bus.rawValue:
                vehicleType = .bus
                default:
                print("Enter Proper Type ")
                return 
            }
        }
        else
        {
            print("Enter proper Vehicle Type ")
            return 
        }

        print("       Enter Your Vehicle Number      ")
        if let givenVehicleNumber = readLine()
        {
            vehicleNumber = givenVehicleNumber
        }
        else{
            print("Enter Proper Name")
        }
        print("Enter Driver Name")
        if let givenDriverName = readLine()
        {
            driverName = givenDriverName
        }
        else{
            print("Enter Proper Name")
        }


        self.counter.entry(vehicleType: vehicleType, vehicleNumber: vehicleNumber , vehicleName: "car" ,driver: driverName )            
    }

    func vehicleOut()
    {
        print("Enter Your RegisterID")
        if let RegisterID = Int(readLine() ?? "Not")
        {
        self.counter.out(registerId: RegisterID)
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