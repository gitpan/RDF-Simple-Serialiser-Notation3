
# $Id: Makefile.PL,v 1.5 2008/05/03 03:31:22 Martin Exp $

use inc::Module::Install;

name('RDF-Simple-Serialiser-Notation3');
all_from('lib/RDF/Simple/Serialiser/N3.pm');
version(1.005);

author('Martin Thurn <mthurn@cpan.org>');
license('perl');

requires('Data::Dumper');
build_requires('Test::Deep');
build_requires('Test::More');
build_recommends('Test::Pod');
build_recommends('Test::Pod::Coverage');
requires('RDF::Simple::Serialiser');

WriteAll;

__END__
