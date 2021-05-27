pragma solidity  ^0.6.0;
pragma experimental ABIEncoderV2;

contract DOCTORS{
    enum Statuses { Free , Occupied }
    Statuses currentStatus;
    
    address payable owner;
    address payable chemist_shop;
    address[] docAddr;
    address[] patientAddr;
    address[] chemistAddrr;
    uint[] rooms;
    uint[] check;
    
    
    struct doctor{
        address D_addr;
        string D_Name;
        string Specialization;
        uint[] time;
    }
    
    struct patient{
        address P_addr;
        string P_Name;
        string[] P_report;
        string[] P_meds;
        uint[] P_meds_quantity;
        uint[] P_rooms;
        
    }
    
    struct chemist{
        address C_addr;
        string C_name;
    }
    
    struct drug{
        string Dg_name;
        uint Dg_quantity;
    }
    
    
    patient[] patients;
    doctor[] doctors;
    chemist[] chemists;
    drug[] drugs;
    mapping(uint => patient) patientlist;
    mapping(uint => doctor)  doctorlist;
    mapping(uint => chemist) chemistlist;
    mapping(uint => drug) druglist;
    
    function compareStrings(string memory a, string memory b) internal pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))));
    }
    
    
    
    
    
    
    
    
    
    
    

        
    function RegisterDoctor(uint _id,string memory _D_Name,string memory _Specialization, uint[] memory _time) external{
        doctorlist[_id] = doctor(msg.sender,_D_Name,_Specialization,_time);
        docAddr.push(msg.sender);
        owner = msg.sender;
        }
        
    function RegisterRoom(uint _room_no) public{
        // require(docAddr[0] == msg.sender,"TO REGISTER YOU MUST BE OWNER");
        rooms.push(_room_no);
    }     
        
        
    function RegisterPatient(uint _id,string memory _P_Name ,string[] memory _P_report , string[] memory _P_meds , uint[] memory _P_meds_quantity , uint[] memory _P_rooms) external{
        require(docAddr[0] != msg.sender,"Cannot register as on same id as doctor");
        patientlist[_id] = patient({P_Name : _P_Name , P_addr : msg.sender , P_report : _P_report, P_meds : _P_meds , P_meds_quantity : _P_meds_quantity , P_rooms : _P_rooms});
        patientAddr.push(msg.sender);
        }
        
    
    function RegisterChemist(uint _id , string memory _C_name) public{
        chemistlist[_id] = chemist(msg.sender,_C_name);
        chemistAddrr.push(msg.sender);
        chemist_shop = msg.sender;
        
    }
    
    function RegisterDrugs(uint _id,string memory _Dg_name,uint _Dg_quantity) public{
        require(chemistAddrr[0] == msg.sender,"NEED TO BE CHEMIST TO REGISTER");
        druglist[_id] = drug(_Dg_name,_Dg_quantity);
    }
    
    
    
    
        
        
        
        
        
        
        
    
    function paymentForDoctor(uint _time) external payable {
        for(uint i = 0 ; i < doctorlist[1].time.length ; i++){
            require(doctorlist[1].time[0] == _time , "DOCTOR NOT FREE");
            owner.transfer(2 ether);
        }
    }
    
    
    function sendReportDoc(string memory _P_report) public{
        require(docAddr[0] == msg.sender,"Cannot register as on same id as patient");
        patientlist[1].P_report.push(_P_report);
    }
    
    
    function paymentForRoom(uint _room_no) public payable returns (uint[] memory){
        for(uint i = 0 ; i < rooms.length ; i++){
                // require(_room_no == rooms[i],"No Room");
                if(_room_no == rooms[i]){
                     require(msg.value>= 2 ether,"TRANSACTION INCOMPLETE DUE TO LOW MONEY");
                     owner.transfer(2 ether);
                     patientlist[1].P_rooms.push(_room_no);
                     delete rooms[i];
                }
                else{
                    owner.transfer(0 ether);
                }
                // require(msg.value>= 2 ether,"TRANSACTION INCOMPLETE DUE TO LOW MONEY");
                // owner.transfer(2 ether);
        }
        return check;
    }
    
    // function paymentForDrugs(uint _d_id) public view returns(string memory){
    //     for(uint i = 1 ; i < drugs.length ; i++){
    //         if(_d_id == i){
    //              return(druglist[i].Dg_name);
    //         }
    //         else{
    //             return(druglist[i].Dg_name);
    //         }

    //     }
    // }
    function TransferOfDrugs(uint _p_id,uint _d_id,uint _d_quantity) public{
        require(druglist[_d_id].Dg_quantity > _d_quantity, "THERE IS NOT ENOUGH DRUGS PRESENT");
        patientlist[_p_id].P_meds.push(druglist[_d_id].Dg_name);
        patientlist[_p_id].P_meds_quantity.push(_d_quantity);
        druglist[_d_id].Dg_quantity = druglist[_d_id].Dg_quantity - _d_quantity;
        
    }



    
    
    
    
    
    
    
    
    
    function DocView() public view returns(address,string memory){
        if(doctorlist[1].time[0] == 1){
            return (docAddr[0],doctorlist[1].D_Name);
        }
    }
    
    function PatView() public view returns(address,string memory,string[] memory,uint[] memory,string[] memory ,uint[] memory){
        return (patientlist[1].P_addr,patientlist[1].P_Name,patientlist[1].P_report,patientlist[1].P_rooms,patientlist[1].P_meds,patientlist[1].P_meds_quantity);
    }
    
    function RoomView() public view returns(uint[] memory){
        return(rooms);
    }
    
    function ChemistView() public view returns(address,string memory){
        return(chemistlist[1].C_addr,chemistlist[1].C_name);
    }
    function DrugView(uint _index) public view returns(string memory,uint quantity){
        return(druglist[_index].Dg_name,druglist[_index].Dg_quantity);
    }

}