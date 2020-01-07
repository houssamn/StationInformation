using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class StationInfoDelegate extends Ui.BehaviorDelegate {

	//hidden var Model;
	
    //function initialize(priceModel) {
    function initialize(){ // DO nothing.. 
    		//Model = priceModel;
    }

    function onSelect() { //When Select is pressed, update and change page view.
    	Sys.println("Select is pressed"); 
        Ui.requestUpdate();
    }
}