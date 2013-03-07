package MojoMojo::Schema::Result::Role;

use strict;
use warnings;

use parent qw/MojoMojo::Schema::Base::Result/;

__PACKAGE__->load_components( "Core" );
__PACKAGE__->table("role");
__PACKAGE__->add_columns(
    "id",
    { data_type => "INTEGER", is_nullable => 0, size => undef, is_auto_increment => 1 },
    "name",
    { data_type => "VARCHAR", is_nullable => 0, size => 200 },
    "active",
    { data_type => "INTEGER", is_nullable => 0, size => undef, default => 1 },
);
__PACKAGE__->set_primary_key("id");
__PACKAGE__->add_unique_constraint( "name_unique", ["name"] );
__PACKAGE__->has_many( "role_privileges", "MojoMojo::Schema::Result::RolePrivilege", { "foreign.role" => "self.id" }, );
__PACKAGE__->has_many( "role_members",    "MojoMojo::Schema::Result::RoleMember",    { "foreign.role" => "self.id" } );
__PACKAGE__->many_to_many( "members", "role_members", "person" );

=head1 NAME

MojoMojo::Schema::Result::Role - store user roles

=head1 AUTHOR

Marcus Ramberg <mramberg@cpan.org>

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut


1;
