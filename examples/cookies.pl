#!/usr/local/bin/perl5

# simple example to dump all the cookies :-)

use CGI_Lite;

$cgi     = new CGI_Lite;
%cookies = $cgi->parse_cookies;

print "Content-type: text/plain", "\n\n";

# we could also have used the method print_cookie_data, like so:
#
# $cgi->print_cookie_data;
#
# instead of manually iterating through the data

while (($key, $value) = each %cookies) {
    print "$key = $value\n";
}

exit (0);
