package Toy::Box::Free;
use strict;
use warnings;
use parent 'Toy::Box::Base';

sub new {
    my $class = shift;
    my $stash = shift;
    my $self = bless {
        stash => $stash,
        @_,
    }, $class;
    $self;
}

sub get {
    my ($self) = @_;
    return $self->{stash};
}

1;
