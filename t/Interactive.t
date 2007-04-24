#!perl -T

use warnings;

use Test::More tests => 2;

use HTML::ListScraper;
use HTML::ListScraper::Interactive qw(format_tags canonicalize_tags);

my $scraper = HTML::ListScraper->new( api_version => 3,
				      marked_sections => 1 );
$scraper->parse_file("testdata/synth.html");
my @seq = $scraper->get_sequences;
my $seq = shift @seq;
my @inst = $seq->instances;
my $inst = shift @inst;

my $expected = <<EXPECTED
<tr>
  <td>
  </td>
  <td>
  </td>
</tr>
EXPECTED
;

my @formatted = format_tags($scraper, [ $inst->tags ]);
my $formatted = join '', @formatted;
is($formatted, $expected);

my @expected = qw(tr td /td td /td /tr);
my @plain = canonicalize_tags(@formatted);
is_deeply(\@plain, \@expected);

