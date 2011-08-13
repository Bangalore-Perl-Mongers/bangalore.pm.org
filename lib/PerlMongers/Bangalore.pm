package PerlMongers::Bangalore;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);

use warnings;
use strict;
require Exporter;
#======================================================================
@ISA = qw(Exporter);
@EXPORT_OK = qw(Perl_Mongers);
#======================================================================
sub info {
        system('perldoc', __PACKAGE__);
}
#======================================================================
1; # End of Bangalore.pm

__END__

=head1 NAME

PerlMongers::Bangalore - We are the Bangalore Perl Mongers, find us at all the places listed below!
If you are in or around Bangalore near the first week of a month, do drop by for our meetups listed 
at bangalore.pm.org

=head1 SYNOPSIS

    use PerlMongers::Bangalore qw(info);
        
    info();

=head2 WEBSITE

http://www.bangalore.pm.org

=head2 MEETUPS

http://bangalore.pm.org/meetups.html

=head2 DISCUSSION BOARD

http://bangalore.pm.org/forum.html

=head2 IRC Channel

irc.perl.org #bangalore.pm

=head2 MAILING LIST (SUBSCRIBE HERE)

http://mail.pm.org/mailman/listinfo/bangalore-pm

=head2 MAIL ARCHIVES

http://mail.pm.org/pipermail/bangalore-pm/

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2011 Shantanu Bhadoria  

C<< <shantanu (dot comes here) bhadoria at gmail dot com> >> L<http://www.shantanubhadoria.com>

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

=head1 DEPENDENCIES 

L<Exporter>

C<Perl>

=cut

