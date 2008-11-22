#!perl


print "Content-type: text/plain\n";
print "\n";

$file = shift;

open (fh, $file) || die "Can't open file: $file, not found\n";

while (<fh>) {
    print $_;
}
