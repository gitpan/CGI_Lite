#!/usr/local/bin/perl5

# Very much like the reference.pl example, except for the fact 
# that we're calling the parse_form_data in a different context;
# the method returns a hash, so we don't need to derefence.

use CGI_Lite;

$cgi  = new CGI_Lite;
%data = $cgi->parse_form_data;

print "Content-type: text/plain", "\n\n";

while (($key, $value) = each %data) {

    # let's check to see if a value is a reference to an array,
    # which indicates multiple values for the field.

    if (ref $value) {
	@all_values = $cgi->get_multiple_values ($value);

	print "$key = @all_values\n";
    } else {
	print "$key = $value\n";
    }
}

exit (0);
