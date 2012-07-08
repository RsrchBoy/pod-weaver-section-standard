package Pod::Weaver::Section::Standard::Source;

# ABSTRACT: Add a standard 'SOURCE' section to your POD

#use Moose;
#use namespace::autoclean;
#use MooseX::AttributeShortcuts;

use Reindeer;

with 'Pod::Weaver::Role::Section::Formattable';

sub _build_section_name { 'SOURCE' }

my $_sc = sub { shift->meta->{resources}->{repository} }

sub _build_format {

return << 'EOT'
This project's development repository is hosted in %v, and is
accessible at:

=for :list
* repository
L<%u>
* web
L<%w>

EOT

}

sub _build_formatter {

    return String::Formatter->new(
        input_processor => 'require_single_input',
        codes => {
            v => sub { $_sc->(@_)->{type} },
            h => sub { $_sc->(@_)->{type} },
            u => sub { shift->meta->{resources}->{repository}->{url} },
        },
    );
}

__PACKAGE__->meta->make_immutable;
!!42;
__END__
