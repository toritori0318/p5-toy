package Toy::Box::Base;
use strict;
use warnings;

sub new { bless {} }

sub get {
    die '"get" is not supported';
}

sub pick {
    my $self = shift;
    my $data = $self->get(@_) || [];
    return $data->[ int( rand(scalar @$data) ) ];
}

sub first {
    my $self = shift;
    my $data = $self->get(@_) || [];
    return $data->[0];
}

1;
