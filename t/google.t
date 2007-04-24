#!perl -T

use warnings;

use Test::More tests => 101;

use HTML::ListScraper;

my $scraper = HTML::ListScraper->new( api_version => 3,
				      marked_sections => 1 );
my @ignore_tags = qw(b i em strong);
$scraper->ignore_tags(@ignore_tags);
$scraper->parse_file("testdata/google.html");

my @seq = $scraper->get_sequences;
is(scalar(@seq), 2);
my $seq = shift @seq;
isa_ok($seq, 'HTML::ListScraper::Sequence');
is($seq->len, 46);

my @inst = $seq->instances;
is(scalar(@inst), 4);

my @names = qw(div h2 a /a /h2 table tr td font br span /span nobr a /a a /a
	       /nobr /font /td /tr /table /div div h2 a /a /h2 table tr td
	       font br span /span nobr a /a a /a /nobr /font /td /tr /table
	       /div);
my $inst = $inst[2];
my @tags = $inst->tags;
my $i = 0;
while ($i < scalar(@names)) {
    my $tag = $tags[$i];
    isa_ok($tag, 'HTML::ListScraper::Tag');
    is($tag->name, $names[$i]);

    ++$i;
}

$seq = shift @seq;
isa_ok($seq, 'HTML::ListScraper::Sequence');
is($seq->len, 92);

@inst = $seq->instances;
is(scalar(@inst), 2);

$seq = $scraper->get_known_sequence(@names[0..11]);
isa_ok($seq, 'HTML::ListScraper::Sequence');

@inst = $seq->instances;
is(scalar(@inst), 10);
