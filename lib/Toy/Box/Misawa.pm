package Toy::Box::Misawa;
use strict;
use warnings;
use parent 'Toy::Box::Base';
use XML::FeedPP;
use Web::Scraper;
use URI;

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
        my $url = $item->link;
        my $image_link;
        if($item->get('content:encoded') =~ /src="([^"]*)"/) {
            $image_link = $1;
        }
        push @rows, {
            url => $url,
            image_link => $image_link,
        };
    }
    return \@rows;
}

sub _scraper {
    my ($self, $path) = @_;

    my $url = sprintf("%s/%s", $self->{site_url}, $path);
    my $uri = URI->new($url);
    my $scraper = scraper {
        process '//input[@id="imageUrl"]', 'image_url' => '@value';
        process '//input[@id="dataUrl"]',  'data_url'  => '@value';
    };
    return $scraper->scrape($uri);
}

1;

