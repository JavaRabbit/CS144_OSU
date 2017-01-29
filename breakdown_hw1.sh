#!/bin/bash

#!/bin/bash

# create a new temp file with process id if no input file specified
tempfile="tmpfile$$"
# create a temp file for file rotation
tempfile_transpose="tmpfile$$_transpose"
#echo $tempfile

# trap interrupt if needed
# removes the tempfile and exits
#trap "rm -f $tmpfile$$*; exit 1" INT HUP TERM EXIT
trap "rm -f tmpFile$$*" INT HUP TERM EXIT
