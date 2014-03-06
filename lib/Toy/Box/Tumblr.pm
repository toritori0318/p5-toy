package Toy::Box::Tumblr;
use strict;
use warnings;
use parent 'Toy::Box::Base';
use XML::FeedPP;

sub new {
    my $class = shift;
    my $self = bless {
        rss_url => 'http://tagged.umbls.com',
        @_,
    }, $class;
    $self;
}

sub get {
    my ($self, $word) = @_;
    die 'Require search word.' unless $word;

    my @rows;
    my $url = sprintf("%s/%s", $self->{rss_url}, $word);
    my $feed = XML::FeedPP->new($url);
    for my $item ($feed->get_item()) {
        my $url = $item->link;
        my $image_link;
        if($item->get('description') =~ /src="([^"]*)"/) {
            $image_link = $1;
        }
        next unless $image_link;

        push @rows, {
            site_link  => $url,
            image_link => $image_link,
            title      => $item->title,
        };
    }
    return \@rows;
}

1;
