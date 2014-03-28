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

# free
my $free_a = Toy::Box::Free->new([qw/hoge fuga piyo/]);
p $free_a->pick;
my $free_b = Toy::Box::Free->new([qw/foo bar baz/]);
p $free_b->pick;

# tenki
#  天気：関東/東京
p $toy->tenki->first('forecast','city_63');
#  火山情報：全国
p $toy->tenki->get('volcano','recent_entries');
#  津波情報
p $toy->tenki->get('tsunami','entry');
#  地震情報：本日
p $toy->tenki->get('earthquake','recent_entries_by_day');
# more...
#  http://tenki.jp/webservice/rss/

# ranking
# toritsuyo
my $message = 'toritsuyo++';
p $toy->ranking->calc($message);
p $toy->ranking->calc($message);
p $toy->ranking->calc($message);
$message = 'toritsuyo--';
p $toy->ranking->calc($message);
# bucho
$message = 'bucho++';
p $toy->ranking->calc($message);
# get
p $toy->ranking->get_userranking();
