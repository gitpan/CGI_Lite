#!/usr/local/bin/perl5

# Simple example that performs the same function as the
# print_form_data method.

use CGI_Lite;

$cgi = new CGI_Lite;

# The return value is stored in $data, which contains a
# reference to the hash. In order to access an element, you 
# have to dereference it:
#
#     $data->{readme}
#     $$data{readme}
#     %$data

$data = $cgi->parse_form_data;

print "Content-type: text/plain", "\n\n";

while (($key, $value) = each %$data) {
    print "$key = $value\n";
}

exit (0);
