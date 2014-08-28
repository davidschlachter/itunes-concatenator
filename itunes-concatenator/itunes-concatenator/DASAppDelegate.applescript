--
--  DASAppDelegate.applescript
--  itunes-concatenator
--
--  Created by David Schlachter on 2014-08-26.
--  Copyright (c) 2014 Red Eft Software. All rights reserved.
--

-- via http://macscripter.net/viewtopic.php?pid=173787 ; apparently needed for using arrays

script DASAppDelegate
	property parent : class "NSObject"
	
    global these_files, these_times, these_titles, the_index, the_pipes
    
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
    
    -- Empty strings for each file name and location
    property pEachName : ""
    property pEachLocation : ""
    
    property these_titles : {}
    property these_files : {}
    property these_times: {}
    property the_index: {}
    property the_pipes: {}
    
    on awakeFromNib()
        --
        -- Check for FFMPEG
        --
        -- (This works, but it's ugly!)
        --
        --
        try
            do shell script "if [[ -r /etc/profile ]];then . /etc/profile;fi;if [[ -r ~/.bashrc ]];then . ~/.bashrc;fi;if [[ -r ~/.bash_profile ]];then . ~/.bash_profile;fi; if [ -x \"`/usr/bin/which ffmpeg`\" ];then exit 0;else exit 1;fi"
        on error number error_number
            display dialog "You must install FFMPEG to continue. \n\nYou may have to install Xcode Command Line Tools and Homebrew first. If you continue, we'll attempt to install them for you if they are not already present. \n\nIf you have already installed FFMPEG, ensure that it is in your bash path." buttons {"Quit","Install FFMPEG"} default button 2
            If button returned of result is "Install FFMPEG" then
                try
                    tell application "Terminal"
                        -- TODO: This should be cleaner -- Terminal in front, only one window, focus back to the cat'er afterwards
                        set newTab to do script "if [[ -r /etc/profile ]];then . /etc/profile;fi;if [[ -r ~/.bashrc ]];then . ~/.bashrc;fi;if [[ -r ~/.bash_profile ]];then . ~/.bash_profile;fi;if [[ -x `which brew` ]];then brew install ffmpeg;else /usr/bin/ruby -e \"$(/usr/bin/curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)\";brew install ffmpeg;fi"
                        delay 4
                        repeat
                            delay 0.1
                            if not busy of newTab then exit repeat
                        end repeat
                    end tell
                     -- TODO: This needs a better test, i.e., check if ffmpeg is actually accessible on the path
                    display dialog "FFMPEG was successfully installed"
                    -- TODO: This should actually work! (Bring us back to the foreground)
                    activate current application
                on error number error_number
                    display dialog "FFMPEG did not successfully install"
                end try
            end If
            If button returned of result is "Quit" then
                -- Fix!
                current application's NSApp's terminate()
            end If
        end try
    end awakeFromNib


    on btnGetTracks_(sender)
        -- Code to add iTunes tracks to our list
        -- via http://dougscripts.com/itunes/itinfo/info02.php and http://www.randomsequence.com/articles/applescript-to-send-selected-itunes-tracks-using-mail/
        tell application "iTunes"
            set these_titles to {}
            set these_times to {}
            set these_files to {}
            set the_index to {}
            if selection is not {} then -- there ARE tracks selected...
                set mySelection to selection
                set i to 1
                repeat with aTrack in mySelection
                    if class of aTrack is file track then
                        set end of these_titles to ((name of aTrack) as string)
                        set end of these_times to ((time of aTrack) as string)
                        set end of these_files to (posix path of (get location of aTrack))
                        set end of the_index to (count of these_titles)
                    end if
                end repeat
            end if
        end tell
        -- via http://stackoverflow.com/questions/25537750/setstringvalue-with-applescript-list
        set olddelimeters to AppleScript's text item delimiters
        set AppleScript's text item delimiters to "\n"
        set disp_titles to these_titles as string
        trackTable's setStringValue_(disp_titles)
        set AppleScript's text item delimiters to olddelimeters
    end btnGetTracks_

    on btnConcatenate_(sender)
        -- Make the pipes
        set the_pipes to {}
        repeat with theIndex in the_index
            -- TODO: Needs error checking!
            display dialog (item theIndex of these_files as text)
            do shell script ("if [[ -r /etc/profile ]];then . /etc/profile;fi;if [[ -r ~/.bashrc ]];then . ~/.bashrc;fi;if [[ -r ~/.bash_profile ]];then . ~/.bash_profile;fi;ffmpeg -i \"" & (item theIndex of these_files as text) & "\" -c copy -bsf:v h264_mp4toannexb -f mpegts /private/tmp/concat" & theIndex & ".ts 2> /dev/null" as text)
            log ("Processed file number" & theIndex) as text
            set end of the_pipes to ("/private/tmp/concat" & theIndex & ".ts" as text)
        end repeat
        set olddelimeters to AppleScript's text item delimiters
        set AppleScript's text item delimiters to "|"
        set disp_thepipes to the_pipes as string
        do shell script ("if [[ -r /etc/profile ]];then . /etc/profile;fi;if [[ -r ~/.bashrc ]];then . ~/.bashrc;fi;if [[ -r ~/.bash_profile ]];then . ~/.bash_profile;fi;ffmpeg -f mpegts -i \"concat:" & (disp_thepipes as text) & "\" -c copy -bsf:a aac_adtstoasc /private/tmp/cat.mp4")
        set AppleScript's text item delimiters to olddelimeters
    end btnConcatenate_


	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
	end applicationWillFinishLaunching_

	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits
		return current application's NSTerminateNow
	end applicationShouldTerminate_

end script