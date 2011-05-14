use strict;
use warnings;
use Hiredis::Async::AnyEvent;
use feature 'say';

my $key = 'OHHAI';
my $value = 'lolcat';
my $i = 300_000;
my $ii = $i;
my $done = AE::cv;
my $redis = Hiredis::Async::AnyEvent->new;

my $set; $set = sub {
    $i--;
    $redis->Command(['SET', $key.$i, $value], $i < 0 ? $done : $set);
};
$set->() for 1..100;

my $timer = AnyEvent->timer( after => 3, interval => 3, cb => sub {
    say "$i items remaining";
});

my $start = AnyEvent->now;
$done->recv;
my $end = AnyEvent->now;

say "\aIt took ". ($end - $start). " seconds";
say " that is ". ($ii/($end - $start)). " per second";

say 'The test is complete. Kill me to continue.';

AnyEvent->condvar->recv;


