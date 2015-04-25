#!/bin/bash

if [[ -r /etc/profile ]];then . /etc/profile;fi;if [[ -r ~/.bashrc ]];then . ~/.bashrc;fi;if [[ -r ~/.bash_profile ]];then . ~/.bash_profile;fi

# location of temp folder
TMP=/tmp

################################################################################
# get all the command line parameters, except for the last one, which is output
################################################################################
# $bitrate  - first parameter
# $last     - last parameter (output file)
# $inputs   - all the inputs, except the first input
################################################################################
bitrate=${@:1:1}
last=${@:$#:1}
len=$(($#-2))
inputs=${@:2:$len}

EXTRA_OPTIONS="-strict experimental -c:a aac -ar 44100 -b:a ${bitrate}k"
# This uses the high quality encoder, but requires non-free option with FFMPEG
#EXTRA_OPTIONS='-c:a libfdk_aac -b:a 256k'

# remove all previous tmp fifos (if exist)
rm -f $TMP/mcs_*

################################################################################
# decode first input differently, because the video header does not have to be
# kept for each video input, only the header from the first video is needed
################################################################################

################################################################################
# decode all the other inputs, remove first line of video (header) with tail
# $all_a and $all_v are lists of all a/v fifos, to be used by "cat" later on
################################################################################
i=1
for f in $inputs
do
	mkfifo $TMP/mcs_a$i

	ffmpeg -y -i $f -vn -f u16le -acodec pcm_s16le -ac 2 -ar 44100 $TMP/mcs_a$i 2>/dev/null </dev/null &

	all_a="$all_a $TMP/mcs_a$i"
	let i++
done

################################################################################
# concatenate all raw audio/video inputs into one audio/video
################################################################################
mkfifo $TMP/mcs_a_all
cat $all_a > $TMP/mcs_a_all &

################################################################################
# finally, encode the raw concatenated audio/video into something useful
################################################################################
ffmpeg -f u16le -acodec pcm_s16le -ac 2 -ar 44100 -i $TMP/mcs_a_all \
	$EXTRA_OPTIONS \
	$last

################################################################################
# remove all fifos
################################################################################
rm -f $TMP/mcs_*