
# $Id: N3.pm,v 1.4 2008/05/01 23:58:41 Martin Exp $

=head1 NAME

RDF::Simple::Serialiser::N3 - Output RDF triples in Notation3 format

=head1 SYNOPSIS

Same as L<RDF::Simple::Serialiser>,
except when you call serialise(),
you get back a string in Notation3 format.

=head1 PRIVATE METHODS

=over

=cut

package RDF::Simple::Serialiser::N3;

use strict;
use warnings;

use Data::Dumper;  # for debugging only

use base 'RDF::Simple::Serialiser';

our
$VERSION = do { my @r = (q$Revision: 1.4 $ =~ /\d+/g); sprintf "%d."."%03d" x $#r, @r };

=item render_rdfxml

This method does all the Notation3 formatting.
Yes, it is named wrong;
but all other functionality is inherited from RDF::Simple::Serialiser
and that's how the author named the output function.
You won't be calling this method anyway,
you'll be calling the serialise() method, so what do you care!?!

=cut

sub render_rdfxml
  {
  my $self = shift;
  # Required arg1 = arrayref:
  my $raObjects = shift;
  # Required arg2 = hashref of namespaces:
  my $rhNS = shift;
  my $sRet = q{};
  foreach my $sNS (keys %$rhNS)
    {
    $sRet .= qq"\@prefix $sNS: <$rhNS->{$sNS}> .\n";
    } # foreach
  $sRet .= qq{\n};
  my %hsClassPrinted;
 OBJECT:
  foreach my $object (@$raObjects)
    {
    # We delete elements as we process them, so that during debugging
    # we can see what's leftover:
    my $sId = delete $object->{NodeId};
    my $sClass = delete $object->{Class};
    if (! $sClass)
      {
      print STDERR " EEE object has no Class: ", Dumper($object);
      next OBJECT;
      } # if
    if ($sClass !~ m/[^:]+:[^:+]/)
      {
      # Class is not explicitly qualified with a "prefix:", ergo now
      # explicitly qualify in the default namespace:
      $sClass = qq{:$sClass};
      if (! $hsClassPrinted{$sClass})
        {
        $sRet .= qq{$sClass a owl:Class .\n\n};
        $hsClassPrinted{$sClass}++;
        } # if
      } # if
    $sRet .= qq{:$sId a $sClass .\n};
    if ($object->{Uri})
      {
      $sRet .= qq{:$sId rdf:about <$object->{Uri}> .\n};
      delete $object->{Uri};
		} # if
  LITERAL:
    foreach my $sProp (keys %{$object->{literal}})
      {
    LITERAL_PROPERTY:
      foreach my $sVal (@{$object->{literal}->{$sProp}})
        {
        $sRet .= qq{:$sId $sProp "$sVal" .\n};
        } # foreach LITERAL_PROPERTY
		} # foreach LITERAL
    delete $object->{literal};
  NODEID:
    foreach my $sProp (keys %{$object->{nodeid}})
      {
    NODEID_PROPERTY:
      foreach my $sVal (@{$object->{nodeid}->{$sProp}})
        {
        $sRet .= qq{:$sId $sProp :$sVal .\n};
        } # foreach NODEID_PROPERTY
		} # foreach NODEID
    delete $object->{nodeid};
  RESOURCE:
    foreach my $sProp (keys %{$object->{resource}})
      {
    RESOURCE_PROPERTY:
      foreach my $sVal (@{$object->{resource}->{$sProp}})
        {
        $sRet .= qq{:$sId $sProp <$sVal> .\n};
        } # foreach RESOURCE_PROPERTY
		} # foreach RESOURCE
    delete $object->{resource};
    print STDERR Dumper($object) if keys %$object;
    $sRet .= qq{\n};
    } # foreach OBJECT
  return $sRet;
  } # render_rdfxml

1;

__END__

=back

=head1 NOTES

Sorry, there is no Notation3 parser for RDF::Simple.
Not yet, anyway.

=cut

=head1 AUTHOR

Martin 'Kingpin' Thurn <mthurn@cpan.org>

=head1 LICENSE

This software is released under the same license as Perl itself.

=cut

