package Toy::Box::Mstr;
use strict;
use warnings;
use parent 'Toy::Box::Base';
use LWP::UserAgent;
use JSON;
use URI::Escape;

sub new {
    my $class = shift;
    my $self = bless {
        api_url  => 'https://mstr.in',
        site_url => 'https://mstr.in',
        img_url  => 'https://pic.mstr.in',
        @_,
    }, $class;
    $self;
}

sub get {
    my ($self) = @_;
    my $json = $self->_get_api('/api/photos.json?page=0');
    $self->{data} = $self->_append_ext_attribute($json->{photos});
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
            $_->{image_link} = sprintf("%s/thumbnails/%s.jpg",    $self->{img_url},  $_->{uid});
            $_->{site_link}  = sprintf("%s/photos/%s", $self->{site_url}, $_->{uid});
            $_;
        } @$rows
    ];
}

1;
