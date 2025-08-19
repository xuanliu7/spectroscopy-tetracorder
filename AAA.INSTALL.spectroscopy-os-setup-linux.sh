#!/bin/sh

# R. Clark, 2019 - 2020

# This software was written by Roger N. Clark and colleagues and falls under the following license:
# 
# Copyright (c) 1975 - 2020, Roger N. Clark,
#                            Planetary Science Institute, PSI
#                            rclark@psi.edu, and colleagues named in the code.
# 
# All rights reserved.
# 
# GNU General Public License https://www.gnu.org/licenses/gpl.html
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#   Redistributions of the program must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
#
#   Neither Roger N. Clark, Planetary Science Institute, nor the names of
#   contributors to this software may be used to endorse or promote products
#   derived from this software without specific prior written permission.
#
#   Translation/recoding into other languages: the translation and source code
#   must be made available for free.
#
#   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER AND CONTRIBUTORS "AS IS"
#   AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#   IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#   ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS
#   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY,
#   OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
#   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
#   INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
#   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
#   ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF
#   THE POSSIBILITY OF SUCH DAMAGE.


doinstall=0

# edit location as desired:
t1="$HOME/t1"     # tetracorder directories
sl1="$HOME/sl1"   # spectral library directories
src="$HOME/local/src"   # source code directories

# Note: will create /usr/spool/ /usr/spool/gplot directories and /usr/spool/plot.log file

echo '******* The is the system setup script to compile and run specpr, tetracorder *******'
echo '******* and to set up the data directories, including for spectral libraries. *******'
echo " "
echo "     WARNING: this script may add directories, links at root level, users, groups"
echo " "
echo " "


echo " "
echo "Directories will be created in your home folder:"
echo " "
echo "      $t1     # tetracorder directories"
echo "      $sl1   # spectral library directories"
echo "      $src   # source code directories"
echo " "
echo "      ln -s $src /src will also be made if not already existing"
echo " "

echo " "
echo "Type  y  to continue, anything else exits."
read y
if [ "$y" != "y" ]
then
	echo "exit 1"
	exit 1
fi

#######################################################################################

ifoundthem=0
numbertested=0
notfound=" "

echo "Checking for programs that must be installed"

required_programs=(gfortran make gcc g++ ratfor tcsh csh aplay gnuplot gnuplot-x11 imagemagick  tgif javac vim)
missing_programs=()
for prog in "${required_programs[@]}"; do
    if ! command -v "$prog" &>/dev/null; then
        missing_programs+=("$prog")
    else
        echo "Found: $prog"
    fi
done

if [ ${#missing_programs[@]} -gt 0 ]; then
    echo
    echo "Warning: the following programs were not found in your PATH:"
    echo "${missing_programs[@]}"
    echo "You may need to install them locally or add them to your PATH."
fi


required_libs=(
    libX11.so
    libXpm.so
    libXt.so
    libpng.so
    libjbig.so
    libjpeg.so
    libz.so
)
for lib in "${required_libs[@]}"; do
    if ! find "$HOME/local/lib" /usr/lib /usr/lib64 /lib -name "$lib" 2>/dev/null | grep -q .; then
        missing_libs+=("$lib")
    else
        echo "Found library: $lib"
    fi
done

if [ ${#missing_libs[@]} -gt 0 ]; then
    echo
    echo "Missing libraries:"
    printf "  %s\n" "${missing_libs[@]}"
fi



echo " "
echo "Making directories and links"

# $t1       # tetracorder directory
# $sl1      # spectral library directory

for idir in  $t1 $sl1
do
	if [ -d "$idir" ]
	then
		echo "directory $idir found"
	else
		echo "mkdir $idir   # USGS spectrosocpy lab directories"
		mkdir $idir         # USGS spectrosocpy lab directories
			if [ $? -ne 0 ]
			then
				echo "ERROR: command failed"
				echo "exit 1"
				exit 1
			fi
	fi
done






echo " "
echo "Done with this script"
echo "Spectroscopy system setup complete"
echo " "
