my @files = qw/
dpal.c
dpal.h
libprimer3.c
libprimer3.h
oligotm.c
oligotm.h
p3_seq_lib.c
p3_seq_lib.h

print_boulder.c
print_boulder.h

format_output.c
format_output.h
    /;

my $rp = "../../primer3/trunk/src/";
for my $f (@files) {
    my $cmd =  "cp -f ${rp}$f ./p3ccode/";
    system $cmd;
}
