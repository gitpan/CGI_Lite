#!/usr/local/bin/perl5

# Simply displays the key/value pairs. Here is how the output
# would look like for multipart/form-data requests:
#
# full_name = Foo Bar
# picture = /usr/shishir/bar.gif_812186386
# readme = /usr/shishir/bar.txt_812186386

use CGI_Lite;

$cgi = new CGI_Lite;

$cgi->set_directory ("/usr/shishir")
    || die "Directory doesn't exist.\n";

# we're ignoring the returned value

$cgi->parse_form_data;

print "Content-type: text/plain", "\n\n";

$cgi->print_form_data;

exit (0);
