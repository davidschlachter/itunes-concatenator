--
--  DASAppDelegate.applescript
--  itunes-concatenator
--
--  Created by David Schlachter on 2014-08-26.
--  Copyright (c) David Schlachter. All rights reserved.
--

-- via http://macscripter.net/viewtopic.php?pid=173787 ; apparently needed for using arrays

script DASAppDelegate
	property parent : class "NSObject"
	
    global these_files, these_times, these_titles, the_index, the_pipes, theCounter, cmdPrefix, randomPrefix
    
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
    property progressField : missing value
    property tocToLyrics : missing value
    
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
    property missingPackages : ""
    property mediaTypeText : ""
    property tocToLyricsValue : ""
    
    -- This set is for the tags
    property fcatName : ""
    property fcatArtist : ""
    property fcatAlbum : ""
    property fcatComposer : ""
    property fcatGenre : ""
    property fcatTrack : ""
    property fcatTracks : ""
    property fcatDisc : ""
    property fcatDiscs : ""
    property fcatAlbumArtist : ""
    property fcatYear : ""
    
    -- Empty strings for each file name and location
    property pEachName : ""
    property pEachLocation : ""
    
    property mediaType : ""
    property theAddedTrack : ""
    
    property these_titles : {}
    property these_files : {}
    property these_times: {}
    property the_index: {}
    property the_pipes: {}
    
    property quitme : 0
    property ffmpegmissing : 0
    
    property theCounter : ""
    property cmdPrefix : "if [[ -r /etc/profile ]];then . /etc/profile;fi;if [[ -r ~/.bashrc ]];then . ~/.bashrc;fi;if [[ -r ~/.bash_profile ]];then . ~/.bash_profile;fi;"
    
    on awakeFromNib()
        -- Check for FFMPEG in the path
        try
            do shell script cmdPrefix & " if [ -x \"`/usr/bin/which ffmpeg`\" ];then exit 0;else exit 1;fi"
            on error number error_number
            set missingPackages to "FFMPEG "
            set ffmpegmissing to 1
        end try
        
        -- Check for MP4v2 in the path
        try
            do shell script cmdPrefix & " if [ -x \"`/usr/bin/which mp4chaps`\" ];then exit 0;else exit 1;fi"
            on error number error_number
            if ffmpegmissing is 1 then
                set missingPackages to "FFMPEG MP4v2"
            else
                set missingPackages to "MP4v2 "
            end if
        end try
        
        set locale to user locale of (get system info)
        if missingPackages is not "" then
            set theySaidYes to false
            if locale starts with "fr" then
                display dialog "Pour continuer, installez les programmes suivants : \n\t" & missingPackages & " \n\nSi vous choissisez l'option \"Installer\", nous tenterons de les installer. Il est possible qu'on vous demande aussi d'installer Xcode Command Line Tools et Homebrew s'ils ne sont présents non plus. \n\nSi vous avez déjà installé FFMPEG et MP4v2, veiller à ce qu'ils sont dans votre PATH." buttons {"Quitter","Installer"} default button 2
                if result = {button returned:"Installer"} then
                    set theySaidYes to true
                end if
            else
                display dialog "You must install the following programs to continue: \n\t" & missingPackages & " \n\nYou may have to install Xcode Command Line Tools and Homebrew first. If you continue, we'll attempt to install them for you if they are not already present. \n\nIf you have already installed FFMPEG and MP4v2, ensure that they are in your bash path." buttons {"Quit","Install"} default button 2
                if result = {button returned:"Install"} then
                    set theySaidYes to true
                end if
            end if
            if theySaidYes then
                tell application "Terminal"
                    set newTab to do script cmdPrefix & "if [[ -x `which brew` ]];then brew update;brew install ffmpeg mp4v2 && exit 0;else /usr/bin/ruby -e \"$(/usr/bin/curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\";brew update;brew install ffmpeg mp4v2 && exit 0;fi"
                    delay 1
                    activate
                    -- Check for when the Terminal is done
                    try
                        repeat
                            delay 0.2
                            if not busy of newTab then exit repeat
                        end repeat
                    end try
                end tell
                -- Check if installation was successful
                try
                    do shell script cmdPrefix & " if [ -x \"`/usr/bin/which ffmpeg`\" -a -x \"`/usr/bin/which mp4chaps`\" ];then exit 0;else exit 1;fi"
                    tell application "Terminal" to quit
                    activate
                    set locale to user locale of (get system info)
                    if locale starts with "fr" then
                        display dialog "L'installation a réussi." buttons {"OK"} default button "OK"
                    else
                        display dialog "Installation was successful!" buttons {"OK"} default button "OK"
                    end if
                on error error_number
                    activate
                    set locale to user locale of (get system info)
                    if locale starts with "fr" then
                        display dialog "Homebrew, FFMPEG et / ou MP4v2 ne pouvaient pas être installés. Vérifiez les messages dans Terminal pour plus d'information."
                    else
                        display dialog "Homebrew, FFMPEG and/or MP4v2 could not be installed. Check the Terminal for error messages and additional information."
                    end if
                    set quitme to 1 -- Exit if we couldn't install!
                end try
                else if result = {button returned:"Quit"} then
                    set quitme to 1
                    return current application's NSTerminateNow
            end if
        end if
    end awakeFromNib


    on btnGetTracks_(sender)
        -- Code to add iTunes tracks to our list
        -- via http://dougscripts.com/itunes/itinfo/info02.php and http://www.randomsequence.com/articles/applescript-to-send-selected-itunes-tracks-using-mail/
        -- New in 2020: messily duplicate this code so as to use either iTunes or the Music app depending on the macOS version (if at least Catalina, use the Music app)
        set _versionString to system version of (system info)
        considering numeric strings
            set hasMusicApp to _versionString ≥ "10.15"
        end considering
        if hasMusicApp then
            tell application id "com.apple.Music"
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
        else
            tell application id "com.apple.iTunes"
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
        end if
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
        -- Reset the name and track fields
        catName's setStringValue_("")
        catTrack's setStringValue_("")
        catTracks's setStringValue_("")
    end btnGetTracks_

    on btnConcatenate_(sender)
        set locale to user locale of (get system info)
        -- Generate the random prefix
        -- via http://macscripter.net/viewtopic.php?id=12212
        set randomPrefix to ""
        repeat with x from 1 to 6
            set randomChar to ASCII character (random number from 97 to 122)
            set randomPrefix to randomPrefix & randomChar
        end repeat
        set randomPrefix to randomPrefix & "_"
        
        -- Update the metadata variables with the user's input
        if catName's stringValue() is not "" then set pcatName to catName's stringValue()
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
        set mediaTypeText to "Music track"
        set tocToLyricsValue to (tocToLyrics's state())
        
        -- Initialize some variables
        set errorHappened to false
        set notaac to false
        set bitrate to 0
         -- Check if the audio files are all aac / mp4a
        if locale starts with "fr" then
            progressField's setStringValue_("Déterminant le type des fichiers...")
        else
            progressField's setStringValue_("Determining filetypes...")
        end if
         delay 0.2
        repeat with theIndex in the_index
            set thefile to (quoted form of POSIX path of (item theIndex of these_files as text))
            if not notaac
                try
                    do shell script (cmdPrefix & "if [ `ffprobe -show_streams -select_streams a " & thefile & "  2>/dev/null | grep -c \"mp4a\\|aac\"` -gt 0 ]; then exit 0; else exit 1; fi")
                on error number error_number
                    set notaac to true
                end try
            end if
            try
                set newbitrate to (do shell script (cmdPrefix & "ffprobe -show_streams -select_streams a " & thefile & " 2>/dev/null | grep '^bit_rate=' | sed 's/bit_rate=\\([0-9][0-9]*\\)/\\1/' | sed 's/\\(.*\\).\\{3\\}/\\1/'") as text)
                if (newbitrate as number) is greater than (bitrate as number) then set bitrate to (newbitrate as number)
            end try
        end repeat
        set bitrate to bitrate as number
        if bitrate = 0 then set bitrate to 256
        -- Create the concatenated intermediate file
        if not notaac then
            -- Concatenation routine for mp4/aac files
            try
                repeat with theIndex in the_index
                    if locale starts with "fr" then
                        progressField's setStringValue_("Préparant la piste " & (theIndex as text) & "..." as text)
                    else
                        progressField's setStringValue_("Preparing track " & (theIndex as text) & "..." as text)
                    end if
                    delay 0.2
                    do shell script (cmdPrefix & "ffmpeg -i " & (quoted form of POSIX path of (item theIndex of these_files as text)) & " -c copy -vn -f mpegts -loglevel fatal -vn /private/tmp/" & randomPrefix & "concat" & theIndex & ".ts" as text)
                    set end of the_pipes to ("/private/tmp/" & randomPrefix & "concat" & theIndex & ".ts" as text)
                end repeat
            on error error_number number therror
                set errorHappened to true
                do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat*"
                progressField's setStringValue_("")
                if locale starts with "fr" then
                    display dialog "Les pistes séléctionnées n'ont pas été fusionnées. Une erreur s'est produite lors de la préparation des fichiers intermédiaires. Le code d'erreur était " & therror & ": " & error_number
                else
                    display dialog "The tracks you selected could not be joined. An error occured when preparing the intermediate files. The error code was " & therror & ": " & error_number
                end if
            end try
            try
                set olddelimeters to AppleScript's text item delimiters
                set AppleScript's text item delimiters to "|"
                set disp_thepipes to the_pipes as string
                if locale starts with "fr" then
                    progressField's setStringValue_("Fusionnant les pistes...")
                else
                    progressField's setStringValue_("Concatenating tracks...")
                end if
                delay 0.2
                do shell script (cmdPrefix & "ffmpeg -f mpegts -i \"concat:" & (disp_thepipes as text) & "\" -c copy -vn -bsf:a aac_adtstoasc -loglevel fatal /private/tmp/" & randomPrefix & "cat.mp4" as text)
                set AppleScript's text item delimiters to olddelimeters
            on error error_number number therror
                set errorHappened to true
                do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat* /private/tmp/" & randomPrefix & "cat.mp4"
                progressField's setStringValue_("")
                if locale starts with "fr" then
                    display dialog "Les pistes séléctionnées n'ont pas été fusionnées. Le code d'erreur était " & therror & ": " & error_number
                else
                    display dialog "The tracks could not be joined. The error code was " & therror & ": " & error_number
                end if
            end try
            else
            -- Concatenation routine for non-mp4/aac audio files
            try
                repeat with theIndex in the_index
                    if locale starts with "fr" then
                        progressField's setStringValue_("Préparant la piste " & (theIndex as text) & "..." as text)
                    else
                        progressField's setStringValue_("Preparing track " & (theIndex as text) & "..." as text)
                    end if
                    delay 0.2
                    -- No spaces allowed in paths for the script...
                    do shell script ("/bin/cp " & (quoted form of POSIX path of (item theIndex of these_files as text)) & " /private/tmp/" & randomPrefix & "concat" & theIndex & ".ts" as text)
                    set end of the_pipes to (randomPrefix & "concat" & theIndex & ".ts" as text)
                end repeat
            on error error_number number therror
                set errorHappened to true
                do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat*"
                progressField's setStringValue_("")
                if locale starts with "fr" then
                    display dialog "Les pistes séléctionnées n'ont pas été fusionnées. Une erreur s'est produite lors de la préparation des fichiers intermédiaires. Le code d'erreur était " & therror & ": " & error_number
                else
                    display dialog "The tracks you selected could not be joined. An error occured when preparing the intermediate files. The error code was " & therror & ": " & error_number
                end if
            end try
            set olddelimeters to AppleScript's text item delimiters
            set AppleScript's text item delimiters to " "
            set disp_thepipes to the_pipes as string
            if locale starts with "fr" then
                progressField's setStringValue_("Fusionnant les pistes...")
            else
                progressField's setStringValue_("Concatenating tracks...")
            end if
            delay 0.2
            try
                set scriptpath to (quoted form of POSIX path of (current application's NSBundle's mainBundle()'s bundlePath() as text & "/Contents/Resources/mmcat.sh")) & " "
                do shell script "cd /private/tmp/ && " & scriptpath & (bitrate as text) & " " & (disp_thepipes as text) & " " & randomPrefix & "cat.mp4"
            on error error_number number therror
                set errorHappened to true
                do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat* /private/tmp/" & randomPrefix & "cat.mp4"
                progressField's setStringValue_("")
                if locale starts with "fr" then
                    display dialog "Les pistes séléctionnées n'ont pas été fusionnées. Une erreur s'est produite lors du réencodage. Le code d'erreur était " & therror & ": " & error_number
                else
                    display dialog "The tracks could not be joined. An error occured during the reencoding. The error code was " & therror & ": " & error_number
                end if
            end try
            set AppleScript's text item delimiters to olddelimeters
        end if
        -- Now let's create the chapter file
        if not errorHappened then
            if locale starts with "fr" then
                progressField's setStringValue_("Preparant les chapitres...")
            else
                progressField's setStringValue_("Preparing chapters...")
            end if
            delay 0.2
            try
                repeat with theIndex in the_index
                    if theIndex < 2 then
                        do shell script ("/bin/echo \"00:00:00.000 " & (item theIndex of these_titles as text) & "\" > /private/tmp/" & randomPrefix & "cat.chapters.txt" as text)
                        set theCounter to (do shell script (cmdPrefix & "ffprobe -loglevel panic -show_streams /private/tmp/" & randomPrefix & "concat" & (theIndex as text) & ".ts | egrep -m 1 'duration=[0-9]+\\.' | sed 's/duration=\\([0-9]*[0-9]\\.[0-9]*\\)/\\1/'" as text) as string)
                        set theCounter to (do shell script ("/bin/echo $(/usr/bin/printf %.$2f $(/bin/echo \"`/usr/bin/printf %.3f " & theCounter & "` * 1000\" | /usr/bin/bc))") as string)
                    else
                        set theDateStamp to do shell script (cmdPrefix & "t="& (theCounter as text) & ";((msec=t%1000, t/=1000, sec=t%60, t/=60, min=t%60, hrs=t/60));timestamp=$(printf \"%02d:%02d:%02d.%03d\" $hrs $min $sec $msec);/bin/echo $timestamp" as text)
                        do shell script ("/bin/echo \"" & (theDateStamp as text) & " " & (item theIndex of these_titles as text) & "\" >> /private/tmp/" & randomPrefix & "cat.chapters.txt" as text)
                        set theNewCounter to do shell script ((cmdPrefix & "ffprobe -loglevel panic -show_streams /private/tmp/" & randomPrefix & "concat" & (theIndex as text) & ".ts | egrep -m 1 'duration=[0-9]+\\.' | sed 's/duration=\\([0-9]*[0-9]\\.[0-9]*\\)/\\1/'" as text) as string)
                        set theNewCounter to do shell script ("/bin/echo $(/usr/bin/printf %.$2f $(/bin/echo \"`/usr/bin/printf %.3f " & theNewCounter & "` * 1000\" | /usr/bin/bc))") as string
                        set theCounter to (theCounter + theNewCounter)
                    end if
                end repeat
            on error error_number number therror
                set errorHappened to true
                do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat* /private/tmp/" & randomPrefix & "cat.mp4 /private/tmp/" & randomPrefix & "cat.chapters.txt"
                progressField's setStringValue_("")
                if locale starts with "fr" then
                    display dialog "Les chapitres ne pouvaient pas être créés à partir des pistes sélectionnées. Le code d'erreur était " & therror & ": " & error_number
                else
                    display dialog "The chapters could not be read from the tracks you had selected. The error code was " & therror & ": " & error_number
                end if
            end try
        end if
        -- Chapterize cat.mp4
        if not errorHappened then
            try
                if locale starts with "fr" then
                    progressField's setStringValue_("Ajout des chapitres...")
                else
                    progressField's setStringValue_("Chapterizing...")
                end if
                delay 0.2
                do shell script (cmdPrefix & "mp4chaps -i /private/tmp/" & randomPrefix & "cat.mp4" as text)
            on error error_number number therror
                set errorHappened to true
                do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat* /private/tmp/" & randomPrefix & "cat.mp4 /private/tmp/" & randomPrefix & "cat.chapters.txt"
                progressField's setStringValue_("")
                if locale starts with "fr" then
                    display dialog "The chapters could not be added to concatenated file. The error code was " & therror & ": " & error_number
                else
                    display dialog "Les chapitres n'ont pas pu être ajoutés au fichier fusionné. Le code d'erreur était " & therror & ": " & error_number
                end if
            end try
        end if
        -- Prepare tags
        if pcatName is not "" then set fcatName to (" -song " & quoted form of (pcatName as text) & " ")
        if fcatName contains "\"\"" then set fcatName to ""
        if pcatAlbum is not "" then set fcatAlbum to (" -album " & quoted form of (pcatAlbum as text) & " ")
        if fcatAlbum contains "\"\"" then set fcatAlbum to ""
        if pcatArtist is not "" then set fcatArtist to (" -artist " & quoted form of (pcatArtist as text) & " ")
        if fcatArtist contains "\"\"" then set fcatArtist to ""
        if pcatComposer is not "" then set fcatComposer to (" -writer " & quoted form of (pcatComposer as text) & " ")
        if fcatComposer contains "\"\"" then set fcatComposer to ""
        if pcatGenre is not "" then set fcatGenre to (" -genre " & quoted form of (pcatGenre as text) & " ")
        if fcatGenre contains "\"\"" then set fcatGenre to ""
        if pcatTrack is not "" then set fcatTrack to (" -track \"" & pcatTrack & "\" ")
        if fcatTrack contains "\"\"" then set fcatTrack to ""
        if pcatTracks is not "" then set fcatTracks to (" -tracks \"" & pcatTracks & "\" ")
        if fcatTracks contains "\"\"" then set fcatTracks to ""
        if pcatDisc is not "" then set fcatDisc to (" -disk \"" & pcatDisc & "\" ")
        if fcatDisc contains "\"\"" then set fcatDisc to ""
        if pcatDiscs is not "" then set fcatDiscs to (" -disks \"" & pcatDiscs & "\" ")
        if fcatDiscs contains "\"\"" then set fcatDiscs to ""
        if pcatAlbumArtist is not "" then set fcatAlbumArtist to (" -albumartist " & quoted form of (pcatAlbumArtist as text) & " ")
        if fcatAlbumArtist contains "\"\"" then set fcatAlbumArtist to ""
        if pcatYear is not "" then set fcatYear to (" -year \"" & pcatYear & "\" ")
        if fcatYear contains "\"\"" then set fcatYear to ""
        -- Add tags
        if not errorHappened then
            try
                if locale starts with "fr" then
                    progressField's setStringValue_("Ajout des balises...")
                else
                    progressField's setStringValue_("Adding tags...")
                end if
                delay 0.2
                do shell script (cmdPrefix & "mp4tags " & fcatName & fcatAlbum & fcatArtist & fcatComposer & fcatGenre & fcatTrack & fcatTracks & fcatDisc & fcatDiscs & fcatAlbumArtist & fcatYear & " /private/tmp/" & randomPrefix & "cat.mp4" as text)
            on error error_number number therror
                set errorHappened to true
                do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat* /private/tmp/" & randomPrefix & "cat.mp4 /private/tmp/" & randomPrefix & "cat.chapters.txt"
                progressField's setStringValue_("")
                if locale starts with "fr" then
                    display dialog "Les balises n'ont pas pu être ajoutées au fichier audio fusionné. Le code d'erreur était " & therror & ": " & error_number
                else
                    display dialog "The tags could not be added to the concatenated audio file. The error code was " & therror & ": " & error_number
                end if
            end try
        end if
        -- Grab the TOC, if needed
        if not errorHappened then
            if tocToLyricsValue is 1 then
                if locale starts with "fr" then
                    progressField's setStringValue_("Ajout de la table des matières...")
                else
                    progressField's setStringValue_("Getting TOC...")
                end if
                delay 0.2
                try
                    set tocText to (do shell script "/bin/cat /private/tmp/" & randomPrefix & "cat.chapters.txt")
                on error error_number number therror
                    set errorHappened to true
                    do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat* /private/tmp/" & randomPrefix & "cat.mp4 /private/tmp/" & randomPrefix & "cat.chapters.txt"
                    progressField's setStringValue_("")
                    if locale starts with "fr" then
                        display dialog "Une erreur s'est produite lors de l'ajout de la table des matières. Le code d'erreur était " & therror & ": " & error_number
                    else
                        display dialog "The TOC could not be processed. The error code was " & therror & ": " & error_number
                    end if
                end try
            end if
        end if
        -- Add the finished track to iTunes
        if not errorHappened then
            set _versionString to system version of (system info)
            considering numeric strings
                set hasMusicApp to _versionString ≥ "10.15"
            end considering
            if hasMusicApp then
                if locale starts with "fr" then
                    progressField's setStringValue_("Ajout à l'appli Musique...")
                else
                    progressField's setStringValue_("Adding to Music app...")
                end if
            else
                if locale starts with "fr" then
                    progressField's setStringValue_("Ajout à iTunes...")
                else
                    progressField's setStringValue_("Adding to iTunes...")
                end if
            end if
            delay 0.2
            try
                if mediaTypeText is "Music track" then
                    set mediaType to "m4a" as text
                else if mediaTypeText is "Audiobook track" then
                    set mediaType to "m4b" as text
                end if
                do shell script ("/bin/mv /private/tmp/" & randomPrefix & "cat.mp4 /private/tmp/" & randomPrefix & "cat." & mediaType as text)
                -- Again, check if we're on Catalina or not
                set _versionString to system version of (system info)
                considering numeric strings
                    set hasMusicApp to _versionString ≥ "10.15"
                end considering
                if hasMusicApp then
                    tell application id "com.apple.Music"
                        set aliasPath to POSIX file ("/private/tmp/" & randomPrefix & "cat." & mediaType as text) as alias
                        set theAddedTrack to (add aliasPath)
                    end tell
                else
                    tell application id "com.apple.iTunes"
                        set aliasPath to POSIX file ("/private/tmp/" & randomPrefix & "cat." & mediaType as text) as alias
                        set theAddedTrack to (add aliasPath)
                    end tell
                end if
            on error error_number number therror
                set errorHappened to true
                do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat* /private/tmp/" & randomPrefix & "cat.mp4 /private/tmp/" & randomPrefix & "cat.chapters.txt /private/tmp/" & randomPrefix & "cat." & mediaType
                progressField's setStringValue_("")
                if locale starts with "fr" then
                    display dialog "Le fichier fusionné n'a pas pu être ajouté à iTunes ou à l'appli Musique. Le code d'erreur était " & therror & ": " & error_number
                else
                    display dialog "The concatenated file could not be added to iTunes or the Music app.  The error code was " & therror & ": " & error_number
                end if
            end try
        end if
        if not errorHappened and tocToLyricsValue is 1 then
            progressField's setStringValue_("Ajout de la table de matières...")
            -- Apparently fails if file is accessed too quickly
            -- https://bugs.launchpad.net/maxosx/+bug/368342
            delay 2
            try
                set _versionString to system version of (system info)
                considering numeric strings
                    set hasMusicApp to _versionString ≥ "10.15"
                end considering
                if hasMusicApp then
                    tell application id "com.apple.Music"
                            set lyrics of theAddedTrack to tocText
                    end tell
                else
                    tell application id "com.apple.iTunes"
                           set lyrics of theAddedTrack to tocText
                   end tell
                end if
            on error error_number number therror
            	try
            		progressField's setStringValue_("Pause de dix secondes...")
            		delay 9
            		progressField's setStringValue_("Ajout de la table de matières...")
            		delay 1
                    set _versionString to system version of (system info)
                    considering numeric strings
                        set hasMusicApp to _versionString ≥ "10.15"
                    end considering
                    if hasMusicApp then
                        tell application id "com.apple.Music"
                                set lyrics of theAddedTrack to tocText
                        end tell
                    else
                        tell application id "com.apple.iTunes"
                                set lyrics of theAddedTrack to tocText
                        end tell
                    end if
            	on error innererror number innererrornumber
            		set errorHappened to true
                	do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat* /private/tmp/" & randomPrefix & "cat.mp4 /private/tmp/" & randomPrefix & "cat.chapters.txt /private/tmp/" & randomPrefix & "cat." & mediaType
                	progressField's setStringValue_("")
                	set the clipboard to tocText
                    if locale starts with "fr" then
                        display dialog "Erreur lors d'ajouter la table de matières à la balise de paroles. Le code d'erreur était " & innererrornumber & ": " & innererror & " La table des matières a été copiée dans le presse-papiers."
                    else
                        display dialog "The lyrics tag for the TOC could not be set in iTunes or the Music app. The error code was " & innererrornumber & ": " & innererror & " The TOC has been copied to the clipboard instead."
                    end if
            	end try
            end try
        end if
        -- Clean up
        do shell script "/bin/rm -f /private/tmp/" & randomPrefix & "concat* /private/tmp/" & randomPrefix & "cat.chapters.txt /private/tmp/" & randomPrefix & "cat.m4*"
        set theCounter to ""
        progressField's setStringValue_("")
    end btnConcatenate_


	on applicationWillFinishLaunching_(aNotification)
        -- Insert code here to initialize your application before any files are opened
        if quitme is 1 then
            tell me to quit
        end if
	end applicationWillFinishLaunching_

	on applicationShouldTerminate_(sender)
		-- Insert code here to do any housekeeping before your application quits
		return current application's NSTerminateNow
	end applicationShouldTerminate_

end script

