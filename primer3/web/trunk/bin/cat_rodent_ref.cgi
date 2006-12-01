#!/usr/bin/perl


print "Content-type: text/plain\n";
print "\n";

$file = "${DATA}rodent_ref.txt";

open (fh, "< $file") || die "Can't open $file";

while (<fh>) {
    print $_;
}
