-- Text file where we should write the current track name while this script is running
set OUTPUT_DIRPATH to POSIX path of (path to desktop)
set OUTPUT_FILENAME to "track_name.txt"

-- How frequently we should re-check the current track name and update the text file
set UPDATE_INTERVAL_IN_SECONDS to 5

-- Run a loop every few seconds that updates our text file with the current track name
repeat
	-- Format a track_text string by asking Apple Music what song is playing
	tell application "Music"
		if player state is playing then
			-- "$name - $artist" if artist is set; just "$name" otherwise
			set track_name to name of current track
			set track_artist to artist of current track
			if track_artist = "" then
				set track_text to track_name
			else
				set track_text to track_name & " - " & track_artist
			end if
		else
			-- track_text should be empty if nothing is playing
			set track_text to ""
		end if
	end tell
	
	-- Write track_text to our ouput file, overwriting the full contents every time
	set fp to open for access (OUTPUT_DIRPATH & OUTPUT_FILENAME) with write permission
	set eof of fp to 0
	write track_text to fp as «class utf8»
	close access fp
	
	-- Wait a moment before doing all this again (to exit, stop the script)
	delay UPDATE_INTERVAL_IN_SECONDS
end repeat
