#!/usr/local/bin/perl5

# Simple example that displays the data associated with
# the "readme" file field in a multiform/form-data request.

use CGI_Lite;

$cgi = new CGI_Lite;

# Die if the directory is invalid (i.e doesn't exist, can't
# read or write to it, or is not a directory)

$cgi->set_directory ("/tmp")
    || die "Directory doesn't exist.\n";

# Set the platform. "Unix" is the default. The method accepts 
# platforms in a case insensitive manner, so you can pass 
# "UNIX", "Unix", "unix", etc.

$cgi->set_platform ("Unix");

# set the buffer size to 1024 bytes

$cgi->set_buffer_size (1024);

# Tell the module to return filehandles

$cgi->set_file_type ('handle');

# let's go ahead and parse the data

$data = $cgi->parse_form_data;

print "Content-type: text/plain", "\n\n";

# Dereferences the variable to get a filehandle. Then,
# iterates through the file, displaying each line to STDOUT.
#
# NOTE: $filename also contains the name of the file.

$readme = $data->{readme};

# now, if we print out $readme, it will actually display
# the full path to the file, but we can also use the
# variable as a handle because we had called the set_file_type
# method with an argument of "handle" earlier in the program.

while (<$readme>) {
    print;
}

# make sure to close the file

close ($readme);

exit (0);
