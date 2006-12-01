#!/usr/bin/perl

print "Content-type: text/plain\n";
print "\n";

$file = "${DATA}drosophila.w.transposons.txt";

open (fh, $file) || die "Can't open file: $file, not found\n";

while (<fh>) {
    print $_;
}
