package Toy::Box::Tiqav;
use strict;
use warnings;
use parent 'Toy::Box::Base';
use LWP::UserAgent;
use JSON;
use URI::Escape;

sub new {
    my $class = shift;
    my $self = bless {
        api_url  => 'http://api.tiqav.com',
        img_url  => 'http://img.tiqav.com',
        site_url => 'http://tiqav.com',
        data => [],
        @_,
    }, $class;
    $self;
}

sub get {
    my ($self, $keyword) = @_;
    if($keyword) {
        return $self->_search($keyword);
    } else {
        return $self->_random();
    }
}

sub _random {
    my ($self) = @_;
    my $json = $self->_get_api('/search/random.json');
    $self->{data} = $self->_append_ext_attribute($json);
}

sub _search {
    my ($self, $keyword) = @_;
    my $json = $self->_get_api('/search.json', { q => $keyword });
    $self->{data} = $self->_append_ext_attribute($json);
}

sub _get_api {
    my ($self, $path, $params) = @_;

    my $url = sprintf('%s%s', $self->{api_url}, $path);
    my $uri = URI->new($url);
    $uri->query_form($params) if $params;

    my $ua = LWP::UserAgent->new();
    my $res = $ua->get($uri);
    if($res->is_success) {
        return JSON::decode_json($res->decoded_content);
    } else {
        die $res->status_line;
    }
}

sub _append_ext_attribute {
    my ($self, $rows) = @_;
    return [
        map {
            $_->{image_link} = sprintf("%s/%s.%s", $self->{img_url},  $_->{id}, $_->{ext});
            $_->{site_link}  = sprintf("%s/%s",    $self->{site_url}, $_->{id});
            $_;
        } @$rows
    ];
}

1;
