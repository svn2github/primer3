#!/usr/local/bin/perl5 -i.bak

$old_rev_string = shift @ARGV;
$new_rev_string = shift @ARGV;

die unless defined $old_rev_string;
die unless defined $new_rev_string;

while (<>) {
    s/primer3 release $old_rev_string/primer3 release $new_rev_string/;
    print;
}

