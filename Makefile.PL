
# $Id: Makefile.PL,v 1.2 2008/04/30 01:13:53 Martin Exp $

use inc::Module::Install;

name('RDF-Simple-Serialiser-Notation3');
all_from('lib/RDF/Simple/Serialiser/N3.pm');

author('Martin Thurn <mthurn@cpan.org>');
license('perl');

requires('Data::Dumper');
build_requires('Test::More');
requires('RDF::Simple::Serialiser');

WriteAll;

__END__
