
# $Id: Makefile.PL,v 1.13 2008/07/27 00:58:03 Martin Exp $

use inc::Module::Install;

name('RDF-Simple-Serialiser-Notation3');
all_from('lib/RDF/Simple/Serialiser/N3.pm');
version(1.013);
# author('Martin Thurn <mthurn@cpan.org>');
license('perl');
abstract('Output RDF triples in Notation3 format');

requires(perl => 5);
requires('Data::Dumper');
test_recommends('Pod::Coverage');
test_requires('Test::Deep');
test_requires('Test::More');
test_recommends('Test::Pod');
test_recommends('Test::Pod::Coverage');
requires('RDF::Simple::Serialiser');
requires('Regexp::Common');

WriteAll;

__END__
