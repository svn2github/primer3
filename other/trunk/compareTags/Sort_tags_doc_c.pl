#!/usr/bin/perl -w


use strict;


# Copy here
my $c_string = qq{
PRIMER_MAX_SELF_END_TH
PRIMER_INTERNAL_WT_SELF_END_TH
PRIMER_INTERNAL_MAX_SELF_END_TH
PRIMER_PAIR_MAX_COMPL_ANY_TH
PRIMER_PAIR_MAX_TEMPLATE_MISPRIMING_TH
PRIMER_PAIR_WT_TEMPLATE_MISPRIMING_TH
PRIMER_PAIR_WT_COMPL_ANY_TH
PRIMER_INTERNAL_WT_HAIRPIN_TH
PRIMER_PAIR_WT_COMPL_END_TH
PRIMER_WT_SELF_ANY_TH
PRIMER_PAIR_MAX_COMPL_END_TH
PRIMER_MAX_SELF_ANY_TH
PRIMER_INTERNAL_MAX_SELF_ANY_TH
PRIMER_WT_SELF_END_TH
PRIMER_INTERNAL_MAX_TEMPLATE_MISHYB_TH
PRIMER_WT_TEMPLATE_MISPRIMING_TH
PRIMER_MAX_TEMPLATE_MISPRIMING_TH
PRIMER_INTERNAL_WT_TEMPLATE_MISHYB_TH
PRIMER_INTERNAL_MAX_HAIRPIN_TH
PRIMER_WT_HAIRPIN_TH
PRIMER_MAX_HAIRPIN_TH
PRIMER_PAIR_MAX_HAIRPIN_TH
PRIMER_INTERNAL_WT_SELF_ANY_TH

    };



print"start processing\n";
my @raw_c_tags = split '\n', $c_string;

my %c_tags;

foreach my $tag_holder (@raw_c_tags) {
	if (($tag_holder=~ /^SEQUENCE_/) or ($tag_holder=~ /^P3_/) 
				or ($tag_holder=~ /^PRIMER_/)){
		$c_tags{$tag_holder} = "";
	}
}

foreach my $tag_holder (sort(%c_tags)) {
	if (($tag_holder=~ /^SEQUENCE_/) or ($tag_holder=~ /^P3_/) 
				or ($tag_holder=~ /^PRIMER_/)){
		print $tag_holder."\n";
	}

}
print"end processing\n";

