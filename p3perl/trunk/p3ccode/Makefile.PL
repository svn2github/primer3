
use ExtUtils::MakeMaker;

if (!-e 'libprimer3.c') {
    die "\n\n\n============================================================\n"
        . "You must put the source files for libprimer3 in ./p3ccode.\n"
	. "For example:\n\n"
        . " perl getCcode.pl\n\n"
	. "============================================================\n\n\n";
 }

$Verbose = 1;
WriteMakefile(
    NAME   => 'Primer3::p3ccode',
    SKIP   => [qw(all static static_lib dynamic dynamic_lib)],
    clean  => {'FILES' => 'libccode$(LIB_EXT)'},
    OPTIMIZE => '-O0 -g'
);


sub MY::top_targets {
        '
MAX_PRIMER_LENGTH = 36

all :: static

pure_all :: static

static ::       libp3ccode$(LIB_EXT)

libp3ccode$(LIB_EXT): $(O_FILES)
	$(AR) cr libp3ccode$(LIB_EXT) $(O_FILES)
	$(RANLIB) libp3ccode$(LIB_EXT)

';
}
