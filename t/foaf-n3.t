
# $Id: foaf-n3.t,v 1.2 2008/05/02 00:00:47 Martin Exp $

use Test::More 'no_plan';
use Test::Deep;

my $sMod;

BEGIN
  {
  $sMod = 'RDF::Simple::Serialiser::N3';
  use_ok($sMod);
  } # end of BEGIN block

# This is taken from the SYNOPSIS of RDF::Simple::Serialiser:
my $ser = new $sMod ( nodeid_prefix => 'a:' );
isa_ok($ser, $sMod);
$ser->addns( foaf => 'http://xmlns.com/foaf/0.1/' );
my $node1 = 'a:123';
my $node2 = 'a:456';
my @triples = (
               [$node1, 'foaf:name', 'Jo Walsh'],
               [$node1, 'foaf:knows', $node2],
               [$node2, 'foaf:name', 'Robin Berjon'],
               [$node1, 'rdf:type', 'foaf:Person'],
               [$node2, 'rdf:type', 'http://xmlns.com/foaf/0.1/Person']
              );
my $rdf = $ser->serialise(@triples);
my @asN3 = split(/\n/, $rdf);
my @asExpected = <DATA>;
chomp @asExpected;
# The order of axioms in an N3 file is NOT important:
@asExpected = sort @asExpected;
@asN3 = sort @asN3;
is_deeply(\@asN3, \@asExpected);

__DATA__
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .

:a456 a foaf:Person .
:a456 foaf:name "Robin Berjon" .

:a123 a foaf:Person .
:a123 foaf:name "Jo Walsh" .
:a123 foaf:knows :a456 .
