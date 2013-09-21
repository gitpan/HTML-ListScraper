use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'HTML::ListScraper',
    AUTHOR              => 'Vaclav Barta <vbar@comp.cz>',
    VERSION_FROM        => 'lib/HTML/ListScraper.pm',
    ABSTRACT_FROM       => 'lib/HTML/ListScraper.pm',
    PL_FILES            => {},
    PREREQ_PM => {
	'HTML::Parser' => 0,
	'Class::Generate' => 0,
	'Algorithm::NeedlemanWunsch' => '0.04',
	'LWP' => 0,
        'IPC::Run3'=> 0,
        'Probe::Perl' => 0
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'HTML-ListScraper-*' },
);

# PREREQ_PM doesn't enforce the prerequisite version; that is a
# problem for Algorithm::NeedlemanWunsch, because it's buggy before
# 0.04, making this module's tests fail. Let's check explicitly:
my $version_check = q(require Algorithm::NeedlemanWunsch;
    $Algorithm::NeedlemanWunsch::VERSION >= 0.04);
my $r = eval $version_check;
if ($@ || !$r) {
  warn "required version of Algorithm::NeedlemanWunsch (0.04) not found.";
  exit 1;
}
