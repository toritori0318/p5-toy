#!/usr/bin/env perl
####################################
# usage:
#   @unazusan
#   @unazusan jojo
#   @unazusan tiqav [<word>]
#   @unazusan lgtm
#   @unazusan misawa
#   @unazusan mstr
#   @unazusan tmublr <word>
#
####################################
use 5.010;
use warnings;
use utf8;
use Encode qw/encode_utf8/;
use Toy;
use Toy::Box::Free;
my $toy = Toy->new();

my @commands = qw/
    help
    jojo
    tiqav
    lgtm
    misawa
    mstr
    tmublr
/;
my $free_unazukun = Toy::Box::Free->new(
    [qw/
    うんうん('-'*)
    だよねー('-'*)
    /]
);
my $free_jojo = Toy::Box::Free->new(
    [qw/
    貧弱！貧弱ゥ！
    レロレロレロレロ
    無駄無駄無駄無駄無駄無駄無駄無駄無駄無駄無駄無駄無駄ァーーーッ
    ゴゴゴゴゴゴゴゴゴ
    ドドドドドドドドド
    /]
);




use UnazuSan;
my $unazu_san = UnazuSan->new(
    host       => 'localhost',
    port       => '6667',
    #password   => 'xxxxxxxxxxxxxxxxxxxxxxxxx',
    #enable_ssl => 1,
    join_channels => [qw/main/],
    respond_all   => 1,
    nickname   => 'unazusan',
);

$unazu_san->on_message(
    qr/^(\s*unazusan:|\@unazusan)(.*)/ => sub {
        my ($receive, @args) = @_;
        # コマンドに一致しない時は、unazusanがreplyする
        $receive->reply($free_unazukun->pick)
            unless grep($args[1], @commands);
    },
    qr/(.)/ => sub {
        my ($receive, $match) = @_;
        # 全てのワードにマッチする処理
        #say $match;
        #say $receive->message;
    },
);
# help
$unazu_san->on_command(
    help => sub {
        my ($receive, @args) = @_;
        my $cmd = $args[0] || '';
        unless($cmd) {
            $receive->reply('help:');
            $receive->reply(' @unazusan jojo / tiqav / lgtm / misawa / mstr / tumblr');
        }
    }
);
# jojo(free)
$unazu_san->on_command(
    jojo => sub { $_[0]->reply($free_jojo->pick) }
);
# tiqav
$unazu_san->on_command(
    tiqav => sub {
        my ($receive, @args) = @_;
        my $data = $toy->tiqav->pick($args[0]||'');
        $receive->reply($data->{image_link} .' '. $data->{site_link});
    }
);
# lgtm
$unazu_san->on_command(
    lgtm => sub {
        my ($receive, @args) = @_;
        my $data = $toy->lgtm->pick;
        $receive->reply($data->{image_link} .' '. $data->{site_link});
    }
);
# misawa
$unazu_san->on_command(
    misawa => sub {
        my ($receive, @args) = @_;
        my $data = $toy->misawa->pick;
        $receive->reply($data->{image_link} .' '. $data->{site_link});
    }
);
# mstr
$unazu_san->on_command(
    mstr => sub {
        my ($receive, @args) = @_;
        my $data = $toy->mstr->pick;
        $receive->reply($data->{image_link} .' '. $data->{site_link});
    }
);
# tumblr
$unazu_san->on_command(
    tumblr => sub {
        my ($receive, @args) = @_;
        my $data = $toy->tumblr->pick($args[0]||'');
        $receive->reply($data->{image_link} .' '. $data->{site_link});
    }
);

$unazu_san->run;
