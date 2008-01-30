#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include <sys/vfs.h>


#include "ppport.h"

#include <p3ccode/dpal.h>
#include <p3ccode/oligotm.h>
#include <p3ccode/libprimer3.h>
#include <p3ccode/print_boulder.h>
#include <p3ccode/p3_seq_lib.h>

#include "const-c.inc"



MODULE = Primer3		PACKAGE = Primer3		

INCLUDE: const-xs.inc


UV 
pl_create_global_settings()

	CODE:
	
	p3_global_settings * p ;
	
	p = p3_create_global_settings() ;
	
	RETVAL = (UV) p ;
       	OUTPUT:
	RETVAL
	
void 
pl_destroy_p3retval(s)
	UV s ;

	CODE:
	
	destroy_p3retval((p3retval *) s) ;

       	OUTPUT:

UV 
pl_create_seq_arg()

	CODE:

	seq_args * p;

	p = create_seq_arg() ;

	RETVAL =   (UV) p ;
       	OUTPUT:
	RETVAL

void 
pl_destroy_seq_args(s)
	UV s ;

	CODE:
	
	destroy_seq_args((seq_args *) s) ;

       	OUTPUT:


void
pl_set_default_global_args(gs)
	UV  gs ;

	CODE:

	pr_set_default_global_args((p3_global_settings *)gs) ;

       	OUTPUT:

void 
pl_destroy_global_settings(gs)
	UV   gs ;

	CODE:
	
	free((p3_global_settings *)gs) ;
# fix	destroy_global_settings((p3_global_settings *)gs) ;

       	OUTPUT:

void
pl_empty_gs_product_size_range(gs)
	UV gs ;
     

	CODE:
	
	p3_empty_gs_product_size_range((p3_global_settings *) gs);

       	OUTPUT:

UV 
pl_create_pr_append_str()

	CODE:
	
	pr_append_str *str;
	
	str = create_pr_append_str() ;

	RETVAL = (UV) str ;
       	OUTPUT:
	RETVAL

void
pl_set_empty(str)
	UV str ;

	CODE:
	
	pr_set_empty((pr_append_str *) str) ; 

       	OUTPUT:


UV 
pl_choose_primers(gs, sa)
	UV gs ;
	UV sa ;

	CODE:
	
	p3retval * pr ;

	pr = choose_primers((p3_global_settings *) gs, (seq_args *)sa) ;

	RETVAL = (UV) pr ;
       	OUTPUT:
	RETVAL

char * 
pl_oligo_sequence(sa, pr)
        UV sa ;
	UV pr ;

	CODE:
	

	char * c;

	c = pr_oligo_sequence((seq_args *) sa, (const primer_rec *) pr) ;

	RETVAL = c ;
       	OUTPUT:
	RETVAL

char * 
pl_oligo_rev_c_sequence(sa, pr)
        UV sa ;
	UV pr ;

	CODE:	

	char * c;

	c = pr_oligo_rev_c_sequence((seq_args *) sa, (const primer_rec *) pr) ;

	RETVAL = c ;
       	OUTPUT:
	RETVAL


UV
pl_create_primer_rec()

	CODE:

	primer_rec * p;

	p = malloc(sizeof(primer_rec)) ;
	if (p == NULL) RETVAL = 0 ;

# fix	p3_create_primer_rec(p) ; 

	RETVAL = (UV) p;
       	OUTPUT:
	RETVAL

void 
pl_destroy_primer_rec(pr)
	UV  pr ;

	CODE:
	
# fix	destroy_primer_rec(pr) ;

       	OUTPUT:

int
pl_set_sa_sequence(sargs, sequence)
	UV sargs;
	const char *sequence ;


	CODE:

	RETVAL = p3_set_sa_sequence((seq_args *)sargs, sequence) ; 
       	OUTPUT:
	RETVAL


void
pl_set_sa_empty_quality(sargs)
	UV sargs;

	CODE:

	p3_set_sa_empty_quality((seq_args *)sargs) ;

       	OUTPUT:

void
pl_sa_add_to_quality_array(sargs, n)
	UV sargs;
	int n ;


	CODE:

	p3_sa_add_to_quality_array((seq_args *)sargs, n) ;

       	OUTPUT:

	
int
pl_set_sa_sequence_name(sargs, s)
	UV sargs ; 
	const char* s;

	CODE:

	RETVAL = p3_set_sa_sequence_name((seq_args *)sargs, s) ;
       	OUTPUT:
	RETVAL



int 
pl_set_sa_left_input(sargs, s)
	UV sargs ; 
	const char* s;


	CODE:

	RETVAL = p3_set_sa_left_input((seq_args *)sargs, s) ;
       	OUTPUT:
	RETVAL



int 
pl_set_sa_right_input(sargs, s)
	UV sargs ; 
	const char* s;

	CODE:

	RETVAL = p3_set_sa_right_input((seq_args *)sargs, s) ;
       	OUTPUT:
	RETVAL


int 
pl_set_sa_internal_input(sargs, s)
	UV sargs ; 
	const char* s;


	CODE:

	RETVAL = p3_set_sa_internal_input((seq_args *)sargs, s) ;
       	OUTPUT:
	RETVAL


int 
pl_add_to_sa_tar2(sa, i, j);
		UV sa ;
		int i;
		int j ;
	
	CODE:
	RETVAL = p3_add_to_sa_tar2((seq_args *) sa, i, j);
	OUTPUT:
	RETVAL

int
pl_add_to_sa_excl2(sa, i, j);
		UV sa ;
		int i;
		int j ;
	
	CODE:
	RETVAL = p3_add_to_sa_excl2((seq_args *) sa, i, j);
	OUTPUT:
	RETVAL

int
pl_add_to_sa_excl_internal2(sa, i, j);
		UV sa ;
		int i;
		int j ;
	
	CODE:
	RETVAL = p3_add_to_sa_excl_internal2((seq_args *) sa, i, j);
	OUTPUT:
	RETVAL


void
pl_set_sa_incl_s(sargs, incl_s)
	UV sargs;
	int incl_s;

	CODE:

	p3_set_sa_incl_s((seq_args *)sargs, incl_s) ;

       	OUTPUT:

void
pl_set_sa_incl_l(sargs, incl_l) ;
	UV sargs;
	int incl_l ;

	CODE:

	p3_set_sa_incl_l((seq_args *) sargs, incl_l) ;

       	OUTPUT:

void
pl_set_sa_start_codon_pos (sargs, start_codon_pos)
	UV sargs ;
	int start_codon_pos ;


	CODE:

	p3_set_sa_start_codon_pos((seq_args *)sargs, start_codon_pos) ;

       	OUTPUT:

int  
pl_add_to_gs_product_size_range(gs , min, max);
	UV gs ;
	int min ;
	int max ;

	CODE:
	RETVAL = p3_add_to_gs_product_size_range((p3_global_settings *) gs, min, max);
	OUTPUT:
	RETVAL


const char * 
pl_get_rv_and_gs_warnings(rv, gs)
	UV rv ;
	UV gs ;

	CODE:
	RETVAL = p3_get_rv_and_gs_warnings((p3retval *) rv, (p3_global_settings *) gs) ;
	OUTPUT:
	RETVAL

const char *
pl_get_rv_global_errors(rv)
	UV rv ;

	CODE:
	RETVAL = p3_get_rv_global_errors((p3retval *) rv) ;
	OUTPUT:
	RETVAL


const char *
pl_get_rv_per_sequence_errors(rv)
	UV rv ;

	CODE:
	RETVAL = p3_get_rv_per_sequence_errors((p3retval *) rv) ;
	OUTPUT:
	RETVAL


int
pl_get_rv_output_type(rv)
	UV rv ;

	CODE:
	RETVAL = p3_get_rv_output_type((p3retval *) rv) ;
	OUTPUT:
	RETVAL


const char *
pl_get_rv_warnings(rv)
	UV rv ;

	CODE:
	RETVAL = p3_get_rv_warnings((p3retval *) rv) ;
	OUTPUT:
	RETVAL


int
pl_get_rvstop_codon_pos(rv)
	UV rv ;

	CODE:
	RETVAL = p3_get_rv_stop_codon_pos((p3retval *) rv) ;
	OUTPUT:
	RETVAL


void 
pl_set_gs_primer_opt_size(p , val)
	UV p ;
	int val ;

	CODE:

	p3_set_gs_primer_opt_size((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_min_size(p , val)
	UV p ;
	int val ;

	CODE:

	p3_set_gs_primer_min_size((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_max_size(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_max_size((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_max_poly_x(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_max_poly_x((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_opt_tm(p , product_opt_tm)
	UV p ;
	double product_opt_tm ;


	CODE:

	p3_set_gs_primer_opt_tm((p3_global_settings *) p, product_opt_tm) ;

       	OUTPUT:

void 
pl_set_gs_primer_opt_gc_percent(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_opt_gc_percent((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_min_tm(p , product_min_tm)
	UV p ;
	double product_min_tm ;


	CODE:

	p3_set_gs_primer_min_tm((p3_global_settings *) p, product_min_tm) ;

       	OUTPUT:

void 
pl_set_gs_primer_max_tm(p , product_max_tm)
	UV p ;
	double product_max_tm ;


	CODE:

	p3_set_gs_primer_max_tm((p3_global_settings *) p, product_max_tm) ;

       	OUTPUT:

void 
pl_set_gs_primer_max_diff_tm(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_max_diff_tm((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_tm_santalucia(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_tm_santalucia((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_salt_corrections(p , salt_corrections)
	UV p ;
	int salt_corrections ;


	CODE:

	p3_set_gs_primer_salt_corrections((p3_global_settings *) p, salt_corrections);

       	OUTPUT:

void 
pl_set_gs_primer_min_gc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_min_gc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_max_gc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_max_gc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_salt_conc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_salt_conc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_divalent_conc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_divalent_conc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_dntp_conc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_dntp_conc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_dna_conc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_dna_conc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_num_ns_accepted(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_num_ns_accepted((p3_global_settings *) p, val);

       	OUTPUT:

void 
pl_set_gs_primer_product_opt_size(p , val) ;
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_product_opt_size((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_self_any(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_self_any((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_self_end(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_self_end((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_file_flag(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_file_flag((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pick_anyway(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_pick_anyway((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_gc_clamp(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_gc_clamp((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_liberal_base(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_liberal_base((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_first_base_index(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_first_base_index((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_num_return(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_num_return((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_min_quality(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_min_quality((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_min_end_quality(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_min_end_quality((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_quality_range_min(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_quality_range_min((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_quality_range_max(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_quality_range_max((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_product_max_tm(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_product_max_tm((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_product_min_tm(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_product_min_tm((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_product_opt_tm(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_product_opt_tm((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_task(p , primer_task)
	UV p ;
	char *  primer_task ;


	CODE:

	p3_set_gs_primer_task((p3_global_settings *) p, primer_task);

       	OUTPUT:

void 
pl_set_gs_primer_pick_left_primer(p , pick_left_primer)
	UV p ;
	int pick_left_primer ;


	CODE:

	p3_set_gs_primer_pick_left_primer((p3_global_settings *) p, pick_left_primer);

       	OUTPUT:

void 
pl_set_gs_primer_pick_right_primer(p , pick_right_primer)
	UV p ;
	int pick_right_primer ;


	CODE:

	p3_set_gs_primer_pick_right_primer((p3_global_settings *) p, pick_right_primer) ;

       	OUTPUT:

void 
pl_set_gs_primer_pick_internal_oligo(p , pick_internal_oligo)
	UV p ;
	int pick_internal_oligo ;


	CODE:

	p3_set_gs_primer_pick_internal_oligo((p3_global_settings *) p, pick_internal_oligo) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_opt_size(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_internal_oligo_opt_size((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_max_size(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_internal_oligo_max_size((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_min_size(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_internal_oligo_min_size((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_max_poly_x(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_internal_oligo_max_poly_x((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_opt_tm(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_opt_tm((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_opt_gc_percent(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_internal_oligo_opt_gc_percent((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_max_tm(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_max_tm((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_min_tm(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_min_tm((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_min_gc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_min_gc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_max_gc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_max_gc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_salt_conc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_salt_conc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_divalent_conc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_divalent_conc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_dntp_conc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_dntp_conc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_dna_conc(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_dna_conc((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_num_ns(p , val)
	UV  p ;
	int val ;

	CODE:

	p3_set_gs_primer_internal_oligo_num_ns((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_min_quality(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_internal_oligo_min_quality((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_self_any(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_self_any((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_self_end(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_self_end((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_max_mispriming(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_max_mispriming((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_max_template_mispriming(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_max_template_mispriming((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_max_mishyb(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_max_mishyb((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_max_mispriming(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_max_mispriming((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_max_template_mishyb(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_internal_oligo_max_template_mishyb((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_lib_ambiguity_codes_consensus(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_lib_ambiguity_codes_consensus((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_inside_penalty(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_inside_penalty((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_outside_penalty(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_outside_penalty((p3_global_settings *) p, val) ;

       	OUTPUT:


void 
pl_set_gs_primer_mispriming_library(p , val)
	UV p ;
	char * val ;


	CODE:

	p3_set_gs_primer_mispriming_library((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_internal_oligo_mishyb_library(p , val)
	UV p ;
	char * val ;


	CODE:

	p3_set_gs_primer_internal_oligo_mishyb_library((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_max_end_stability(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_max_end_stability((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_lowercase_masking(p , val)
	UV p ;
	int val ;


	CODE:

	p3_set_gs_primer_lowercase_masking((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_tm_gt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_tm_gt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_tm_lt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_tm_lt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_gc_percent_gt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_gc_percent_gt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_gc_percent_lt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_gc_percent_lt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_size_lt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_size_lt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_size_gt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_size_gt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_compl_any(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_compl_any((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_compl_end(p , val)
	UV p ;
	double val ;

	CODE:

	p3_set_gs_primer_wt_compl_end((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_num_ns(p , val)
	UV p ;
	int val ;

	CODE:

	p3_set_gs_primer_wt_num_ns((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_rep_sim(p , val)
	UV p ;
	double val ;

	CODE:

	p3_set_gs_primer_wt_rep_sim((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_seq_qual(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_seq_qual((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_end_qual(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_end_qual((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_pos_penalty(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_pos_penalty((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_end_stability(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_end_stability((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_wt_template_mispriming(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_wt_template_mispriming((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_tm_gt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_tm_gt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_tm_lt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_tm_lt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_gc_percent_gt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_gc_percent_gt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_gc_percent_lt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_gc_percent_lt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_size_lt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_size_lt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_size_gt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_size_gt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_compl_any(p , val)	
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_wt_compl_any((p3_global_settings *) p, val) ;	

       	OUTPUT:


void 
pl_set_gs_primer_io_wt_compl_end(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_compl_end((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_num_ns(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_num_ns((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_rep_sim(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_rep_sim((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_seq_qual(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_seq_qual((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_end_qual(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_end_qual((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_io_wt_template_mishyb(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_io_wt_template_mishyb((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_pr_penalty(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_wt_pr_penalty((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_io_penalty(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_wt_io_penalty((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_diff_tm(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_wt_diff_tm((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_compl_any(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_wt_compl_any((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_compl_end(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_wt_compl_end((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_product_tm_lt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_wt_product_tm_lt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_product_tm_gt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_wt_product_tm_gt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_product_size_gt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_wt_product_size_gt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_product_size_lt(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_wt_product_size_lt((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_rep_sim(p , val)
	UV p ;
	double val ;


	CODE:

	p3_set_gs_primer_pair_wt_rep_sim((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_primer_pair_wt_template_mispriming(p , val)
	UV p ;
	double val ;

	CODE:

	p3_set_gs_primer_pair_wt_template_mispriming((p3_global_settings *) p, val) ;

       	OUTPUT:

void 
pl_set_gs_prmin(p , val, i)
	UV p ;
	int val ;
	int i ;

	CODE:

	p3_set_gs_prmin((p3_global_settings *) p, val, i) ;

       	OUTPUT:

void 
pl_set_gs_prmax(p , val, i)
	UV p ;
	int val ;
	int i ;

	CODE:

	p3_set_gs_prmax((p3_global_settings *) p, val, i) ;

       	OUTPUT:

void 
p3_print_boulder(gs, sa, retval, explain_flag, show_oligo_problems)
	UV gs ;
	UV sa ;
	UV retval ;
	int explain_flag ;
	int show_oligo_problems ;
	
	CODE:

	int  jj ;
	jj = 0 ;
	print_boulder(&jj, (p3_global_settings *) gs, (seq_args *) sa, (p3retval *) retval, explain_flag, show_oligo_problems) ;

	OUTPUT:

	