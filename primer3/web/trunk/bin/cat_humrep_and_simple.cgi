#!/usr/bin/perl


print "Content-type: text/plain\n";
print "\n";

$file = "${DATA}humrep_and_simple.txt";

open (fh, "< $file") || die "Can't open $file";

while (<fh>) {
    print $_;
}
