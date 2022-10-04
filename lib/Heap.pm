package Heap;
use strict;
use warnings;

use Carp;
use Exporter;

our @EXPORT_OK = qw( );
our $VERSION = '0.01';

sub make_heap { return [ ]; }
sub heapify { ... }
sub heap_peek { return $_->[0]; }
sub heap_push { ... }
sub heap_pop { ... }
sub heap_replace { ... }

sub _upheap { ... }
sub _downheap { ... }

=head1 NAME

Heap - Bare-bones perl heap data structures

=head1 SYNOPSIS
  use Heap;
  my $heap = ...
  TODO

=head1 DESCRIPTION

Can be used to implement priority queues, etc

=head2 EXPORT

TODO

=cut

1;
