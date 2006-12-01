#!/usr/bin/perl


print "Content-type: text/plain\n";
print "\n";

open (fh, "< rodent_ref.txt") || die "Can't open drosophila file";

while (<fh>) {
    print $_;
}
