#!/usr/local/bin/perl5.00404 -w

($old_release, $new_release) = @ARGV;

print STDERR "Changing release numbers in tests from $old_release to $new_release\n";

system("perl fix_release_number.pl $old_release $new_release *_formatted_output");
system("perl fix_release_number.pl $old_release $new_release primer_global_err/empty_1.out2");


