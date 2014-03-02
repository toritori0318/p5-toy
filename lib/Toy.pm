package Toy;
use strict;
use warnings;
use Toy::Box::Free;
use Toy::Box::Tiqav;
use Toy::Box::Lgtm;
use Toy::Box::Misawa;
use Toy::Box::Mstr;

sub new {
    my $class = shift;
    my $self = bless {
        free   => Toy::Box::Free->new,
        tiqav  => Toy::Box::Tiqav->new,
        lgtm   => Toy::Box::Lgtm->new,
        misawa => Toy::Box::Misawa->new,
        mstr   => Toy::Box::Mstr->new,
        @_,
    }, $class;
    $self;
}

sub free   { $_[0]->{free} }
sub tiqav  { $_[0]->{tiqav} }
sub lgtm   { $_[0]->{lgtm} }
sub misawa { $_[0]->{misawa} }
sub mstr   { $_[0]->{mstr} }

1;
