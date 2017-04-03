HandBrake
=========

This is a Docker container for running [HandBrake](https://handbrake.fr/), video encoder. Both interactive and noninteractive versions are included.

Usage
-----

To use this container for a user interface to HandBrake:

`docker run --name=HandBrakeUI -e WIDTH=1280 -e HEIGHT=720 -p 3389:3389 -p 8080:8080 -v /path/to/movies/dir:/Movies:rw -v /path/to/config:/nobody/.config/ghb:rw sparklyballs/handbrake`

In this mode, the /Movies path in the container is shared with the host, so put movies that you want to convert there, along with the converted movies.

There are two ways to use the interactive user interface. One is to connect to the UI in your web browser with the URL http://host:8080/#/client/c/HandBrake. The second is to connect with a remote desktop client using port 3389. There are RDP clients for multiple platforms:

* Microsoft Remote Desktop for Windows (built into the OS)
* [Microsoft Remote Desktop for OS X](https://itunes.apple.com/us/app/microsoft-remote-desktop/id715768417?mt=12)
* [rdesktop for Linux](http://www.rdesktop.org/)

Of course, if you change the host ports, then when you connect you'll have to specify the server as `<host ip>:<host port>`. Feel free to drop the 3389 mapping if you don't plan to use RDP, or the 8080 mapping if you don't plan to use the web browser.  

If you want to run the container without a UI:

`docker run --name=HandBrakeCLI -v /path/to/watch/dir:/Watch:r -v /path/to/output/dir:/Output:rw -v /path/to/config:/nobody/.config/ghb:rw sparklyballs/handbrake`

In this mode, drop the files into /path/to/watch/dir, and they will be encoded into /path/to/output/dir.

You can also combine all of the flags into one big command, to support both the UI as well as the automated conversion.

Configuration
-------------

After your container is launched the first time, a folder called "Convert-Script" will be created in your config directory. Edit that file to change the settings used for the automatic conversion. Set `DEST_EXT` to the extension (and therefor file format) of the output file. Set `PRESET` to the name of a HandBrake preset. For a complete list of presets, visit [this page](https://handbrake.fr/docs/en/latest/technical/official-presets.html).

You can also configure the monitoring behavior by setting certain Docker container values when running the container (-e flag):

`SETTLE_DURATION`: Default 10. Wait for this amount of seconds for the watch directory to stop getting changes. This prevents HandBrake from running on a partially written file, for instance.

`MAX_WAIT_TIME`: Default 5:00. If the watch directory doesn't settle for `SETTLE_DURATION` within this time, run HandBrake anyway. This is to avoid waiting forever if there is a constant stream of changes to the directory. Note that this will cause HandBrake to operate on incomplete files!

`MIN_PERIOD`: Default 0. Wait at least this amount of time before running HandBrake again. This can be used to force a delay before HandBrake runs again, even if there are more detected changes. The default value of 0 allows back-to-back execution.

For all of the above settings, the time can be in the format HH:MM:SS, MM:SS, or SS.
