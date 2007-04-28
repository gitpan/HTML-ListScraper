#!perl

use warnings;

use vars qw(*F);

use Test::More tests => 3;
use Fatal qw(open mkdir rmdir unlink);
use IPC::Run3 qw/run3/;
use Probe::Perl;

sub check;

my $perl = Probe::Perl->find_perl_interpreter;

check('scrape --core=all testdata/synth.html',
      'testdata/synth-default.yaml');
check('scrape --core=l testdata/synth.html',
      'testdata/synth-default.yaml');
check('scrape --min-count=12 --core=a --detail=none testdata/del.icio.us.html',
      'testdata/del.icio.us-overview.yaml');

sub check {
    my ($cmd, $datapath) = @_;

    my $stdout;
    run3("$perl $cmd", undef, \$stdout, undef);

    open(F, $datapath);
    my $data = join '', <F>;

    is($stdout, $data);
}
