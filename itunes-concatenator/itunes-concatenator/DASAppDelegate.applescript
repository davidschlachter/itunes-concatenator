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
	
    global these_files, these_times, these_titles, the_index, the_pipes, theCounter, cmdPrefix
    
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
    property catAlbumArtist : missing value
    property catYear : missing value
    
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
    property pcatAlbumArtist : ""
    property pcatYear : ""
    
    -- Empty strings for each file name and location
    property pEachName : ""
    property pEachLocation : ""
    
    property these_titles : {}
    property these_files : {}
    property these_times: {}
    property the_index: {}
    property the_pipes: {}
    
    property theCounter : ""
    property cmdPrefix : "if [[ -r /etc/profile ]];then . /etc/profile;fi;if [[ -r ~/.bashrc ]];then . ~/.bashrc;fi;if [[ -r ~/.bash_profile ]];then . ~/.bash_profile;fi;"
    
    on awakeFromNib()
        --
        -- Check for FFMPEG and MP4v2
        --
        -- (This works, but it's ugly!)
        --
        --
        try
            do shell script cmdPrefix & " if [ -x \"`/usr/bin/which ffmpeg`\" ];then exit 0;else exit 1;fi"
        on error number error_number
            display dialog "You must install FFMPEG and MP4v2 to continue. \n\nYou may have to install Xcode Command Line Tools and Homebrew first. If you continue, we'll attempt to install them for you if they are not already present. \n\nIf you have already installed FFMPEG and MP4v2, ensure that they are in your bash path." buttons {"Quit","Install"} default button 2
            If button returned of result is "Install" then
                try
                    tell application "Terminal"
                        -- TODO: This should be cleaner -- Terminal in front, only one window, focus back to the cat'er afterwards
                        set newTab to do script cmdPrefix & "if [[ -x `which brew` ]];then brew install ffmpeg;else /usr/bin/ruby -e \"$(/usr/bin/curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)\";brew install ffmpeg mp4v2;fi"
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
                        -- Get metadata from the first track
                        if i is 1 then
                            set pcatArtist to ((artist of aTrack) as string)
                            set pcatAlbum to ((album of aTrack) as string)
                            set pcatComposer to ((composer of aTrack) as string)
                            set pcatGenre to ((genre of aTrack) as string)
                            set pcatDisc to ((disc number of aTrack) as string)
                            set pcatDiscs to ((disc count of aTrack) as string)
                            set pcatAlbumArtist to ((album artist of aTrack) as string)
                            set pcatYear to ((year of aTrack) as string)
                        end if
                        set i to (i + 1)
                    end if
                end repeat
            end if
        end tell
        -- Display the songs to be concatenated
        -- via http://stackoverflow.com/questions/25537750/setstringvalue-with-applescript-list
        set olddelimeters to AppleScript's text item delimiters
        set AppleScript's text item delimiters to "\n"
        set disp_titles to these_titles as string
        trackTable's setStringValue_(disp_titles)
        set AppleScript's text item delimiters to olddelimeters
        -- Update the default metadata
        catArtist's setStringValue_(pcatArtist)
        catAlbum's setStringValue_(pcatAlbum)
        catComposer's setStringValue_(pcatComposer)
        catGenre's setStringValue_(pcatGenre)
        catDisc's setStringValue_(pcatDisc)
        catDiscs's setStringValue_(pcatDiscs)
        catAlbumArtist's setStringValue_(pcatAlbumArtist)
        catYear's setStringValue_(pcatYear)
    end btnGetTracks_

    on btnConcatenate_(sender)
        -- Update the metadata variables with the user's input
        set pcatName to catName's stringValue()
        set pcatArtist to catArtist's stringValue()
        set pcatAlbum to catAlbum's stringValue()
        set pcatComposer to catComposer's stringValue()
        set pcatGenre to catGenre's stringValue()
        set pcatTrack to catTrack's stringValue()
        set pcatTracks to catTracks's stringValue()
        set pcatDisc to catDisc's stringValue()
        set pcatDiscs to catDiscs's stringValue()
        set pcatAlbumArtist to catAlbumArtist's stringValue()
        set pcatYear to catYear's stringValue()
        set the_pipes to {}
        repeat with theIndex in the_index
            -- TODO: Needs error checking!
            -- TODO: We need to check what kind of audio files we have, then adjust accordingly
            do shell script (cmdPrefix & "ffmpeg -i \"" & (item theIndex of these_files as text) & "\" -c copy -bsf:v h264_mp4toannexb -f mpegts /private/tmp/concat" & theIndex & ".ts 2> /dev/null" as text)
            log ("Processed file number" & theIndex) as text
            set end of the_pipes to ("/private/tmp/concat" & theIndex & ".ts" as text)
        end repeat
        -- Run the actual concatenation command in ffmpeg (for mp4/AAC files only!)
        -- via https://trac.ffmpeg.org/wiki/How%20to%20concatenate%20(join,%20merge)%20media%20files
        set olddelimeters to AppleScript's text item delimiters
        set AppleScript's text item delimiters to "|"
        set disp_thepipes to the_pipes as string
        do shell script (cmdPrefix & "ffmpeg -f mpegts -i \"concat:" & (disp_thepipes as text) & "\" -c copy -bsf:a aac_adtstoasc /private/tmp/cat.mp4")
        set AppleScript's text item delimiters to olddelimeters
        -- Now let's create the chapter file
        repeat with theIndex in the_index
            if theIndex < 2 then
                do shell script ("/bin/echo \"00:00:00.000 " & (item theIndex of these_titles as text) & "\" > /private/tmp/cat.chapters.txt" as text)
                set theCounter to (do shell script (cmdPrefix & "ffprobe -loglevel panic -show_streams /private/tmp/concat" & (theIndex as text) & ".ts | egrep -m 1 'duration=[0-9]+\\.' | sed 's/duration=\\([0-9]*[0-9]\\.[0-9]*\\)/\\1/'" as text) as string)
                set theCounter to (do shell script ("/bin/echo $(/usr/bin/printf %.$2f $(/bin/echo \"`/usr/bin/printf %.3f " & theCounter & "` * 1000\" | /usr/bin/bc))") as string)
            else
                set theDateStamp to do shell script (cmdPrefix & "t="& (theCounter as text) & ";((msec=t%1000, t/=1000, sec=t%60, t/=60, min=t%60, hrs=t/60));timestamp=$(printf \"%02d:%02d:%02d.%03d\" $hrs $min $sec $msec);/bin/echo $timestamp" as text)
                do shell script ("/bin/echo \"" & (theDateStamp as text) & " " & (item theIndex of these_titles as text) & "\" >> /private/tmp/cat.chapters.txt" as text)
                set theNewCounter to do shell script ((cmdPrefix & "ffprobe -loglevel panic -show_streams /private/tmp/concat" & (theIndex as text) & ".ts | egrep -m 1 'duration=[0-9]+\\.' | sed 's/duration=\\([0-9]*[0-9]\\.[0-9]*\\)/\\1/'" as text) as string)
                set theNewCounter to do shell script ("/bin/echo $(/usr/bin/printf %.$2f $(/bin/echo \"`/usr/bin/printf %.3f " & theNewCounter & "` * 1000\" | /usr/bin/bc))") as string
                log "theNewCounter is " & theNewCounter
                set theCounter to (theCounter + theNewCounter)
                log ("Post-addition, theCounter is " & theCounter) as text
            end if
        end repeat
        -- Chapterize cat.mp4
        do shell script (cmdPrefix & "mp4chaps -i /private/tmp/cat.mp4" as text)
        -- Add tags
        do shell script (cmdPrefix & "mp4tags -song \"" & pcatName & "\" -album \"" &  pcatAlbum & "\" -artist \"" &  pcatArtist & "\" -writer \"" &  pcatComposer & "\" -genre \"" &  pcatGenre & "\" -track \"" &  pcatTrack & "\" -tracks \"" &  pcatTracks & "\" -disk \"" &  pcatDisc & "\" -disks \"" &  pcatDiscs & "\" -albumartist \"" & pcatAlbumArtist & "\" -year \"" & pcatYear & "\" /private/tmp/cat.mp4" as text)
        -- Add the finished track to iTunes
        do shell script "/bin/mv /private/tmp/cat.mp4 /private/tmp/cat.m4a"
        tell application "iTunes"
                add file ":private:tmp:cat.m4a"
        end tell
        -- Clean up
        do shell script "/bin/rm /private/tmp/concat* /private/tmp/cat.chapters.txt /private/tmp/cat.m4a"
        set theCounter to ""
    end btnConcatenate_


	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
	end applicationWillFinishLaunching_

	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits
		return current application's NSTerminateNow
	end applicationShouldTerminate_

end script