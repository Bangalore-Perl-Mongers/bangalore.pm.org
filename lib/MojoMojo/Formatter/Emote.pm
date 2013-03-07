package MojoMojo::Formatter::Emote;

eval "use Text::Emoticon::MSN";
my $eval_res = $@;

=head2 module_loaded

Return true if the module is loaded.

=cut

sub module_loaded { $eval_res ? 0 : 1 }

our $VERSION = '0.01';

=head1 NAME

MojoMojo::Formatter::Emote - MSN Smileys in your text.

=head1 DESCRIPTION

This formatter transforms the full range of MSN Smileys into
bitmaps on your page, using L<Text::Emoticon::MSN>.

=head1 METHODS

=head2 format_content_order

Format order can be 1-99. The Emote formatter runs on 95.

=cut

sub format_content_order { 95 }

=head2 format_content

Calls the formatter. Takes a ref to the content as well as the
context object.

=cut

sub format_content {
    my ($class, $content, $c)=@_;
    return unless $class->module_loaded && $c->pref('enable_emoticons');
    my $emoticon = Text::Emoticon::MSN->new(
        imgbase => $c->req->base.'/.static/emote',
        xhtml => 1, strict => 1
    );
    # Let textile handle the rest
    $$content = $emoticon->filter( $$content );
}

=head1 SEE ALSO

L<MojoMojo>, L<Module::Pluggable::Ordered>, L<Text::Emoticon::MSN>

=head1 AUTHORS

Marcus Ramberg <mramberg@cpan.org>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
