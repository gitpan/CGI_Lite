#!/usr/local/bin/perl5

# example that shows the effect of wrap_textarea and create_variables.
# let's assume we're getting three fields: name, bio, skills

use CGI_Lite;

$cgi  = new CGI_Lite;
%form = $cgi->parse_form_data;

print "Content-type: text/plain\n\n";

# the create_variables method needs a reference to a hash. we could
# call this method in the following manner as well:
#
# $form = $cgi->parse_form_data;
# $cgi->create_variables ($form);

# because we have three fields, the create_variables creates three
# variables for us: $name, $bio and $skills.

$cgi->create_variables (\%form);

if (ref $skills) {
    @all_skills = $cgi->get_multiple_values ($skills);
}

$nice_bio = $cgi->wrap_textarea ($bio);

print <<End_of_Display;

Name:   $name
Skills: $skills
Bio:

$nice_bio

End_of_Display

exit (0);




