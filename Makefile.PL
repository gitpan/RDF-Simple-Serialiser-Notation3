
# $Id: Makefile.PL,v 1.7 2008/05/04 02:47:16 Martin Exp $

use inc::Module::Install;

name('RDF-Simple-Serialiser-Notation3');
all_from('lib/RDF/Simple/Serialiser/N3.pm');
version(1.006);
# author('Martin Thurn <mthurn@cpan.org>');
license('perl');
abstract('Output RDF triples in Notation3 format');

requires(perl => 5);
requires('Data::Dumper');
build_recommends('Pod::Coverage');
build_requires('Test::Deep');
build_requires('Test::More');
build_recommends('Test::Pod');
build_recommends('Test::Pod::Coverage');
requires('RDF::Simple::Serialiser');

WriteAll;

__END__
