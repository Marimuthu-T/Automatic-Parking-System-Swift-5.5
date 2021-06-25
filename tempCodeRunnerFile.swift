

class ParkingFloor
{
    var parkingFloor = [[Int]](repeating: [Int](repeating: 0, count: 5), count: 4)
    var isFloorAvailable: Bool = true
    var isBusAvailable: Bool = true
    var isCarAvailable: Bool = true
    var isVanAvailable: Bool = true
    var isBikeAvailable: Bool = true
    var isBycycleAvailable: Bool = true
    var vehicleCount = 0

}

var ParkingArea = [ParkingFloor() , ParkingFloor() , ParkingFloor() , ParkingFloor() , ParkingFloor()]

func park(vehicle: Int , id: Int) -> Int?
{
    var floorNo = 0 
   for floor in ParkingArea
   {
      if floor.isFloorAvailable && floor.isAvailableforBus(lengthRequired: vehicle , Id: id)
      {
         floor.vehicleCount = floor.vehicleCount + vehicle                 
         print("floorNo \(floorNo) /n floor.vehicleCount \(floor.vehicleCount) ")
         return floorNo
         
      } 
      floorNo += 1
      print(floorNo)
   }  
   return nil
}


func displacing(vehicle: InOutRegister)
{
   var floorNo = 0 
   for floor in ParkingArea
   {
       if floorNo == vehicle.floorNo
       {
         floor.vehicleCount -=  vehicle.vehicleType.rawValue
       }
   } 
      floorNo += 1
}



