package Toy::Box::Ranking;
use strict;
use warnings;
use parent 'Toy::Box::Base';
use Redis;

sub new {
    my $class = shift;
    my $stash = shift;
    my $self = bless {
        redis => Redis->new(),
        @_,
    }, $class;
    $self;
}

sub calc {
    my ($self, $message) = @_;

    my ($uid, $incr_decr);
    if($message =~ /^(\w+)\+\+/) {
        $uid = $1;
        $incr_decr = 1;
    }
    elsif($message =~ /^(\w+)\-\-/) {
        $uid = $1;
        $incr_decr = -1;
    }
    else {
        return;
    }

    # zincr
    $self->{redis}->zincrby('toy_user_ranking', $incr_decr, $uid);
    my $score = $self->{redis}->zscore('toy_user_ranking', $uid);
    return {
        uid   => $uid,
        score => $score,
    }
}

sub get_userranking {
    my ($self) = @_;
    my %ranking = $self->{redis}->zrevrange('toy_user_ranking', 0, 5, 'WITHSCORES');
    return [ map { {'uid' => $_, 'score' => $ranking{$_}} } reverse sort { $ranking{$a} <=> $ranking{$b} } keys %ranking];
}

1;
