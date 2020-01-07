using Toybox.Communications as Comm;
using Toybox.System as Sys;

class TimeTable{
	var timestamp = new [10];
	var vehicle_num = new [10];
	var destination = new [10]; 
}

class StationInfoModel{

	var timetable = null; 
	hidden var TRANSPORT_URL = "https://transport.opendata.ch/v1/stationboard?id=8591307&limit=5&fields[]=stationboard/category&fields[]=stationboard/number&fields[]=stationboard/to&fields[]=stationboard/passList/departure";
	hidden var notify; 
	
	function initialize(handler)	{
  	   	notify = handler;
        fetchData();
    }

	function fetchData(){
		Sys.println("Fetching Data .. "); 
		//Check if Communications is allowed for Widget usage
		if (Toybox has :Communications) {
			timetable = null; 
			// Fetch the timetable information from the Transport API 
			Comm.makeWebRequest(TRANSPORT_URL,
		         				 {}, 
		         				 {}, 
		         				 method(:onReceiveData));
		}else { //If communication fails
      		Sys.println("Communication\nnot\npossible");
      	} 
	}
	
	
	function onReceiveData(responseCode, data) {
        if(responseCode == 200) {
    		if(timetable == null) {
        		timetable = new TimeTable();
			}
			//Load data from JSON response into object
			for(var i =0 ; i < 5 ; i++){
				var station_board = data["stationboard"][i];
				timetable.timestamp[i] = station_board["passList"][0]["departure"].substring(11,16);
				timetable.vehicle_num[i] = station_board["category"] + station_board["number"];
				timetable.destination[i] = station_board["to"].substring(8, station_board["to"].length());
			}
			
			
         	//Sys.println(data);
           	notify.invoke(timetable); //Send this object to View

        }else { //If error in getting data from JSON API
        		Sys.println("Data request failed\nWith response: ");
        		Sys.println(responseCode);
        		Sys.println(data);
        }
    }

}
