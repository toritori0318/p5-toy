# Toy

It is a toy box for chat!

# Supported Toy Box

- [tiqv (ちくわぶ画像検索)](http://tiqav.com/)
- [lgtm (LGTM.in)](http://www.lgtm.in/)
- [misawa (地獄のミサワ)](http://jigokuno.com/)
- [mstr (飯テロ)](https://mstr.in/)
- [tmublr (Tumblr Tag RSS)](http://tagged.umbls.com/)

# SYNOPSYS

```perl

    use strict;
    use warnings;
    use Toy;
    use Toy::Box::Free;
    use DDP;

    my $toy = Toy->new();

    # tiqav
    p $toy->tiqav->pick;
    p $toy->tiqav->pick('ちくわ');

    # lgtm
    p $toy->lgtm->pick;

    # misawa
    p $toy->misawa->pick;

    # mstr
    p $toy->mstr->pick;

    # tumblr
    p $toy->tumblr->pick('dog');

    # Free Box
    my $free_a = Toy::Box::Free->new([qw/hoge fuga piyo/]);
    p $free_a->pick;
    my $free_b = Toy::Box::Free->new([qw/foo bar baz/]);
    p $free_b->pick;

```

