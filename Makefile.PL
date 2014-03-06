use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'toy',
    AUTHOR        => 'toritori0318 <toritori0318@gmail.com>',
    VERSION_FROM  => 'lib/Toy.pm',
    PREREQ_PM     => {
        'Web::Scraper'    => '0',
        'XML::FeedPP'     => '0',
        'LWP::UserAgent'  => '0',
        'JSON'            => '0',
        'URI'             => '0',
        'URI::Escape'     => '0',
        'Redis'           => '0',
    },
    MIN_PERL_VERSION => '5.008001',
    LICENSE => 'perl',
);

