pragma solidity =0.6.0;

contract Insurance{

    address VehicleOwner;
    address InsuranceCompany;
    address Manufacturer;
    uint BatteryPerformance;
    string BatteryStatus;

    
    constructor() public {

        Manufacturer = msg.sender;
    } 


    modifier IsManufacturer(){

        require(msg.sender == Manufacturer,"Sender not authorized");
        _;
    }

    function RegisterEV(uint Battery) public {

        VehicleOwner = msg.sender;
        BatteryPerformance = Battery;
        BatteryStatus = "";
    }

    function InsuranceEV() public {

        InsuranceCompany = msg.sender;
    }

    function ServiceStatus() public view returns (string memory) {

        return BatteryStatus;    
    }

    function CheckBateryPerformance() public IsManufacturer {

        if(BatteryPerformance > 80)
        {
           BatteryStatus = "Service not needed"; 
        }
        else
        {
           BatteryStatus = "Service or Replacement needed";
        }
    }
}

contract EVPurchase{

    address Manufacturer;
    address ElectricVehicle;
    address Distributor;
    bool ApplicationStatus = false;
    bool RoadTransportApproval;
    string ApplicationApproval;

    constructor() public payable{
        require (msg.value > 0.1 ether);
        Manufacturer = msg.sender;
    } 

    function RegisterDistributor() public {
        Distributor = msg.sender;
    }

    modifier IsManufacturer() {

        require(msg.sender == Manufacturer,"Sender not authorized");
        _;
    }

    modifier IsDistributor() {

        require(msg.sender == Distributor,"Sender not authorized");
        _;
    }
    function GenerateEVAddress() public IsManufacturer{

        ElectricVehicle = address(bytes20(keccak256(abi.encodePacked(now))));
        RoadTransportApproval = true;
    }

    function SetApplicationStatus() public IsDistributor{

        ApplicationStatus = true;
    }

    function VehicleApproval() public IsDistributor{

        if (RoadTransportApproval)
        {
            ApplicationApproval = "Approved with five star rating";
        }
        else
        {
            ApplicationApproval = "Vehicle not recommended to buyer";
        }
    }

    function ApprovalStatus() public view returns (string memory){

        return ApplicationApproval;
    }
}

contract BatteryMonitoring{

    address Buyer;
    address ServiceProvider;
    bool ApplicationStatus = true;
    string BatteryPerformance;

    constructor() public {

        ServiceProvider = msg.sender;
    }

    modifier IsServiceProvider() {
        
        require(msg.sender == ServiceProvider);
        _;
    }

    function CheckPerformance(uint T1, uint T2) public IsServiceProvider{
        require(ApplicationStatus == true);
        if (T2 == T1)
        {
            BatteryPerformance = "Battery Performance is good";
        }
        else if (T2 > T1 && T2 >= 7 && T2 <=10)
        {
            BatteryPerformance = "Battery Performance is poor, need service or replacement";
        }
        else 
        {
            BatteryPerformance = "";
        }
    }

    function ShowBattery() public view returns (string memory){

        return BatteryPerformance;
    }
}