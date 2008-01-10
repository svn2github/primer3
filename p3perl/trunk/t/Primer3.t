# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Primer3.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 7;
BEGIN { use_ok('Primer3') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.


my $fail = 0;
foreach my $constname (qw(
	TESTVAL)) {
  next if (eval "my \$a = $constname; 1");
  if ($@ =~ /^Your vendor has not defined Primer3 macro $constname/) {
    print "# pass: $@";
  } else {
    print "# fail: $@";
    $fail = 1;
  }

}

ok( $fail == 0 , 'Constants' );
#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.


ok(($gs = Primer3::pl_create_global_settings()));
Primer3::pl_set_default_global_args($gs);
ok(($sa = Primer3::pl_create_seq_arg()));
ok(($rv = Primer3::pl_choose_primers($gs, $sa))) ;
ok(($pr = Primer3::pl_create_primer_rec())) ;
#ok(($t = Primer3::pl_oligo_sequence($sa, $pr))) ;
#ok(($t = Primer3::pl_oligo_rev_c_sequence($sa, $pr))) ;
$seq = "this is a test";
ok(!Primer3::pl_set_sa_sequence($sa, $seq)) ;
Primer3::pl_destroy_p3retval($rv);
Primer3::pl_destroy_seq_args($sa);
Primer3::pl_destroy_global_settings($gs);
Primer3::pl_destroy_primer_rec($pr);
