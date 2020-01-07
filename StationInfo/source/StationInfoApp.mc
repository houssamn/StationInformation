using Toybox.Application;
using Toybox.System as Sys;

class StationInfoApp extends Application.AppBase {

	hidden var Model;
	hidden var View; 
	hidden var Delegate;


    // onStart() is called on application start up
    function onStart(state) {
    	View = new StationInfoView();
    	Model = new StationInfoModel(View.method(:onDownload));
    	Delegate = new StationInfoDelegate();
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [ View, Delegate ];
    }

}