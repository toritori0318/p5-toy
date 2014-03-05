package Toy;
use strict;
use warnings;
our $VERSION = '0.01';

use Toy::Box::Free;
use Toy::Box::Tiqav;
use Toy::Box::Lgtm;
use Toy::Box::Misawa;
use Toy::Box::Mstr;
use Toy::Box::Tumblr;

sub new {
    my $class = shift;
    my $self = bless {
        free   => Toy::Box::Free->new,
        tiqav  => Toy::Box::Tiqav->new,
        lgtm   => Toy::Box::Lgtm->new,
        misawa => Toy::Box::Misawa->new,
        mstr   => Toy::Box::Mstr->new,
        tumblr => Toy::Box::Tumblr->new,
        @_,
    }, $class;
    $self;
}

sub free   { $_[0]->{free} }
sub tiqav  { $_[0]->{tiqav} }
sub lgtm   { $_[0]->{lgtm} }
sub misawa { $_[0]->{misawa} }
sub mstr   { $_[0]->{mstr} }
sub tumblr { $_[0]->{tumblr} }

1;
