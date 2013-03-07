package MojoMojo::Formatter::Markdown;

use parent qw/MojoMojo::Formatter/;

my $markdown;
eval "use Text::MultiMarkdown";
unless ($@) {
    $markdown = Text::MultiMarkdown->new(
        markdown_in_html_blocks => 0,    # Allow Markdown syntax within HTML blocks.
        use_metadata =>
            0,  # Remove MultiMarkdown behavior change to make the top of the document metadata.
        heading_ids => 0,    # Remove MultiMarkdown behavior change in <hX> tags.
        img_ids     => 0,    # Remove MultiMarkdown behavior change in <img> tags.
    );
}

=head1 NAME

MojoMojo::Formatter::Markdown - MultiMarkdown formatting for your content.
MultiMarkdown is an extension of Markdown, adding support for tables,
footnotes, bibliography, automatic cross-references, glossaries, appendices,
definition lists, math syntax, anchor and image attributes, and document metadata.

Markdown syntax: L<http://daringfireball.net/projects/markdown/syntax>
MultiMarkdown syntax: L<http://fletcherpenney.net/multimarkdown/users_guide/multimarkdown_syntax_guide/>

=head1 DESCRIPTION

This formatter processes content using L<Text::MultiMarkdown> This is a
syntax for writing human-friendly formatted text.

=head1 METHODS

=head2 main_format_content

Calls the formatter. Takes a ref to the content as well as the
context object. Note that this is different from the format_content method
of non-main formatters. This is because we don't want all main formatters
to be called when iterating over pluggable modules in
L<MojoMojo::Schema::ResultSet::Content::format_content>.

C<main_format_content> will only be called by <MojoMojo::Formatter::Main>.

Note that L<Text::Markdown> ensures that the output always ends with B<one>
newline. The fact that multiple newlines are collapsed into one makese sense,
because this is the behavior of HTML towards whispace. The fact that there's
always a newline at the end makes sense again, given that the output will always
be nested in a B<block>-level element, be it a C<< <p> >> (most often),
C<< <table> >>, or C<< <div> >> (when passing HTML through).

=cut

sub main_format_content {
    my ( $class, $content ) = @_;
    return unless $markdown;

    $$content = $markdown->markdown($$content);
}

=head1 SEE ALSO

L<MojoMojo>, L<Module::Pluggable::Ordered>, L<Text::MultiMarkdown>

=head1 AUTHORS

Marcus Ramberg <mramberg@cpan.org>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
