#!perl

use warnings;

use Test::More tests => 3;
use File::Compare;
use Fatal qw(mkdir rmdir unlink);

if (!-d "tmp") {
    mkdir("tmp");
}

check('all');
check('l');

checked_system("./scrape --min-count=12 --core=a --detail=none testdata/del.icio.us.html > tmp/del.icio.us.yaml");
my $d = compare("testdata/del.icio.us-overview.yaml", "tmp/del.icio.us.yaml");
if (!$d) {
    unlink("tmp/del.icio.us.yaml");
}

ok(!$d);

rmdir("tmp");

sub check {
    my $core = shift;

    checked_system("./scrape --core=$core testdata/synth.html > tmp/$core.yaml");
    my $d = compare("testdata/synth-default.yaml", "tmp/$core.yaml");
    if (!$d) {
        unlink("tmp/$core.yaml");
    }

    ok(!$d);
}

sub checked_system {
    my $cmd = shift;

    my $r = system($cmd);
    if ($r) {
        die "can't execute scrape";
    }
}

