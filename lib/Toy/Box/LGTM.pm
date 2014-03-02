package Toy::Box::Lgtm;
use strict;
use warnings;
use parent 'Toy::Box::Base';
use Web::Scraper;
use URI;

sub new {
    my $class = shift;
    my $self = bless {
        site_url => 'http://www.lgtm.in',
        data => [],
        @_,
    }, $class;
    $self;
}

sub get {
    my ($self) = @_;
    # always single
    return [$self->_scraper('/g')];
}

sub _scraper {
    my ($self, $path) = @_;

    my $url = sprintf("%s/%s", $self->{site_url}, $path);
    my $uri = URI->new($url);
    my $scraper = scraper {
        process '//input[@id="imageUrl"]', 'image_link' => '@value';
        process '//input[@id="dataUrl"]',  'site_link'  => '@value';
    };
    return $scraper->scrape($uri);
}

1;
