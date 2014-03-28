package Toy::Box::Tenki;
use strict;
use warnings;
use parent 'Toy::Box::Base';
use XML::FeedPP;

sub new {
    my $class = shift;
    my $self = bless {
        rss_url => 'http://tenki.jp/component/static_api/rss',
        @_,
    }, $class;
    $self;
}

sub get {
    my ($self, $category, $file) = @_;
    die 'Require category.' unless $category;
    die 'Require file.'     unless $file;

    my @rows;
    my $url = sprintf('%s/%s/%s.xml', $self->{rss_url}, $category, $file);
    my $feed = XML::FeedPP->new($url);
    for my $item ($feed->get_item()) {
        my $title      = $item->title;
        my $site_link  = $item->link;
        my $image_link = $item->image;
        push @rows, {
            title      => $title,
            site_link  => $site_link,
            image_link => $image_link,
        };
    }
    return \@rows;
}

1;

