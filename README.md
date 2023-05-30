# TrackSniffer

**TrackSniffer** is a small script that runs on Mac OS: it's intended to help you display the current track name in an OBS Text Source when playing your stream's background music via the Apple Music app.

When you download and run `TrackSniffer.scpt` while playing songs in **Music**, the script will automatically update a text file on your Desktop called `track_name.txt` to contain the name of the current song.

This script is similar to [dzomb's **tuneout** script](https://github.com/dzomb/tuneout), with a few changes:

- It targets `Music.app` instead of the outdated `iTunes.app`
- For simplicity, it uses a hardcoded path _(which you can edit yourself)_ instead of prompting you to choose a file in Finder every time you run it
- It's meant to be run directly from **Script Editor**, without needing to be built to an Application
- It writes the track information to the text file in UTF-8 format, meaning that OBS will display Unicode characters (like the `é` in `Pokémon`) correctly, instead of going blank when you're playing a song with special characters in the title

## How to use this script

1. Download `TrackSniffer.scpt`: you can use [this link](https://raw.githubusercontent.com/awforsythe/TrackSniffer/main/TrackSniffer.scpt) to directly download the file and save it somewhere on your Mac.

2. Double-click the downloaded `TrackSniffer.scpt` file to open it in **Script Editor**.

3. Click the **Play** button in the top-right corner of the **Script Editor** window. This should start the script running, and it should open the **Music** app if it's not already open.

4. You should now have a text file on your Desktop called `track_name.txt`. Whenever the current track changes in **Music**, the new track information should be written to that file.

5. The script will run indefinitely, continually updating the text file every few seconds. In order to stop the script, simply click the **Stop** button or close **Script Editor**.

Once you've confirmed that `track_name.txt` is being updated correctly, you can use it in OBS: add a **Text** source, check the **Read from file** box in its properties, then scroll down to **Text File**, click **Browse**, and select your `track_name.txt` file.

## Customizing the script

As long as you're happy with the default settings, you can just download the script and run it as-is.

If you'd like to change the basic behavior of the script, it's easy to enoguh to do that yourself in Script Editor.

### Changing the output file

At the very top of the script, you'll see a couple of lines that determine where the track information will be written:

```applescript
set OUTPUT_DIRPATH to POSIX path of (path to desktop)
set OUTPUT_FILENAME to "track_name.txt"
```

By default, this causes the script to write a text file called `track_name.txt` on your Desktop.

If you want the script to write to a different text file, then you can change these two lines. For example, if you keep your files for your OBS streaming setup in a subfolder of your Documents folder called "Streaming Stuff", and you want the file to be called `TheCurrentSong.txt`, then you could change these lines to:

```applescript
set OUTPUT_DIRPATH to "/Users/yourusername/Documents/Streaming Stuff/"
set OUTPUT_FILENAME to "TheCurrentSong.txt"
```

...that would give you a file called `TheCurrentSong.txt` in your **Documents** &rarr; **Streaming Stuff** folder.

In the example above, you'd replace `yourusername` with your actual username. If you're not sure what your username is, open **Terminal** and enter `whoami`.

Note that AppleScript will not understand UNIX path placeholders like `~`. Also note that `OUTPUT_DIRPATH` must end with a trailing slash.

### Changing the format of the text

By default, the track information will be presented in this format: `<Track Title> - <Artist>`. This is controlled by this line in the script:

```applescript
set track_text to track_name & " - " & track_artist
```

You can change this line however you want. For example, if you'd prefer `<Artist> - <Track Title>`, you can swap the position of those two variables:

```applescript
set track_text to track_artist & " - " & track_name
```

### Changing the update frequency

By default, the text file will be updated every 5 seconds:

```applescript
set UPDATE_INTERVAL_IN_SECONDS to 5
```

If you need the text file to be updated as soon as possible whenever the track changes, you can reduce this number, e.g.:

```applescript
set UPDATE_INTERVAL_IN_SECONDS to 1
```
