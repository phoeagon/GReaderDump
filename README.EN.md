Reader Dump — Google Reader Export Tool & Reader Amber Project
===========================================================

Reader Dump is a utility for exporting all subscribed feeds from Google Reader.

Author: phoeagon
*Date: Apr 25, 2013*

Translated Sept 27, 2025.
_This is largely for historical references only. Google Reader has been turned down a decade ago and the data is no longer available for export._

## Introduction

Reader Dump is a tool for exporting all articles from feeds subscribed through Google Reader.

Although Google provides an export function via Google Takeout, it only includes RSS URLs and starred items.
Reader Dump goes further by exporting the full feed content stored by Google Reader.

### Reader Amber Project

The Reader Amber Project is an initiative to preserve and archive content once available in Google Reader, particularly from websites that are no longer accessible.

Google Reader maintained an internal archive of feed items dating back to when the first user subscribed to that feed. Later subscribers could view this historical data, even if it was no longer available on the original site.

After Reader shuts down, much of this valuable content risks being lost forever.

Our goal:

+ Encourage users to export their feeds before shutdown.
+ Collect and archive non-private data into a permanent “museum-like” repository.
+ Provide future access to information that would otherwise disappear.

Default archive downloads (user-contributed feeds):
[http://db.tt/lHrtv5t4]

## How You Can Contribute

If you used this tool successfully
Allow the included script to upload your downloaded feeds automatically.

If you migrated to another reader
Please consider sending us your subscriptions.xml file:

bash dropbox_uploader.sh subscriptions.xml Public/`md5sum subscriptions.xml`_subscriptions.xml


Note: Dropbox credentials for automatic upload have been revoked, but the archive link above remains accessible.

If you want to help maintain the project
Contact the author directly by email.

## License

Reader Dump is licensed under the Apache License 2.0.

Copyright 2013

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy at:

   http://www.apache.org/licenses/LICENSE-2.0


This package also includes a script distributed under the GPL:

dropbox_uploader by Andrea Fabrizi (andrea.fabrizi@gmail.com
)

Adapted for this package and released under GPL.

Since Reader Dump runs independently without this uploader, the overall project is distributed under Apache License.

## Installation
### Requirements

Linux environment

bash shell (default on most Linux distributions)

curl

Python 2.x

This tool has been tested on:
Ubuntu 12.04 + curl 7.22.0 + Python 2

Installing dependencies (Ubuntu)
sudo apt-get install curl python

### Deployment

Extract Reader Dump to a Linux filesystem (e.g., ext3, ext4).

Note: NTFS and FAT filesystems are not supported due to missing executable permission bits.

Usage
Step 1: Export cookies.txt

Log into Google Reader in your browser.

Install one of the following extensions:

Firefox: Export Cookies

Chrome: Cookies.txt Export

Export the cookies.txt file.

(This step may not be strictly necessary, but exporting without login is untested. Some reports suggest issues with feed content. Use at your own risk.)

Step 2: Export subscription list

Download your data from Google Takeout.
Extract subscriptions.xml from youraccount@gmail.com-takeout.zip and place it in the Reader Dump directory.

Step 3: Run Reader Dump
./python reader_dump.py subscriptions.xml


Feeds will be saved to the data directory.

Large feeds (e.g., cnBeta) may take significant time.

The process runs in the background; closing the terminal hides progress but downloads will continue.

### Step 4: Contribute to the Amber Project

By default, the included script uploads exported files to our shared archive.

If your export includes sensitive or private data, disable the upload by stopping:

./dropbox_uploader.sh

### Advanced Configuration
#### Proxy Settings

Edit new.sh and locate the proxy configuration section:

Disable proxy: remove # before PROXY=""

Enable proxy: configure, for example:

PROXY="http://127.0.0.1:8087/"

#### HTTPS Certificate Settings

By default, Reader Dump enforces SSL certificate validation.

Options:

# Insecure HTTPS (ignore certificate errors)
url="-k https://www.google.com/reader/atom/feed/"

# Force HTTPS
#url="https://www.google.com/reader/atom/feed/"

# Use HTTP
#url="http://www.google.com/reader/atom/feed/"


Uncomment the option you want, then rerun the program.

## FAQ
Q: This tool has bugs.

A: Yes. Some bugs (like feed overwrites with the same name) remain unresolved due to time constraints before Google Reader’s shutdown (July 1, 2013).
The tool is “just barely usable.” Contributions are welcome.

Q: It’s hard to use.

A: If you could access Google Reader in China, you can manage this tool too. :)

Q: Missing features?

A: Prioritizing a minimal working release was more important than a feature-complete one. Exporting is generally a one-time task.

Q: Small issues I can fix manually?

Feed overwrites: rename feeds in subscriptions.xml to avoid duplicates.

Selective export: delete unwanted <outline> entries in subscriptions.xml.

Q: Will there be a Windows/non-*Nix version?

A: Unlikely. The heavy use of bash makes porting difficult.

Q: Why “Amber Project” instead of “Ark Project”?

A: Reader is unlikely to return, nor will there be a product that perfectly imports this archive.
Like insects preserved in amber: they may never live again, but future generations can still study them.

Q: Recommended Reader alternatives?

A: If you have a VPS, hosting NewsBlur is a good option.
