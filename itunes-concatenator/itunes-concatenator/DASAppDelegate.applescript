--
--  DASAppDelegate.applescript
--  itunes-concatenator
--
--  Created by David Schlachter on 2014-08-26.
--  Copyright (c) 2014 Red Eft Software. All rights reserved.
--

-- via http://macscripter.net/viewtopic.php?pid=173787 ; apparently needed for using arrays
property NSMutableArray : class "NSMutableArray"


script DASAppDelegate
	property parent : class "NSObject"
	
	-- IBOutlets
	property window : missing value
    property trackTable : missing value
    property catName : missing value
    property catArtist : missing value
    property catAlbum : missing value
    property catComposer : missing value
    property catGenre : missing value
    property catTrack : missing value
    property catTracks : missing value
    property catDisc : missing value
    property catDiscs : missing value
    
    -- Again, per macscripter, we'll set up bindings for the options
    property pcatName : ""
    property pcatArtist : ""
    property pcatAlbum : ""
    property pcatComposer : ""
    property pcatGenre : ""
    property pcatTrack : ""
    property pcatTracks : ""
    property pcatDisc : ""
    property pcatDiscs : ""
    
    -- Run NSTask to see if ffmpeg is installed...

    
    
	
	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened 
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits 
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script