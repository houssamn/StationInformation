using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class StationInfoView extends Ui.View {
	
	//Communication
	hidden var commConf = false; // Confirm communication
	
	// Timetable Info	
	hidden var mTime = new [10];
	hidden var mNumber = new [10];
	hidden var mDest = new [10];
	
	// Screen
	hidden var heightSplitter = [8.72, 3.633, 2.29473, 1.67692, 1.32121, 8.72, 3.633, 2.29473, 1.67692, 1.32121, 1.12953, 1.12953]; //For splitting screen height into 5
    hidden var textFont = Graphics.FONT_TINY; //Font size
    hidden var dcHeight;
    hidden var dcWidth;
	

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        //setLayout(Rez.Layouts.MainLayout(dc));
        
        dcHeight = dc.getHeight();
		dcWidth = dc.getWidth()/3; //Divide by tree to right align text
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
        
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
        
        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_BLACK); //Keep Bg color
        dc.clear();//Clear screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK); //Set text color
    	Sys.println("Updating View .. ");
    	
    		if(commConf == true){
        		drawTable(dc); //Draw prices and logos on screen
        		return;
    		}else{
    		    //If data is not fetched yet, write out message
        		dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Graphics.FONT_LARGE, "Getting SBB Data", Graphics.TEXT_JUSTIFY_CENTER | Graphics.TEXT_JUSTIFY_VCENTER);
    		}
    	
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function drawTable(dc){
    
    	//Draw title (Top)
		dc.drawText(dc.getWidth()/2, 
    					5, 
    					Graphics.FONT_XTINY, 
    					"Radiostudio", 
    					Graphics.TEXT_JUSTIFY_CENTER);
		
		//Draw timestamp (Bottom)
//		dc.drawText(dc.getWidth()/2, 
//    					dc.getHeight()/heightSplitter[10], 
//    					Graphics.FONT_XTINY, 
//    					dateString, 
//    					Graphics.TEXT_JUSTIFY_CENTER);
		
		for( var i = 0; i < 5; i++ ) {
			//Draw symbol and price for each coin
    			//dc.drawText(dcWidth, 
    			dc.drawText(20,
    			dcHeight/heightSplitter[i], 
    			textFont,
    			mTime[i] + " " + mNumber[i] + " " + mDest[i], 
    			Graphics.TEXT_JUSTIFY_LEFT);
   			//Draw icons for each coin	
			//drawIcon(dc, mCurrency[l]); //Call draw icon function
		}
    
    }
    
    function onDownload(timetable){
    	//Load Variables into the View Object
    	if (timetable instanceof TimeTable) {        	
			
			//Get prices and coins, and save in array
			for( var i = 0; i < 10; i++ ) {
				mTime[i] = timetable.timestamp[i];
				mNumber[i] = timetable.vehicle_num[i];
				mDest[i] = timetable.destination[i];
			}
        		//If current prices are fetched, communication is confirmed. By default, false.
        		if (mTime[0] != null) {
        			commConf = true;
        		}
        	//If data is not fetched yet, throw waiting for data msg.
        }else if (timetable instanceof Lang.String) {
        		commConf = false;
       	}
        Ui.requestUpdate(); //Request an update    	
    }

}
