#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 3;
use Test::Differences;

my $original_formatter;    # current formatter set up in mojomojo.db
my $c;                     # the Catalyst object of this live server
my $test;                  # test description
my $body;                  # the MojoMojo page body as fetched by get()

BEGIN {
    $ENV{CATALYST_CONFIG} = 't/var/mojomojo.yml';
    use_ok 'Catalyst::Test', 'MojoMojo';
}


#-------------------------------------------------------------------------------

$test = "specific error message: no revision x for x";
$body = get('/?rev=9999');
like $body, qr'No revision 9999 for <span class="error_detail"><a href="/">/</a></span>', $test;

# .login doesn't really care about the rev query string
# but heh, purl told me to write a test since all tests were passing.
$test = 'get login page revision 1.';
$body = get('.login/?rev=1');
like $body, qr'sername', $test;
