package MojoMojo::Formatter::YouTube;

use strict;
use parent 'MojoMojo::Formatter';

eval {require URI::Fetch};
my $dependencies_installed = !$@;

=head2 module_loaded

Return true if the module is loaded.

=cut

sub module_loaded { $dependencies_installed }

our $VERSION = '0.01';

=head1 NAME

MojoMojo::Formatter::YouTube - Embed YouTube player

=head1 DESCRIPTION

Embed YouTube video player for given video by writing {{youtube <url>}}.

=head1 METHODS

=head2 format_content_order

Format order can be 1-99. The YouTube formatter runs on 10.

=cut

sub format_content_order { 10 }

=head2 format_content

Calls the formatter. Takes a ref to the content as well as the
context object.

=cut

sub format_content {
    my ( $class, $content, $c ) = @_;

    my @lines = split /\n/, $$content;
    $$content = "";
    my $re = $class->gen_re(qr/youtube\s+(.*?)/);
    my $lang = $c->sessionid ? $c->session->{lang} : $c->pref('default_lang') || 'en';

    foreach my $line (@lines) {
        if ( $line =~ m/$re/ ) {
            $line = $class->process($c, $line, $re, $lang);
        }
        $$content .= $line . "\n";
    }

}

=head2 process

Do the meat of inserting a youtube movie into a wiki page.

=cut

sub process {
    my ( $class, $c, $line, $re, $lang) = @_;

    my $youtube = $c->loc('YouTube Video');
    my $video_id;
    $line =~ m/$re/;
    my $url = URI->new($1);

    unless ($url){
        $line =~ s/$re/"$youtube: $url ".$c->loc('is not a valid url')/e;
        return $line;
    }

    if ($url =~ m!youtube.com/.*?v=([A-Za-z0-9_-]+)!){
        $video_id=$1;
    } else {
        $line =~ s/$re/"$youtube: $url ".$c->loc('is not a valid link to youtube video')/e;
        return $line;
    }

    if ( ($c->action->reverse eq 'pageadmin/edit') || ($c->action->reverse eq 'jsrpc/render') ){
        $line =~ s!$re!<div style='width: 425px;height: 344px; border: 1px black dotted;'>$youtube<br /><a href="$url">$url</a></div>!;
        $c->stash->{precompile_off} = 1;
     } else {
        $line =~ s!$re!<object width="425" height="344"><param name="movie" value="http://www.youtube.com/v/$video_id&amp;hl=$lang"></param><param name="allowFullScreen" value="true"></param><param name="allowscriptaccess" value="always"></param><embed src="http://www.youtube.com/v/$video_id&amp;hl=$lang" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="425" height="344"></embed></object>!;
    }
    return $line;
}

=head1 SEE ALSO

L<MojoMojo>, L<Module::Pluggable::Ordered>, L<URI::Fetch>

=head1 AUTHORS

Robert 'LiNiO' Litwiniec <linio@wonder.pl>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
