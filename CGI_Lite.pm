#!/usr/local/bin/perl5

##++
##     CGI Lite v1.7
##     Last modified: December 28, 1996
##
##     Copyright (c) 1995, 1996 by Shishir Gundavaram
##     All Rights Reserved
##
##     E-Mail: shishir@ora.com
##
##     Permission  to  use,  copy, and distribute is hereby granted,
##     providing that the above copyright notice and this permission
##     appear in all copies and in supporting documentation.
##--

###############################################################################

=head1 NAME

CGI Lite - Perl 5.0 module to process and decode WWW form information.

=head1 SYNOPSIS

    use CGI_Lite;

    $cgi = new CGI_Lite;

    $cgi->set_platform ($platform);
    
        where $platform (case insensitive) can be one of:
        Unix, Windows, Windows95, DOS, NT, PC, Mac or Macintosh

    $cgi->set_file_type ("handle" or "file");

    $size = $cgi->set_buffer_size ($some_size);

    $status = $cgi->set_directory ('/some/dir');
    $cgi->set_directory ('/some/dir') || die "Directory doesn't exist.\n";

    $form = $form->parse_form_data;
    %form = $cgi->parse_form_data;

    $cookies = $form->parse_cookies;
    %cookies = $cgi->parse_cookies;

    $cgi->print_form_data;

    $cgi->print_cookie_data;

    $new_string  = $cgi->wrap_textarea ($string, $length);

    @all_options = $cgi->get_multiple_values ($options);

    $cgi->create_variables (\%form);
    $cgi->create_variables ($form);

=head1 DESCRIPTION

You can use this module to decode form information or cookies in a 
very simple manner; you need not concern yourself with the actual 
details behind the decoding process. 

This module can handle the traditional GET and POST URL encoded data, 
as well the new multipart form data (i.e file upload).

=head1 METHODS

Here are the methods you can use to process your forms:

=over 4

=item B<parse_form_data>

This will handle all types of requests: GET, HEAD and POST (for both 
encoding methods). For multipart/form-data, uploaded files are 
stored in the user selected directory (see B<set_directory>). The 
files are named in the following format:

    timestamp__filename

where the filename is specified in the "Content-disposition" header.
I<NOTE:>, the browser URL encodes the name of the file. This module
makes no effort to decode the information for security reasons.

I<Return Value>

Returns either a hash or a reference to the hash, which contains
all of the key/value pairs. For fields that contain file information,
the value contains either the path to the file, or the filehandle 
(see the B<set_file_type> method).

=item B<parse_cookies>

Parses any cookies passed by the browser. This method works in
much the same manner as B<parse_form_data>. 

=item B<set_platform>

This method will set the end of line characters for uploaded text
files so that they display properly on the specified platform
(the platform your HTTP server is running on).

You can specify either:

    Unix                                  EOL: \012      = \n
    Windows, Windows95, DOS, NT, PC       EOL: \015\012  = \r\n
    Mac or Macintosh                      EOL: \015      = \r

"Unix" is the default.

=item B<set_directory>

Used to set the directory where the uploaded files will be stored 
(only applies to the I<multipart/form-data> encoding scheme).

This function should be called I<before> you call B<parse_form_data>, 
or else the directory defaults to "/tmp". If the application cannot 
write to the directory for whatever reason, an error status is returned.

I<Return Value>

    0  Failure
    1  Success

=item B<set_file_type>

The I<names> of uploaded files are returned by default, when you call
the B<parse_form_data> method. But,  if pass the string "handle" to this 
method, the I<handles> to the files are returned. However, the name
of the handle corresponds to the filename.

This function should be called I<before> you call B<parse_form_data>, or 
else it will not work.

=item B<set_buffer_size>

This method allows you to set the buffer size when dealing with multipart 
form data. However, the I<actual> buffer size that the algorithm uses 
I<will> be 2-3 times that of the value you specify. This ensures that
boundary strings are not "split" between multiple reads. So, take
this into consideration when setting a buffer size.

You cannot set a buffer size below 256 bytes and above the total amount 
of multipart form data. The default value is 1024 bytes. 

I<Return Value>

The buffer size.

=item B<print_form_data>

Displays all of the key/value pairs. If a key contains multiple values,
all the values are displayed.

=item B<print_cookie_data>

Displays all the cookie key/value pairs. If a key contains multiple 
values, all the values are displayed.

=item B<wrap_textarea>

You can use this function to "wrap" a long string into one that is 
separated by a combination of carriage return and newline (see 
B<set_platform>) at fixed lengths.  The two arguments that you need to 
pass to this method are the string and the length at which you want the 
line separator added.

I<Return Value>

The modified string.

=item B<get_multiple_values>

One of the major changes to this module as of v1.7 is that multiple
values for a single key are returned as an reference to an array, and 
I<not> as a string delimited by the null character ("\0"). You can use 
this function to return the actual array.

There was no way I could make this backward compatible. I apologize!

I<Return Value>

Array consisting of the multiple values.

=item B<create_variables>

Sometimes, it is convenient to have scalar variables that represent
the various keys in a hash. You can use this method to do just that.
Say you have a hash like the following:

    %form = ('name'   => 'shishir gundavaram',
	     'sport'  => 'track and field',
	     'events' => '100m');

If you call this method in the following manner:

    $cgi->create_variables (\%hash);

it will create three scalar variables: $name, $sport and $events. 
Convenient, huh? 

=back

=head1 SEE ALSO

You should look at the various other CGI modules, and use the one that 
best suites you. For more information, you can subscribe to the CGI 
Module Development List at:

I<CGI-perl@webstorm.com>

Contact: Marc Hedlund I<(hedlund@best.com)> for more information. This 
list is I<not> for general CGI support. It only deals with CGI module 
development.

The CGI modules and CGI.pm are maintained by Lincoln Stein 
I<(lstein@genome.wi.mit.edu)> and can be found on his WWW site:

I<http://www-genome.wi.mit.edu/WWW/tools/scripting>

=head1 ACKNOWLEDGMENTS

I'd like to thank the following for finding bugs and offering 
suggestions:

=over 4

=item Eric D. Friedman (friedman@uci.edu)   

=item Thomas Winzig (tsw@pvo.com)

=item Len Charest (len@cogent.net)

=item Achim Bohnet (ach@rosat.mpe-garching.mpg.de)

=item John E. Townsend (John.E.Townsend@BST.BLS.com)

=item Andrew McRae (mcrae@internet.com)

=item and many others!

=back

=head1 COPYRIGHT INFORMATION
    

        Copyright (c) 1995, 1996 by Shishir Gundavaram
                      All Rights Reserved

 Permission to use, copy, and  distribute  is  hereby granted,
 providing that the above copyright notice and this permission
 appear in all copies and in supporting documentation.

=cut

###############################################################################

package CGI_Lite;
require 5.002;

##++
## Global Variables
##--

$CGI_Lite::VERSION = "1.7";

##++
##  Start
##--

sub new
{
    my $self;

    $self = {
	        multipart_dir    =>    undef,
	        default_dir      =>    '/tmp',
	        file_type        =>    'name',
	        platform         =>    'Unix',
	        buffer_size      =>    1024,
	        form_data        =>    {},
                cookie_data      =>    {}
	    };

    $self->{file} = { Unix => '/',    Mac => ':',    PC => '\\'       };
    $self->{eol}  = { Unix => "\012", Mac => "\015", PC => "\015\012" };

    bless $self;
    return $self;
}

sub Version 
{ 
    return $VERSION;
}

sub set_directory
{
    my ($self, $directory) = @_;

    stat ($directory);

    if ( (-d _) && (-e _) && (-r _) && (-w _) ) {
	$self->{multipart_dir} = $directory;
	return (1);

    } else {
	return (0);
    }
}

sub set_platform
{
    my ($self, $platform) = @_;

    if ($platform =~ /(?:PC|NT|Windows(?:95)?|DOS)/i) {
        $self->{platform} = 'PC';

    } elsif ($platform =~ /Mac(?:intosh)?/i) {

	## Should I check for NeXT here :-)

        $self->{platform} = 'Mac';

    } else {
	$self->{platform} = 'Unix';
    }
}

sub set_file_type
{
    my ($self, $type) = @_;

    if ($type =~ /^handle$/i) {
	$self->{file_type} = $type;
    } else {
	$self->{file_type} = 'name';
    }
}

sub set_buffer_size
{
    my ($self, $buffer_size) = @_;
    my $content_length;

    $content_length = $ENV{CONTENT_LENGTH} || return (0);

    if ($buffer_size < 256) {
	$self->{buffer_size} = 256;
    } elsif ($buffer_size > $content_length) {
	$self->{buffer_size} = $content_length;
    } else {
	$self->{buffer_size} = $buffer_size;
    }

    return ($self->{buffer_size});
}

sub parse_form_data
{
    my $self = shift;
    my ($request_method, $content_length, $content_type, $query_string,
	$first_line, $boundary, $post_data);

    $request_method = $ENV{REQUEST_METHOD} if ($ENV{REQUEST_METHOD});
    $content_length = $ENV{CONTENT_LENGTH} if ($ENV{CONTENT_LENGTH});
    $content_type   = $ENV{CONTENT_TYPE}   if ($ENV{CONTENT_TYPE});

    if ($request_method =~ /^(get|head)$/i) {

	$query_string = $ENV{QUERY_STRING};
	$self->_decode_url_encoded_data (\$query_string, "form_data");

	return wantarray ?
	    %{ $self->{form_data} } : $self->{form_data};

    } elsif ($request_method =~ /^post$/i) {

	if (!$content_type || 
	    ($content_type eq "application/x-www-form-urlencoded")) {

	    local $^W = 0;

	    read (STDIN, $post_data, $content_length);
	    $self->_decode_url_encoded_data (\$post_data, "form_data");

	    return wantarray ? 
		%{ $self->{form_data} } : $self->{form_data};

	} elsif ($content_type =~ /multipart\/form-data/) {
	    ($boundary) = $content_type =~ /boundary=(\S+)$/;
	    $self->_parse_multipart_data ($content_length, $boundary);

	    return wantarray ? 
		%{ $self->{form_data} } : $self->{form_data};

	} else {
	    $self->_error ("Invalid content type!");
	}

    } else {
	$self->_error ("Invalid request method!");
    }
}

sub parse_cookies
{
    my $self = shift;
    my $cookies;

    $cookies = $ENV{HTTP_COOKIE} || return;

    $self->_decode_url_encoded_data (\$cookies, "cookie_data");

    return wantarray ? 
        %{ $self->{cookie_data} } : $self->{cookie_data};
}

sub print_form_data
{
    my $self = shift;

    $self->_print_data ($self->{form_data});
}

sub print_cookie_data
{
    my $self = shift;

    $self->_print_data ($self->{cookie_data});
}

sub wrap_textarea
{
    my ($self, $string, $length) = @_;
    my ($new_string, $platform, $eol);

    $length   = 70 unless ($length);
    $platform = $self->{platform};
    $eol      = $self->{eol}->{$platform};
	
    ($new_string = $string) =~ s/(.{0,$length})\s/$1$eol/og;

    return ($new_string);
}

sub get_multiple_values
{
    my ($self, $array) = @_;

    return (@$array);
}

sub create_variables
{
    my ($self, $hash) = @_;
    my ($package, $key, $value);
    
    $package = $self->_determine_package;

    while (($key, $value) = each %$hash) {
	${"$package\:\:$key"} = $value;
    }
}

##++
##  Internal Methods
##--

sub _error
{
    my ($self, $message) = @_;

    print STDERR <<End_of_Error;

CGI Lite v$VERSION Error --
$message

End_of_Error

    exit (1);
}

sub _determine_package
{
    my $self = shift;
    my ($frame, $this_package, $find_package);

    $frame = -1;
    ($this_package) = split (/=/, $self);

    do {
	$find_package = caller (++$frame);
    } until ($find_package !~ /^$this_package/);

    return ($find_package);
}   

sub _print_data
{
    my ($self, $hash) = @_;
    my ($key, $value, $eol);

    $eol = $self->{eol}->{$self->{platform}};

    while (($key, $value) = each %$hash) {
	if (ref $value) {
	    print "$key = @$value$eol";
	} else {
	    print "$key = $value$eol";
	}
    }
}

##++
##  Decode URL encoded data
##--

sub _decode_url_encoded_data
{
    my ($self, $reference_data, $element) = @_;
    my $code;

    $code = <<'End_of_URL_Decode';

    my (@key_value_pairs, $delimiter, $key_value, $key, $value);

    @key_value_pairs = ();

    return unless ($$reference_data);

    if ($element eq 'cookie_data') {
	$delimiter = ';\s+';
    } else {
	$delimiter = '&';
    }

    $$reference_data =~ tr/+/ /;
    @key_value_pairs = split (/$delimiter/, $$reference_data);
		
    foreach $key_value (@key_value_pairs) {
	($key, $value) = split (/=/, $key_value);

	$key   =~ s/%([\da-fA-F]{2})/chr (hex ($1))/eg;
	$value =~ s/%([\da-fA-F]{2})/chr (hex ($1))/eg;
	
	if ( defined ($self->{$element}->{$key}) ) {
	    $self->{$element}->{$key} = [$self->{$element}->{$key}] 
	        unless ( ref $self->{$element}->{$key} );

	    push (@{ $self->{$element}->{$key} }, $value);
	} else {
	    $self->{$element}->{$key} = $value;
	}
    }

End_of_URL_Decode

    eval ($code);
    $self->_error ($@) if $@;
}

##++
##  Methods dealing with multipart data
##--

sub _parse_multipart_data
{
    my ($self, $total_bytes, $boundary) = @_;

    my $code;

    local $^W = 0;

    $code = <<'End_of_Multipart';

    my ($seen, $buffer_size, $byte_count, $platform, $eol, $handle, 
	$bytes_left, $buffer_size, $new_data, $old_data, $current_buffer,
	$changed, $store, $disposition, $headers, $binary, $field, $file);

    $seen        = {};
    $buffer_size = $self->{buffer_size};
    $byte_count  = 0;
    $platform    = $self->{platform};
    $eol         = $self->{eol}->{$platform};
    $handle      = 'CL00';

    while (1) {
	if ($byte_count < $total_bytes) {
	    $bytes_left  = $total_bytes - $byte_count;
	    $buffer_size = $bytes_left if ($bytes_left < $buffer_size);

	    read (STDIN, $new_data, $buffer_size);
	    $self->_error ("Oh, Oh! I'm upset! Can't read what I want.") 
	        if (length ($new_data) != $buffer_size);

	    $byte_count += $buffer_size;

	    if ($old_data) {
		$current_buffer = join ("", $old_data, $new_data);
	    } else {
		$current_buffer = $new_data;
	    }

	} elsif ($old_data) {
	    $current_buffer = $old_data;
	    undef $old_data;

	} else {
	    last;
	}

	$changed = 0;

	if ($current_buffer =~ /(?:\015?\012)?-+$boundary-*[\015\012]*/) {
	    ($old_data, $store) = ($', $`);

            if (($disposition, $headers) = $current_buffer =~ 
             /[Cc]ontent-[Dd]isposition: ([^\015\012]+)\015?\012  # Disposition
              (?:([A-Za-z].*?)(?:\015?\012){2})?                  # Headers
              (?:\015?\012)?                                      # End
             /x) {

		$self->_store ($platform, $file, $binary, $handle, $eol, 
			       $field, \$store, $seen);

		close ($handle) if (fileno ($handle));

		if (!$headers || ($headers =~ /[Cc]ontent-[Tt]ype: text/)) {
		    $binary = 0;
		} else {
		    $binary = 1;
		}

		$changed = 1;

		$current_buffer = $old_data = $';

		($field) = $disposition =~ /name="([^"]+)"/;

                ++$seen->{$field};
                $self->{form_data}->{$field} = [$self->{form_data}->{$field}]
                    if ($seen->{$field} > 1);

                if (($file) = $disposition =~ /filename="(.*)"/) {

	            ##++
	            ##  Beta versions of Netscape used to send the entire
	            ##  path to the _local_ file. Unfortunately, there
	            ##  are people who are still using these versions.
	            ##--

                    $file =~ s|.*[:/\\](.*)|$1|;

                    $file = join ($self->{file}->{$platform}, 
                                  $self->{multipart_dir} || 
                                  $self->{default_dir},
                                  time . "__" . $file);

                    $self->{form_data}->{$field} = $file;

                    open (++$handle, ">$file") 
	                || $self->_error ("Oops! Can't create file $file!");
                }
            }

	} else {
            $store    = $old_data;
            $old_data = $new_data;
        }                

        unless ($changed) {
           $self->_store ($platform, $file, $binary, $handle, $eol, $field, 
                   \$store, $seen);
        }
    }

    close ($handle) if (fileno ($handle));

End_of_Multipart

    eval ($code);
    $self->_error ($@) if $@;

    $self->_create_handles;
}

sub _store
{
    my ($self, $platform, $file, $binary, $handle, $eol, $field, 
	$info, $seen) = @_;

    if ($file) {
	unless ($binary) {
	    $$info =~ s/\015\012/$eol/og  if ($platform ne "PC");
	    $$info =~ s/\015/$eol/og      if ($platform ne "Mac");
	    $$info =~ s/\012/$eol/og      if ($platform ne "Unix");
	}

	print $handle $$info;

    } elsif ($field) {
	if ($seen->{$field} > 1) {
	    $self->{form_data}->{$field}->[$seen->{$field}-1] .= $$info;
	} else {
	    $self->{form_data}->{$field} .= $$info;
        }
    }
}

sub _create_handles
{
    my $self = shift;
    my ($package, $handle, $key, $value, $handle);

    $package = $self->_determine_package;

    while (($key, $value) = each %{ $self->{form_data} }) {

	if ($value =~ /^\d+__/) {
	    $handle = "$package\:\:$value";
	    open ($handle, "<$value")
	        || $self->_error ("Can't open file $value!");
	}
    }
}

1;

