
# Usage: perl dpal_test.pl [ --valgrind ]
# This is the driver for tests of dpal (dpal.{c,h}, using in the wrapper
# C program ntdpal (coded in ntdpal_main.c)

# ======================================================================
# (c) Copyright 1996,1997,1998,1999,2000,2001,2004,2006,2007, 2008
# Whitehead Institute for Biomedical Research, Steve Rozen, 
# Andreas Untergasser and Helen Skaletsky
# All rights reserved.
# 
#   This file is part of the primer3 suite and the dpal library.
#
#   The primer3 suite is free software; you can
#   redistribute it and/or modify it under the terms of the GNU
#   General Public License as published by the Free Software Foundation;
#   either version 2 of the License, or (at your option) any later
#   version.
#
#   This software is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this file (file gpl-2.0.txt in the source distribution); if
#   not, write to the Free Software Foundation, Inc., 51 Franklin St,
#   Fifth Floor, Boston, MA 02110-1301 USA
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# ======================================================================

use strict;
use warnings 'all';
use Getopt::Long;
use Carp;

our $test_count = 0;
our $exit_status = 0;
our $do_valgrind;


our $valgrind_exe = "/usr/local/bin/valgrind";
our $valgrind_format;

sub main();

main();

sub runtest($$$$$) {
    my ($desc, $ntdpal_args, $infile, $benchfile, $outfile) = @_;
    print $desc, '...';
    open Q, $infile or confess "open $infile: $!";

    # Reopen STDOUT to get all ntdpal output in one file
    open OLDOUT, ">&STDOUT" or confess "Cannot dup STDOUT: $!";
    open STDOUT, '>', $outfile or confess "open STDOUT '>' $outfile: $!";
    while (my $in = <Q>) {
        $test_count++;
        my $valgrind_prefix 
            = $do_valgrind ? sprintf($valgrind_format, $test_count) : '';
        system "$valgrind_prefix ../src/ntdpal $ntdpal_args $in";
    }
    close Q;
    open STDOUT, ">&OLDOUT" or confess "Cannot dup OLDOUT: $!";
    close OLDOUT;
    my $r = system "diff $benchfile $outfile";
    print $r == 0 ? "OK\n" : "FAILED\n";
    if ($r) { $exit_status = -1; }
}

sub main() {

    select STDERR;              # By default, print to STDERR

    if (!GetOptions('valgrind', \$do_valgrind)) {
        print "Usage: $0 [ --valgrind ]\n";
        exit -1;
    }

    if ((!-x $valgrind_exe) && ($do_valgrind)) { 
        warn "Cannot find $valgrind_exe; will try `which valgrind`\n";
        $valgrind_exe= `which valgrind`;
        chomp($valgrind_exe);
        if (!$valgrind_exe || ! -x $valgrind_exe) {
            die "Cannot execute $valgrind_exe";
        }
    }

    $valgrind_format
        = "$valgrind_exe --leak-check=yes "
        . " --show-reachable=yes --log-file-exactly=ntdpal.%0.4d.valg ";


    # Look for the ntdpal executable
    die "Cannot execute ../src/ntdpal" unless -x '../src/ntdpal';


    my $valgrind_prefix = $do_valgrind ? sprintf($valgrind_format, $test_count) : '';

    # ==================================================
    # First test
    # Test error handling on over-long input sequence:
    print 'Error handling of too-long sequence...';
    my $r = system '$valgrind_prefeix ../src/ntdpal ACGTGTTCGTCGTAAATAACATGCTATATT GACGTAGACAACCCTGTGTTTAGCCTGCGTTTTGTGCCATCCTAATGCTTTACTAGATCACTGAGCCACCTCCCAAGGACTACACCTAGCGGTATTTCGTACATTAACTAGGATCCTTTTCCACATGGACTACAATGTCTGCCGAGCATGCGATGGGGTACCGCGCCCGCGCACATACGCGCGCAGAGCTTTTGGAGGCATACCTACACCGGCGAGGGGCTGCGGTTTATTGACACTGAAACGGGATAACGAGTCGCTGAATTGAGCCAAAAATATGCAAGCGTCACAAATTGTGACAAAAATTTTAAAGGAAAAATTAGACCATTGATTCTGAAGTGGTGCGTATAGGACCAGTCGTGGCAATGAGACCGATTTGAGTAGCACTAGCTCAAACACTGTCTGGGTCGCCATCAAGGCCACAAGAACTTAAGCAGCCGTCACCCTATAGAAGGTTAAGCGACGGTTAGGGCTTCTGGCAACGAAAGTTGTCGGTTCGTCCTGTGCCAACGTGTGGCAAAGTCTACTATGATTCGATTGTTGACGTGTCGACAGGCTGTTTCGCTGGATACCCCACCTTGATAATTTTTCTCGTCGAACGCTAGCAGTTTTTTTTTCAACGGCCCGGAATCTGTAAGAGGCCGTTGCAGGAACGCGTGTGTATGTAAATGCCCACTACTTCTGTTATGTACCCAAATGGCGTGCGGCGTGGATGTATAGTGTCGACCCTCCATAATCGGGCGGACGGTCGTGGGGTATGTATGATCTTCGGCACTGATTCGCCTCGAGTCTATATGTTCTTAATCCAGACCTTCGGGGAAAGCCTACTTTCCATCCGTTGTCTAGCGTCATGCCAGTGACTACTGTTGTATTGTCTGGTTCCTAAGATAGCCATGGATTCCGGACATCGACGATGCACAAGAGCGTTAGCGCTGGTGTGCAACGCAACGTCGCGAAGGCTGGGTTACAGCGTGATCTCCTGGCTGCACCCAGATGCAGAGGGACATACCTACGATGAATAGGTGCGTCTGTTTATAAACGCCCAATCCTAGCAAAAATCACAACTAAGACAGTGTATGGAAGACCCACCAGTTGTGGGCGAATGGTCAGGTATACAAGATCGTGTCAAGACGGAACTTAAGCTTCTGTGCGCTCTCCATGCGAGCTGGTACGTCTGGACGGCGAGGTATGAGTGAATGACCATCCATGGCAACTTTCGTGTTCTACGACAGATACGAGCTCGACGGACGACCTGGTGACCAGTAGTATATGCGCGTCCGTCGGCCAGACTTTCCAAACGCCCTTTCAACGAGATACATGCGAACACGCTACAATTTCTCGTTCCGTCTAAAGTCGATACTCGCAAGCCCAGGCCCGTTACTACAACGCTGTTAATAGGATCAGAAGGGCCATAAGACTTTGGCAGCGGTAGCTAGGAAAGTGATGGTTGTGATGGCCCTAGTAAGGAGTCAGCCATCTACCCAACTATTTGAATGGGACCATAGCCAAGGGACCCAGCTGTTCCTTAGAAACCTGGTGACTCCCTTAGCCAATTGTGTAACTTCGTGCGTGCCAGTATTACACCTATAATCACAAGACCCCTTCAATACGAGTCCTGTGGCGTAGTGTTCCATCAAAACAATCAAGAACAGATTTCCGGTCCCCGTTGTGTTGGGATCTAGCGGACGTTGTCGGTAGATCAATAACGTAAATGCGAATCGAAGTTCTCTGGCCTAAAACAACTGCGCGCAGGGCCTCCGGTCATTGCATCTTTCTTGTCTCTCGTGAGGGCGTGATTCGTTTACCTGGAGCGAGCCGGGCACAAGAGCTATGGATTATTGGCTGGTGCAAAAACCATTCTAGCTACAATTATACTCGCGTGTCGACGATAAGAGTGAAATCACTGCGTAGGCAAACTGCCGGGTCACCAAGAGAGGCTGATACCGCGGTTCACCC l > dpal.tmp 2>&1';
    open X, 'dpal.tmp';         # Get the test output
    my @foo = <X>;              # Snarf it
    close X;
   # Check the output.....
    if ($foo[0] eq "Error: Sequence 2 longer than DPAL_MAX_ALIGN and alignment is requested\n") {
        print "OK\n"
        } else {
            print "FAILED\n";
            $exit_status = -1;
        }

    # ==================================================
    # Additiona tests using runtest()
    runtest('Default implementations + alignment',
            "",  "dpal_input", 'dpal_output',
            'dpal_output1.tmp');

    runtest('Default implementations + NO alignment 1',
            "-s",  'dpal_input', 'dpal_score_output',
            'dpal_score_output1.tmp');

    runtest('Default implementations + NO alignment 2',
            "-s", "dpal_long_input", 'dpal_long_score_output',
            "dpal_long_score_output1.tmp");

    runtest('Force _dpal_generic',
            '-s -f1', "dpal_input", 'dpal_score_output',
            "dpal_score_output4.tmp");

    runtest('Force _dpal_long_nopath_generic 1',
            '-s -f2', "dpal_input", 'dpal_score_output',
            "dpal_score_output2.tmp");

    runtest('Force _dpal_long_nopath_generic 2',
            '-s -f2', "dpal_long_input", 'dpal_long_score_output',
            "dpal_long_score_output2.tmp");

    runtest('Force long maxgap1 functions 1',
            '-s -f3',  "dpal_input", 'dpal_score_output',
            "dpal_score_output3.tmp");

    runtest('Force long maxgap1 functions 2',
            '-s -f3',  "dpal_long_input", 'dpal_long_score_output', 
            "dpal_long_score_output3.tmp");



    # ================================================== 
    # If we were running under valgrind to look for memory-related
    # errors (reading uninitialized memory, writing off the end of
    # an array, etc) or leaks, then we look through the valgrind
    # logs to summarize errors and leaks.
    if ($do_valgrind) {
        # Assume this is Unix/Linux envrionment, so
        # we have grep.
        my $r = system "grep ERROR ntdpal.*.*valg | grep -v 'ERROR SUMMARY: 0 errors'";
        if (!$r) { # !$r because grep returns 0 if something is found,
            # and if something is found, we have a problem.
            $exit_status = -1;
        }
        $r = system "grep 'definitely lost' ntdpal.*.*valg | grep -v '0 bytes'";
        if (!$r) {
            $exit_status = -1;
        }
        $r = system "grep 'possibly lost' ntdpal.*.*valg  | grep -v '0 bytes'";
        if (!$r) {
            $exit_status = -1;
        }
    }

    exit $exit_status;
}
