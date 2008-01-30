package Primer3;

use 5.008;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Primer3 ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
pl_create_p3retval
pl_destroy_p3retval
pl_add_to_gs_product_size_range
pl_get_rv_and_gs_warnings
pl_get_rv_global_errors
pl_get_rv_per_sequence_errors
pl_get_rv_output_type
pl_get_rv_warnings
pl_get_rv_stop_codon_pos
pl_add_to_sa_excl2
pl_add_to_sa_excl_internal2
pl_add_to_sa_tar2
pl_boulder_print
pl_choose_primers
pl_create_global_settings
pl_destroy_global_settings
pl_create_seq_arg	
pl_destroy_seq_args
pl_empty_gs_product_size_range
pl_set_gs_primer_ambiguity_codes_consensus
pl_set_gs_primer_divalent_conc
pl_set_gs_primer_dna_conc
pl_set_gs_primer_dntp_conc
pl_set_gs_primer_explain_flag
pl_set_gs_primer_file_flag
pl_set_gs_primer_first_base_index
pl_set_gs_primer_gc_clamp
pl_set_gs_primer_inside_penalty
pl_set_gs_primer_internal_oligo_divalent_conc
pl_set_gs_primer_internal_oligo_dna_conc
pl_set_gs_primer_internal_oligo_dntp_conc
pl_set_gs_primer_internal_oligo_max_gc
pl_set_gs_primer_internal_oligo_max_mishyb
pl_set_gs_primer_internal_oligo_max_poly_x
pl_set_gs_primer_internal_oligo_max_size
pl_set_gs_primer_internal_oligo_max_template_mishyb
pl_set_gs_primer_internal_oligo_max_tm
pl_set_gs_primer_internal_oligo_min_gc
pl_set_gs_primer_internal_oligo_min_quality
pl_set_gs_primer_internal_oligo_min_size
pl_set_gs_primer_internal_oligo_min_tm
pl_set_gs_primer_internal_oligo_num_ns
pl_set_gs_primer_internal_oligo_opt_gc_percent
pl_set_gs_primer_internal_oligo_opt_size
pl_set_gs_primer_internal_oligo_opt_tm
pl_set_gs_primer_internal_oligo_salt_conc
pl_set_gs_primer_internal_oligo_self_any
pl_set_gs_primer_internal_oligo_self_end
pl_set_gs_primer_io_wt_compl_any
pl_set_gs_primer_io_wt_compl_end
pl_set_gs_primer_io_wt_end_qual
pl_set_gs_primer_io_wt_gc_percent_gt
pl_set_gs_primer_io_wt_gc_percent_lt
pl_set_gs_primer_io_wt_num_ns
pl_set_gs_primer_io_wt_rep_sim
pl_set_gs_primer_io_wt_seq_qual
pl_set_gs_primer_io_wt_size_gt
pl_set_gs_primer_io_wt_size_lt
pl_set_gs_primer_io_wt_template_mishyb
pl_set_gs_primer_io_wt_tm_gt
pl_set_gs_primer_io_wt_tm_lt
pl_set_gs_primer_liberal_base
pl_set_gs_primer_lowercase_masking
pl_set_gs_primer_max_end_stability
pl_set_gs_primer_max_gc
pl_set_gs_primer_max_mispriming
pl_set_gs_primer_max_poly_x
pl_set_gs_primer_max_size
pl_set_gs_primer_max_template_mispriming
pl_set_gs_primer_max_tm
pl_set_gs_primer_max_diff_tm
pl_set_gs_primer_min_end_quality
pl_set_gs_primer_min_gc
pl_set_gs_primer_min_quality
pl_set_gs_primer_min_size
pl_set_gs_primer_min_tm
pl_set_gs_primer_mishyb_library
pl_set_gs_primer_internal_oligo_mishyb_library
pl_set_gs_primer_mispriming_library
pl_set_gs_primer_num_ns_accepted
pl_set_gs_primer_num_return
pl_set_gs_primer_opt_gc_percent
pl_set_gs_primer_opt_size
pl_set_gs_primer_opt_tm
pl_set_gs_primer_outside_penalty
pl_set_gs_primer_pair_max_mispriming
pl_set_gs_primer_pair_max_template_mispriming
pl_set_gs_primer_pair_wt_compl_any
pl_set_gs_primer_pair_wt_compl_end
pl_set_gs_primer_pair_wt_diff_tm
pl_set_gs_primer_pair_wt_io_penalty
pl_set_gs_primer_pair_wt_pr_penalty
pl_set_gs_primer_pair_wt_product_size_gt
pl_set_gs_primer_pair_wt_product_size_lt
pl_set_gs_primer_pair_wt_product_tm_gt
pl_set_gs_primer_pair_wt_product_tm_lt
pl_set_gs_primer_pair_wt_rep_sim
pl_set_gs_primer_pair_wt_template_mispriming
pl_set_gs_primer_pick_anyway
pl_set_gs_primer_pick_internal_oligo
pl_set_gs_primer_pick_left_primer
pl_set_gs_primer_pick_right
pl_set_gs_primer_product_max_tm
pl_set_gs_primer_product_min_tm
pl_set_gs_primer_product_opt_size
pl_set_gs_primer_product_opt_tm
pl_set_gs_primer_quality_range_max
pl_set_gs_primer_quality_range_min
pl_set_gs_primer_salt_conc
pl_set_gs_primer_salt_corrections
pl_set_gs_primer_self_any
pl_set_gs_primer_self_end
pl_set_gs_primer_task
pl_set_gs_primer_tm_santalucia
pl_set_gs_primer_wt_compl_any
pl_set_gs_primer_wt_compl_end
pl_set_gs_primer_wt_end_qual
pl_set_gs_primer_wt_end_stability
pl_set_gs_primer_wt_gc_percent_gt
pl_set_gs_primer_wt_gc_percent_lt
pl_set_gs_primer_wt_num_ns
pl_set_gs_primer_wt_pos_penalty
pl_set_gs_primer_wt_rep_sim
pl_set_gs_primer_wt_seq_qual
pl_set_gs_primer_wt_size_gt
pl_set_gs_primer_wt_size_lt
pl_set_gs_primer_wt_template_mispriming
pl_set_gs_primer_wt_tm_gt
pl_set_gs_primer_wt_tm_lt
pl_set_gs_prmax
pl_set_gs_prmin
pl_set_sa_incl_l
pl_set_sa_incl_s
pl_set_sa_internal_input
pl_set_sa_left_input
pl_set_sa_empty_quality
pl_sa_add_to_quality_array
pl_set_sa_primer_opt_size
pl_set_sa_right_input
pl_set_sa_sequence
pl_set_sa_sequence_name
pl_set_sa_start_codon_pos
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Primer3', $VERSION);

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Primer3 - Perl extension to call libprimer3.  See http://primer3.sourceforge.net/

=head1 SYNOPSIS

  use Primer3 ':all';

  my $global_settings = pl_create_global_settings();

  # Call functions to override defaults in $global_settings,
  # for example,

  



  my $retval = XXXXXX_choose_primers($global_settings,
                                     $per_sequence_arguments);



=head1 DESCRIPTION



Blah blah blah.

=head2 EXPORT

None by default.



=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Steve Rozen, E<lt>rozen@wi.mit.eduE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Steve Rozen

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.0 or,
at your option, any later version of Perl 5 you may have available.


=cut
