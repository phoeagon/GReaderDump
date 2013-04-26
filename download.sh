#!/bin/bash
#######################################################################
#
#       Reader Dump
#           by phoeagon (http://about.me/phoeagon)
#
#      a google reader exporter that downloads ALL your articles in feeds
#
#       distributed & licensed as described in Apache License
#
#######################################################################
#
#       This package is provided on an "as-is" base
#       WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
#       either express or implied.
#
#######################################################################
#
#       Whether exporting such material violates Google's Terms of Service,
#       or whether violates the copyright laws in your area or any regions
#       of the world, is not known.
#       Other intellectual property related issues may also arise from your
#       use.
#       YOU HAVE BEEN WARNED ABOUT THIS,
#       by using this software YOU AGREED TO TAKE ON ANY RESPONSIBILITY
#       related to such issues.
#
#######################################################################
#
#       this file contains a script invoked by reader_dump.py
#       to download feed from google
#
#######################################################################


######################################################################
#           Configuration
######################################################################
#  BASE URL SETTING
#    uncomment the following line if you want to use insecure HTTPS( ignore cert error )
url="-k https://www.google.com/reader/atom/feed/"
#   uncomment the following line if you want to force HTTPS
#url="https://www.google.com/reader/atom/feed/"
#   uncomment the following line if you want to use HTTP
#url="http://www.google.com/reader/atom/feed/"

######################################################################
# PROXY SETTING
# uncomment and edit the next line to use proxy
#PROXY="-x http://127.0.0.1:8087"
# uncomment the next line to disable proxy
PROXY=""

######################################################################
# COOKIE file name
cookie="cookies.txt"
#####################################################################


#
############# START of the SCRIPT ##################################
#
if [ $# -eq 0 ];
then
    echo "[usage:] cmd [url] [destfile]"
    exit
fi;

mkdir data 2>/dev/null

dest=$2
feedurl=$1

######################################################################
######### GET first page #############################################
echo "iteration #"
directurl=$url$feedurl"?n=1000"
res=`curl -c $cookie -b $cookie --retry 5 --connect-timeout 60 $PROXY $directurl 2>/dev/null`

echo $res >"$dest"

#################### repeatedly ask for next page
while ( echo $res | grep -q "gr:continuation" );
do
    echo $dest," iteration #"
    continuation=`echo $res | grep -o -P "(?<=<gr:continuation>)[^<]+(?=</gr:continuation)" `
    #echo $continuation
    if [ $continuation == "" ];then break;fi
    #echo continuation: $continuation
    directurl=$url$feedurl"?n=1000&c="$continuation
    res=`curl -c $cookie -b $cookie --retry 5 --connect-timeout 60 $PROXY $directurl 2>/dev/null`
    echo $res >>"$dest"
done;

#########################################################3\
# cleaning up exessive <feed> tag
#
#   clear <feed>
sed -e "s/<feed[^>]\+>//"\
    -e "s|</feed>||"\
    -e "s/<?xml[^?]\+?>//"\
    -i "$dest"
echo "<?xml version=\"1.0\"?><feed xmlns:media=\"http://search.yahoo.com/mrss/\" xmlns:gr=\"http://www.google.com/schemas/reader/atom/\" xmlns:idx=\"urn:atom-extension:indexing\" xmlns=\"http://www.w3.org/2005/Atom\" idx:index=\"no\" gr:dir=\"ltr\"><!-- $feedurl $dest -->" | \
    cat - "$dest" >"$dest.tmp"
echo "</feed>" | cat "$dest.tmp" - >"$dest"
rm "$dest".tmp

################################################################


echo "finish"
echo
echo "Now uploading to Dropbox..."
echo "You can terminate the process at any time"
bash dropbox_uploader.sh upload "$dest" "Feed/$dest.`md5sum "$dest"`.rss"

###################################################################
