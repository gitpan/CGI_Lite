#!/usr/local/bin/perl5 

# Prints out the key/value pairs using the print_form_data
# method.

use CGI_Lite;

$cgi = new CGI_Lite;

# The return value from the method is ignored.

$cgi->parse_form_data;

print "Content-type: text/plain", "\n\n";

$cgi->print_form_data;

exit (0);
