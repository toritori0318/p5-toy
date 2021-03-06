package Toy::Box::Misawa;
use strict;
use warnings;
use parent 'Toy::Box::Base';
use XML::FeedPP;

sub new {
    my $class = shift;
    my $self = bless {
        rss_url => 'http://jigokuno.com/?mode=rss',
        @_,
    }, $class;
    $self;
}

sub get {
    my ($self) = @_;

    my @rows;
    my $feed = XML::FeedPP->new($self->{rss_url});
    for my $item ($feed->get_item()) {
        my $site_link = $item->link;
        my $image_link;
        if($item->get('content:encoded') =~ /src="([^"]*)"/) {
            $image_link = $1;
        }
        push @rows, {
            site_link  => $site_link,
            image_link => $image_link,
        };
    }
    return \@rows;
}

1;
