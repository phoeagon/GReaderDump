#!/usr/bin/env python

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

import sys
import xml.etree.ElementTree as ET
from subprocess import Popen
import unicodedata
import urllib

################# print licensing info ################
print 
print "Reader Dump"
print "\t\t\t a Google Reader exporter"
print "-----------------------------------------------------------------"
print 
print "       Copyright 2013   phoeagon (http://about.me/phoeagon)   "
print " Licensed under the Apache License, Version 2.0 (the \"License\");"
print " you may not use this file except in compliance with the License."
print " You may obtain a copy of the License at"
print
print "     http://www.apache.org/licenses/LICENSE-2.0"
print
print "Unless required by applicable law or agreed to in writing, software"
print "distributed under the License is distributed on an \"AS IS\" BASIS,"
print "WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied."
print "See the License for the specific language governing permissions and"
print "limitations under the License."
print
print "----------------------------------------------"
print

#   print len(sys.argv)
if (len(sys.argv)<2):
    print "usage: ./reader_dump.py [subscriptions.xml]"
    exit(1)

xml_file=sys.argv[1]


tree = ET.parse( xml_file )
root = tree.getroot()
for node in root.iter("outline"):
    #print node
    name = node.get('title')
    xmlurl = node.get('xmlUrl')
    #print (xmlurl is None)or (name is None)
    if  (xmlurl is None) or (name is None):
        print "#"
    else:
        #print "a"
        #print unicode(xmlurl+u' \"'+name+"/"+name+u'.rss\"')
        url = urllib.quote(xmlurl, '')
        name = name.replace('/',"_");
        Popen(['./download.sh',url,unicode(u'./data/'+name+u'.rss')]);
    #print "\"", name , "\"", xmlurl
