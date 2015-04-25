#!/bin/bash

if [[ -r /etc/profile ]];then . /etc/profile;fi;if [[ -r ~/.bashrc ]];then . ~/.bashrc;fi;if [[ -r ~/.bash_profile ]];then . ~/.bash_profile;fi

EXTRA_OPTIONS='-strict experimental -c:a aac -ar 44100 -b:a 256k'
# This uses the high quality encoder, but requires non-free option with FFMPEG
#EXTRA_OPTIONS='-c:a libfdk_aac -b:a 256k'

# location of temp folder
TMP=/tmp

################################################################################
# get all the command line parameters, except for the last one, which is output
################################################################################
# $first  - first parameter
# $last   - last parameter (output file)
# $inputs - all the inputs, except the first input
################################################################################
first=${@:1:1}
last=${@:$#:1}
len=$(($#-2))
inputs=${@:2:$len}

# remove all previous tmp fifos (if exist)
rm -f $TMP/mcs_*

################################################################################
# decode first input differently, because the video header does not have to be
# kept for each video input, only the header from the first video is needed
################################################################################
mkfifo $TMP/mcs_a1 #$TMP/mcs_v1

ffmpeg -y -i $first -vn -f u16le -acodec pcm_s16le -ac 2 -ar 44100 $TMP/mcs_a1 2>/dev/null </dev/null &
#ffmpeg -y -i $first -an -f yuv4mpegpipe -vcodec rawvideo $TMP/mcs_v1 2>/dev/null </dev/null &

# if you need to log the output of decoding processes (usually not necessary)
# then replace the "2>/dev/null" in 2 lines above with your log file names, like this:
#ffmpeg -y -i $first -vn -f u16le -acodec pcm_s16le -ac 2 -ar 44100 $TMP/mcs_a1 2>$TMP/log.a.1 </dev/null &
#ffmpeg -y -i $first -an -f yuv4mpegpipe -vcodec rawvideo $TMP/mcs_v1 2>$TMP/log.v.1 </dev/null &

################################################################################
# decode all the other inputs, remove first line of video (header) with tail
# $all_a and $all_v are lists of all a/v fifos, to be used by "cat" later on
################################################################################
all_a=$TMP/mcs_a1
#all_v=$TMP/mcs_v1
i=2
for f in $inputs
do
	mkfifo $TMP/mcs_a$i #$TMP/mcs_v$i

	ffmpeg -y -i $f -vn -f u16le -acodec pcm_s16le -ac 2 -ar 44100 $TMP/mcs_a$i 2>/dev/null </dev/null &
#	{ ffmpeg -y -i $f -an -f yuv4mpegpipe -vcodec rawvideo - 2>/dev/null </dev/null | tail -n +2 > $TMP/mcs_v$i ; } &

	# if you need to log the output of decoding processes (usually not necessary)
	# then replace the "2>/dev/null" in 2 lines above with your log file names, like this:
	#ffmpeg -y -i $f -vn -f u16le -acodec pcm_s16le -ac 2 -ar 44100 $TMP/mcs_a$i 2>$TMP/log.a.$i </dev/null &
	# { ffmpeg -y -i $f -an -f yuv4mpegpipe -vcodec rawvideo - 2>$TMP/log.v.$i </dev/null | tail -n +2 > $TMP/mcs_v$i ; } &

	all_a="$all_a $TMP/mcs_a$i"
	#all_v="$all_v $TMP/mcs_v$i"
	let i++
done

################################################################################
# concatenate all raw audio/video inputs into one audio/video
################################################################################
mkfifo $TMP/mcs_a_all
#mkfifo $TMP/mcs_v_all
cat $all_a > $TMP/mcs_a_all &
#cat $all_v > $TMP/mcs_v_all &

################################################################################
# finally, encode the raw concatenated audio/video into something useful
################################################################################
ffmpeg -f u16le -acodec pcm_s16le -ac 2 -ar 44100 -i $TMP/mcs_a_all \
	$EXTRA_OPTIONS \
	$last
#       -f yuv4mpegpipe -vcodec rawvideo -i $TMP/mcs_v_all \
# Line above goes before $EXTRA_OPTIONS


################################################################################
# remove all fifos
################################################################################
rm -f $TMP/mcs_*