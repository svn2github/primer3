#!/usr/bin/perl -w


use strict;

# Copy here the content of tags_list.txt
my @docTags = ("SEQUENCE_ID",
"SEQUENCE_TEMPLATE",
"SEQUENCE_INCLUDED_REGION",
"SEQUENCE_TARGET",
"SEQUENCE_EXCLUDED_REGION",
"SEQUENCE_PRIMER_PAIR_OK_REGION_LIST",
"SEQUENCE_OVERLAP_JUNCTION_LIST",
"SEQUENCE_INTERNAL_EXCLUDED_REGION",
"SEQUENCE_PRIMER",
"SEQUENCE_INTERNAL_OLIGO",
"SEQUENCE_PRIMER_REVCOMP",
"SEQUENCE_START_CODON_POSITION",
"SEQUENCE_QUALITY",
"SEQUENCE_FORCE_LEFT_START",
"SEQUENCE_FORCE_LEFT_END",
"SEQUENCE_FORCE_RIGHT_START",
"SEQUENCE_FORCE_RIGHT_END",
"PRIMER_TASK",
"PRIMER_PICK_LEFT_PRIMER",
"PRIMER_PICK_INTERNAL_OLIGO",
"PRIMER_PICK_RIGHT_PRIMER",
"PRIMER_NUM_RETURN",
"PRIMER_MIN_3_PRIME_OVERLAP_OF_JUNCTION",
"PRIMER_MIN_5_PRIME_OVERLAP_OF_JUNCTION",
"PRIMER_PRODUCT_SIZE_RANGE",
"PRIMER_PRODUCT_OPT_SIZE",
"PRIMER_PAIR_WT_PRODUCT_SIZE_LT",
"PRIMER_PAIR_WT_PRODUCT_SIZE_GT",
"PRIMER_MIN_SIZE",
"PRIMER_INTERNAL_MIN_SIZE",
"PRIMER_OPT_SIZE",
"PRIMER_INTERNAL_OPT_SIZE",
"PRIMER_MAX_SIZE",
"PRIMER_INTERNAL_MAX_SIZE",
"PRIMER_WT_SIZE_LT",
"PRIMER_INTERNAL_WT_SIZE_LT",
"PRIMER_WT_SIZE_GT",
"PRIMER_INTERNAL_WT_SIZE_GT",
"PRIMER_MIN_GC",
"PRIMER_INTERNAL_MIN_GC",
"PRIMER_OPT_GC_PERCENT",
"PRIMER_INTERNAL_OPT_GC_PERCENT",
"PRIMER_MAX_GC",
"PRIMER_INTERNAL_MAX_GC",
"PRIMER_WT_GC_PERCENT_LT",
"PRIMER_INTERNAL_WT_GC_PERCENT_LT",
"PRIMER_WT_GC_PERCENT_GT",
"PRIMER_INTERNAL_WT_GC_PERCENT_GT",
"PRIMER_GC_CLAMP",
"PRIMER_MAX_END_GC",
"PRIMER_MIN_TM",
"PRIMER_INTERNAL_MIN_TM",
"PRIMER_OPT_TM",
"PRIMER_INTERNAL_OPT_TM",
"PRIMER_MAX_TM",
"PRIMER_INTERNAL_MAX_TM",
"PRIMER_PAIR_MAX_DIFF_TM",
"PRIMER_WT_TM_LT",
"PRIMER_INTERNAL_WT_TM_LT",
"PRIMER_WT_TM_GT",
"PRIMER_INTERNAL_WT_TM_GT",
"PRIMER_PAIR_WT_DIFF_TM",
"PRIMER_PRODUCT_MIN_TM",
"PRIMER_PRODUCT_OPT_TM",
"PRIMER_PRODUCT_MAX_TM",
"PRIMER_PAIR_WT_PRODUCT_TM_LT",
"PRIMER_PAIR_WT_PRODUCT_TM_GT",
"PRIMER_TM_FORMULA",
"PRIMER_SALT_MONOVALENT",
"PRIMER_INTERNAL_SALT_MONOVALENT",
"PRIMER_SALT_DIVALENT",
"PRIMER_INTERNAL_SALT_DIVALENT",
"PRIMER_DNTP_CONC",
"PRIMER_INTERNAL_DNTP_CONC",
"PRIMER_SALT_CORRECTIONS",
"PRIMER_DNA_CONC",
"PRIMER_INTERNAL_DNA_CONC",
"PRIMER_THERMODYNAMIC_ALIGNMENT",
"PRIMER_THERMODYNAMIC_PARAMETERS_PATH",
"PRIMER_MAX_SELF_ANY",
"PRIMER_MAX_SELF_ANY_TH",
"PRIMER_INTERNAL_MAX_SELF_ANY",
"PRIMER_INTERNAL_MAX_SELF_ANY_TH",
"PRIMER_PAIR_MAX_COMPL_ANY",
"PRIMER_PAIR_MAX_COMPL_ANY_TH",
"PRIMER_WT_SELF_ANY",
"PRIMER_WT_SELF_ANY_TH",
"PRIMER_INTERNAL_WT_SELF_ANY",
"PRIMER_INTERNAL_WT_SELF_ANY_TH",
"PRIMER_PAIR_WT_COMPL_ANY",
"PRIMER_PAIR_WT_COMPL_ANY_TH",
"PRIMER_MAX_SELF_END",
"PRIMER_MAX_SELF_END_TH",
"PRIMER_INTERNAL_MAX_SELF_END",
"PRIMER_INTERNAL_MAX_SELF_END_TH",
"PRIMER_PAIR_MAX_COMPL_END",
"PRIMER_PAIR_MAX_COMPL_END_TH",
"PRIMER_WT_SELF_END",
"PRIMER_WT_SELF_END_TH",
"PRIMER_INTERNAL_WT_SELF_END",
"PRIMER_INTERNAL_WT_SELF_END_TH",
"PRIMER_PAIR_WT_COMPL_END",
"PRIMER_PAIR_WT_COMPL_END_TH",
"PRIMER_MAX_HAIRPIN_TH",
"PRIMER_PAIR_MAX_HAIRPIN_TH",
"PRIMER_INTERNAL_MAX_HAIRPIN_TH",
"PRIMER_WT_HAIRPIN_TH",
"PRIMER_INTERNAL_WT_HAIRPIN_TH",
"PRIMER_MAX_END_STABILITY",
"PRIMER_WT_END_STABILITY",
"PRIMER_MAX_NS_ACCEPTED",
"PRIMER_INTERNAL_MAX_NS_ACCEPTED",
"PRIMER_WT_NUM_NS",
"PRIMER_INTERNAL_WT_NUM_NS",
"PRIMER_MAX_POLY_X",
"PRIMER_INTERNAL_MAX_POLY_X",
"PRIMER_MIN_LEFT_THREE_PRIME_DISTANCE",
"PRIMER_MIN_RIGHT_THREE_PRIME_DISTANCE",
"PRIMER_MIN_THREE_PRIME_DISTANCE",
"PRIMER_PICK_ANYWAY",
"PRIMER_LOWERCASE_MASKING",
"PRIMER_EXPLAIN_FLAG",
"PRIMER_LIBERAL_BASE",
"PRIMER_FIRST_BASE_INDEX",
"PRIMER_MAX_TEMPLATE_MISPRIMING",
"PRIMER_MAX_TEMPLATE_MISPRIMING_TH",
"PRIMER_PAIR_MAX_TEMPLATE_MISPRIMING",
"PRIMER_PAIR_MAX_TEMPLATE_MISPRIMING_TH",
"PRIMER_WT_TEMPLATE_MISPRIMING",
"PRIMER_WT_TEMPLATE_MISPRIMING_TH",
"PRIMER_PAIR_WT_TEMPLATE_MISPRIMING",
"PRIMER_PAIR_WT_TEMPLATE_MISPRIMING_TH",
"PRIMER_MISPRIMING_LIBRARY",
"PRIMER_INTERNAL_MISHYB_LIBRARY",
"PRIMER_LIB_AMBIGUITY_CODES_CONSENSUS",
"PRIMER_MAX_LIBRARY_MISPRIMING",
"PRIMER_INTERNAL_MAX_LIBRARY_MISHYB",
"PRIMER_PAIR_MAX_LIBRARY_MISPRIMING",
"PRIMER_WT_LIBRARY_MISPRIMING",
"PRIMER_INTERNAL_WT_LIBRARY_MISHYB",
"PRIMER_PAIR_WT_LIBRARY_MISPRIMING",
"PRIMER_MIN_QUALITY",
"PRIMER_INTERNAL_MIN_QUALITY",
"PRIMER_MIN_END_QUALITY",
"PRIMER_QUALITY_RANGE_MIN",
"PRIMER_QUALITY_RANGE_MAX",
"PRIMER_WT_SEQ_QUAL",
"PRIMER_INTERNAL_WT_SEQ_QUAL",
"PRIMER_PAIR_WT_PR_PENALTY",
"PRIMER_PAIR_WT_IO_PENALTY",
"PRIMER_INSIDE_PENALTY",
"PRIMER_OUTSIDE_PENALTY",
"PRIMER_WT_POS_PENALTY",
"PRIMER_SEQUENCING_LEAD",
"PRIMER_SEQUENCING_SPACING",
"PRIMER_SEQUENCING_INTERVAL",
"PRIMER_SEQUENCING_ACCURACY",
"PRIMER_WT_END_QUAL",
"PRIMER_INTERNAL_WT_END_QUAL",
"P3_FILE_ID",
"P3_FILE_FLAG",
"P3_COMMENT",
);




# Copy here the else loop of read_boulder.c
my $c_string = qq{

      /* Get the tag and the value pointers */
      tag_len = n - s;
      datum = n + 1;
      datum_len = line_len - tag_len - 1;
            
      /* Process "Sequence" (i.e. Per-Record) Arguments". */
      parse_err = non_fatal_err;
              
      /* COMPARE_AND_MALLOC("SEQUENCE", sa->sequence); */
      if (COMPARE("SEQUENCE_TEMPLATE")) {   /* NEW WAY */
        if (/* p3_get_seq_arg_sequence(sa) */ sa->sequence) {
          pr_append_new_chunk(parse_err, "Duplicate tag: ");
          pr_append(parse_err, "SEQUENCE_TEMPLATE"); 
        } else {
          if (p3_set_sa_sequence(sa, datum)) exit(-2);
        }
        continue;
      }
      if (COMPARE("SEQUENCE_QUALITY")) {
        if ((sa->n_quality = parse_seq_quality(datum, sa)) == 0) {
          pr_append_new_chunk(parse_err,
                              "Error in sequence quality data");
        }
        continue;
      }
      COMPARE_AND_MALLOC("SEQUENCE_ID", sa->sequence_name);
      COMPARE_AND_MALLOC("SEQUENCE_PRIMER", sa->left_input);
      COMPARE_AND_MALLOC("SEQUENCE_PRIMER_REVCOMP", sa->right_input);
      COMPARE_AND_MALLOC("SEQUENCE_INTERNAL_OLIGO", sa->internal_input);
      COMPARE_2_INTERVAL_LIST("SEQUENCE_PRIMER_PAIR_OK_REGION_LIST", &sa->ok_regions);
      COMPARE_INTERVAL_LIST("SEQUENCE_TARGET", &sa->tar2);
      COMPARE_INTERVAL_LIST("SEQUENCE_EXCLUDED_REGION", &sa->excl2);
      COMPARE_INTERVAL_LIST("SEQUENCE_INTERNAL_EXCLUDED_REGION",
                              &sa->excl_internal2);
      if (COMPARE("SEQUENCE_OVERLAP_JUNCTION_LIST")) {
	if (parse_intron_list(datum, sa->primer_overlap_junctions, 
			      &sa->primer_overlap_junctions_count) == 0) {
          pr_append_new_chunk(parse_err,
			      "Error in SEQUENCE_PRIMER_OVERLAP_JUNCTION_LIST");
        }
        continue;
      }
      if (COMPARE("SEQUENCE_INCLUDED_REGION")) {
        p = parse_int_pair("SEQUENCE_INCLUDED_REGION", datum, ',',
                           &sa->incl_s, &sa->incl_l, parse_err);
        if (NULL == p) /* An error; the message is already
                        * in parse_err.  */
          continue;
        while (' ' == *p || '\t' == *p) p++;
        if (*p != '\n' && *p != '\0')
            tag_syntax_error("SEQUENCE_INCLUDED_REGION", datum,
                             parse_err);
          continue;
      }
      COMPARE_INT("SEQUENCE_START_CODON_POSITION", sa->start_codon_pos);
      COMPARE_INT("SEQUENCE_FORCE_LEFT_START", sa->force_left_start);
      COMPARE_INT("SEQUENCE_FORCE_LEFT_END", sa->force_left_end);
      COMPARE_INT("SEQUENCE_FORCE_RIGHT_START", sa->force_right_start);
      COMPARE_INT("SEQUENCE_FORCE_RIGHT_END", sa->force_right_end);
      /* Process "Global" Arguments (those that persist between boulder
       * records). */
      parse_err = glob_err;  /* These errors are considered fatal. */
      if (COMPARE("PRIMER_PRODUCT_SIZE_RANGE")) {
        parse_product_size("PRIMER_PRODUCT_SIZE_RANGE", datum, pa,
                           parse_err);
        continue;
      }
      COMPARE_INT("PRIMER_OPT_SIZE", pa->p_args.opt_size);
      COMPARE_INT("PRIMER_MIN_SIZE", pa->p_args.min_size);
      COMPARE_INT("PRIMER_MAX_SIZE", pa->p_args.max_size);
      COMPARE_INT("PRIMER_MAX_POLY_X", pa->p_args.max_poly_x);
      COMPARE_FLOAT("PRIMER_OPT_TM", pa->p_args.opt_tm);
      COMPARE_FLOAT("PRIMER_OPT_GC_PERCENT", pa->p_args.opt_gc_content);
      COMPARE_FLOAT("PRIMER_MIN_TM", pa->p_args.min_tm);
      COMPARE_FLOAT("PRIMER_MAX_TM", pa->p_args.max_tm);
      COMPARE_FLOAT("PRIMER_PAIR_MAX_DIFF_TM", pa->max_diff_tm);
      if (COMPARE("PRIMER_TM_FORMULA")) {
          parse_int("PRIMER_TM_FORMULA", datum, &tmp_int, parse_err);
          pa->tm_santalucia = (tm_method_type) tmp_int;    /* added by T.Koressaar */
          continue;
      }
      if (COMPARE("PRIMER_SALT_CORRECTIONS")) {
        parse_int("PRIMER_SALT_CORRECTIONS", datum, &tmp_int, parse_err);
        pa->salt_corrections = (salt_correction_type) tmp_int; /* added by T.Koressaar */
        continue;
      }
      COMPARE_FLOAT("PRIMER_MIN_GC", pa->p_args.min_gc);
      COMPARE_FLOAT("PRIMER_MAX_GC", pa->p_args.max_gc);
      COMPARE_FLOAT("PRIMER_SALT_MONOVALENT", pa->p_args.salt_conc);
      COMPARE_FLOAT("PRIMER_SALT_DIVALENT", pa->p_args.divalent_conc);
      COMPARE_FLOAT("PRIMER_DNTP_CONC", pa->p_args.dntp_conc);
      COMPARE_FLOAT("PRIMER_DNA_CONC", pa->p_args.dna_conc);
      COMPARE_INT("PRIMER_MAX_NS_ACCEPTED", pa->p_args.num_ns_accepted);
      COMPARE_INT("PRIMER_PRODUCT_OPT_SIZE", pa->product_opt_size);
      COMPARE_FLOAT("PRIMER_MAX_SELF_ANY", pa->p_args.max_self_any);
      COMPARE_FLOAT("PRIMER_MAX_SELF_END", pa->p_args.max_self_end);
      COMPARE_FLOAT("PRIMER_MAX_SELF_ANY_TH", pa->p_args.max_self_any_th);
      COMPARE_FLOAT("PRIMER_MAX_SELF_END_TH", pa->p_args.max_self_end_th);
      COMPARE_FLOAT("PRIMER_MAX_HAIRPIN_TH", pa->p_args.max_hairpin_th);   
      COMPARE_FLOAT("PRIMER_PAIR_MAX_COMPL_ANY", pa->pair_compl_any);
      COMPARE_FLOAT("PRIMER_PAIR_MAX_COMPL_END", pa->pair_compl_end);
      COMPARE_FLOAT("PRIMER_PAIR_MAX_COMPL_ANY_TH", pa->pair_compl_any_th);
      COMPARE_FLOAT("PRIMER_PAIR_MAX_COMPL_END_TH", pa->pair_compl_end_th);
      COMPARE_FLOAT("PRIMER_PAIR_MAX_HAIRPIN_TH", pa->pair_hairpin_th);
      COMPARE_INT("P3_FILE_FLAG", res->file_flag);
      COMPARE_INT("PRIMER_PICK_ANYWAY", pa->pick_anyway);
      COMPARE_INT("PRIMER_GC_CLAMP", pa->gc_clamp);
      COMPARE_INT("PRIMER_MAX_END_GC", pa->max_end_gc);
      COMPARE_INT("PRIMER_EXPLAIN_FLAG", res->explain_flag);
      COMPARE_INT("PRIMER_LIBERAL_BASE", pa->liberal_base);
      COMPARE_INT("PRIMER_FIRST_BASE_INDEX", pa->first_base_index);
      COMPARE_INT("PRIMER_NUM_RETURN", pa->num_return);
      COMPARE_INT("PRIMER_MIN_QUALITY", pa->p_args.min_quality);
      COMPARE_INT("PRIMER_MIN_END_QUALITY", pa->p_args.min_end_quality);
      if (COMPARE("PRIMER_MIN_THREE_PRIME_DISTANCE")) {
	parse_int("PRIMER_MIN_THREE_PRIME_DISTANCE", datum, &(min_three_prime_distance), parse_err);
	/* check if specific tag also specified - error in this case */
	if (min_3_prime_distance_specific == 1) {
	  pr_append_new_chunk(glob_err,
                              "Both PRIMER_MIN_THREE_PRIME_DISTANCE and PRIMER_{LEFT/RIGHT}_MIN_THREE_PRIME_DISTANCE specified");
	} else {
	  min_3_prime_distance_global = 1;
	  /* set up individual flags */
	  pa->min_left_three_prime_distance = min_three_prime_distance;
	  pa->min_right_three_prime_distance = min_three_prime_distance;
	}
	continue;
      }
      if (COMPARE("PRIMER_MIN_LEFT_THREE_PRIME_DISTANCE")) {
	parse_int("PRIMER_MIN_LEFT_THREE_PRIME_DISTANCE", datum, &(pa->min_left_three_prime_distance), parse_err);
	/* check if global tag also specified - error in this case */
	if (min_3_prime_distance_global == 1) {
	  pr_append_new_chunk(glob_err,
                              "Both PRIMER_MIN_THREE_PRIME_DISTANCE and PRIMER_{LEFT/RIGHT}_MIN_THREE_PRIME_DISTANCE specified");
	} else {
	  min_3_prime_distance_specific = 1;
	}
	continue;
      }
      if (COMPARE("PRIMER_MIN_RIGHT_THREE_PRIME_DISTANCE")) {
	parse_int("PRIMER_MIN_RIGHT_THREE_PRIME_DISTANCE", datum, &(pa->min_right_three_prime_distance), parse_err);
	/* check if global tag also specified - error in this case */
	if (min_3_prime_distance_global == 1) {
	  pr_append_new_chunk(glob_err,
                              "Both PRIMER_MIN_THREE_PRIME_DISTANCE and PRIMER_{LEFT/RIGHT}_MIN_THREE_PRIME_DISTANCE specified");
	} else {
	  min_3_prime_distance_specific = 1;
	}
	continue;
      }
      if (file_type == settings) {
        if (COMPARE("P3_FILE_ID")) continue;
      }
      COMPARE_INT("PRIMER_QUALITY_RANGE_MIN", pa->quality_range_min);
      COMPARE_INT("PRIMER_QUALITY_RANGE_MAX", pa->quality_range_max);
      COMPARE_FLOAT("PRIMER_PRODUCT_MAX_TM", pa->product_max_tm);
      COMPARE_FLOAT("PRIMER_PRODUCT_MIN_TM", pa->product_min_tm);
      COMPARE_FLOAT("PRIMER_PRODUCT_OPT_TM", pa->product_opt_tm);
      COMPARE_INT("PRIMER_SEQUENCING_LEAD", pa->sequencing.lead);
      COMPARE_INT("PRIMER_SEQUENCING_SPACING", pa->sequencing.spacing);
      COMPARE_INT("PRIMER_SEQUENCING_INTERVAL", pa->sequencing.interval);
      COMPARE_INT("PRIMER_SEQUENCING_ACCURACY", pa->sequencing.accuracy);
      if (COMPARE("PRIMER_MIN_5_PRIME_OVERLAP_OF_JUNCTION")) {
	parse_int("PRIMER_MIN_5_PRIME_OVERLAP_OF_JUNCTION", datum, &pa->min_5_prime_overlap_of_junction, parse_err);
	/* min_5_prime = 1; Removed 10/20/2010 */
	continue;
      }
      if (COMPARE("PRIMER_MIN_3_PRIME_OVERLAP_OF_JUNCTION")) {
	parse_int("PRIMER_MIN_3_PRIME_OVERLAP_OF_JUNCTION", datum, &pa->min_3_prime_overlap_of_junction, parse_err);
	/* min_3_prime = 1; Removed 10/20/2010 */
	continue;
      }
      COMPARE_AND_MALLOC("PRIMER_TASK", task_tmp);
      COMPARE_INT("PRIMER_PICK_RIGHT_PRIMER", pa->pick_right_primer);
      COMPARE_INT("PRIMER_PICK_INTERNAL_OLIGO", pa->pick_internal_oligo);
      COMPARE_INT("PRIMER_PICK_LEFT_PRIMER", pa->pick_left_primer);
      COMPARE_INT("PRIMER_INTERNAL_OPT_SIZE", pa->o_args.opt_size);
      COMPARE_INT("PRIMER_INTERNAL_MAX_SIZE", pa->o_args.max_size);
      COMPARE_INT("PRIMER_INTERNAL_MIN_SIZE", pa->o_args.min_size);
      COMPARE_INT("PRIMER_INTERNAL_MAX_POLY_X", pa->o_args.max_poly_x);
      COMPARE_FLOAT("PRIMER_INTERNAL_OPT_TM", pa->o_args.opt_tm);
      COMPARE_FLOAT("PRIMER_INTERNAL_OPT_GC_PERCENT",
                    pa->o_args.opt_gc_content);
      COMPARE_FLOAT("PRIMER_INTERNAL_MAX_TM", pa->o_args.max_tm);
      COMPARE_FLOAT("PRIMER_INTERNAL_MIN_TM", pa->o_args.min_tm);
      COMPARE_FLOAT("PRIMER_INTERNAL_MIN_GC", pa->o_args.min_gc);
      COMPARE_FLOAT("PRIMER_INTERNAL_MAX_GC", pa->o_args.max_gc);
      COMPARE_FLOAT("PRIMER_INTERNAL_SALT_MONOVALENT",
                        pa->o_args.salt_conc);
      COMPARE_FLOAT("PRIMER_INTERNAL_SALT_DIVALENT",
                    pa->o_args.divalent_conc);
      COMPARE_FLOAT("PRIMER_INTERNAL_DNTP_CONC",
                    pa->o_args.dntp_conc);
      COMPARE_FLOAT("PRIMER_INTERNAL_DNA_CONC", pa->o_args.dna_conc);
      COMPARE_INT("PRIMER_INTERNAL_MAX_NS_ACCEPTED", pa->o_args.num_ns_accepted);
      COMPARE_INT("PRIMER_INTERNAL_MIN_QUALITY", pa->o_args.min_quality);
      COMPARE_FLOAT("PRIMER_INTERNAL_MAX_SELF_ANY",
		    pa->o_args.max_self_any);
      COMPARE_FLOAT("PRIMER_INTERNAL_MAX_SELF_END", 
		    pa->o_args.max_self_end);
      COMPARE_FLOAT("PRIMER_INTERNAL_MAX_SELF_ANY_TH",
			   pa->o_args.max_self_any_th);
      COMPARE_FLOAT("PRIMER_INTERNAL_MAX_SELF_END_TH",
				 pa->o_args.max_self_end_th);
      COMPARE_FLOAT("PRIMER_INTERNAL_MAX_HAIRPIN_TH",
			       pa->o_args.max_hairpin_th);
      COMPARE_FLOAT("PRIMER_MAX_LIBRARY_MISPRIMING",
                    pa->p_args.max_repeat_compl);
      COMPARE_FLOAT("PRIMER_INTERNAL_MAX_LIBRARY_MISHYB",
                    pa->o_args.max_repeat_compl);
      COMPARE_FLOAT("PRIMER_PAIR_MAX_LIBRARY_MISPRIMING",
                    pa->pair_repeat_compl);
      /* Mispriming / mishybing in the template. */
      COMPARE_FLOAT("PRIMER_MAX_TEMPLATE_MISPRIMING",
                    pa->p_args.max_template_mispriming);
      COMPARE_FLOAT("PRIMER_MAX_TEMPLATE_MISPRIMING_TH",
			  pa->p_args.max_template_mispriming_th);
      COMPARE_FLOAT("PRIMER_PAIR_MAX_TEMPLATE_MISPRIMING",
                    pa->pair_max_template_mispriming);
      COMPARE_FLOAT("PRIMER_PAIR_MAX_TEMPLATE_MISPRIMING_TH",
		    pa->pair_max_template_mispriming_th);
       /* Control interpretation of ambiguity codes in mispriming
          and mishyb libraries. */
      COMPARE_INT("PRIMER_LIB_AMBIGUITY_CODES_CONSENSUS",
                  pa->lib_ambiguity_codes_consensus);
      COMPARE_FLOAT("PRIMER_INSIDE_PENALTY", pa->inside_penalty);
      COMPARE_FLOAT("PRIMER_OUTSIDE_PENALTY", pa->outside_penalty);
      if (COMPARE("PRIMER_MISPRIMING_LIBRARY")) {
        if (repeat_file_path != NULL) {
          pr_append_new_chunk(glob_err,
                              "Duplicate PRIMER_MISPRIMING_LIBRARY tag");
          free(repeat_file_path);
          repeat_file_path = NULL;
        } else {
          repeat_file_path = (char*) _rb_safe_malloc(strlen(datum) + 1);
          strcpy(repeat_file_path, datum);
        }
        continue;
      }
      if (COMPARE("PRIMER_INTERNAL_MISHYB_LIBRARY")) {
        if (int_repeat_file_path != NULL) {
          pr_append_new_chunk(glob_err,
                              "Duplicate PRIMER_INTERNAL_MISHYB_LIBRARY tag");
          free(int_repeat_file_path);
          int_repeat_file_path = NULL;
        } else {
          int_repeat_file_path = (char*) _rb_safe_malloc(strlen(datum) + 1);
          strcpy(int_repeat_file_path, datum);
        }
        continue;
      }
      if (COMPARE("P3_COMMENT")) continue;
      COMPARE_FLOAT("PRIMER_MAX_END_STABILITY", pa->max_end_stability);

      COMPARE_INT("PRIMER_LOWERCASE_MASKING",
                  pa->lowercase_masking); 
      /* added by T. Koressaar */
      COMPARE_INT("PRIMER_THERMODYNAMIC_ALIGNMENT", pa->thermodynamic_alignment);
      if (COMPARE("PRIMER_THERMODYNAMIC_PARAMETERS_PATH")) {
        if (thermodynamic_params_path == NULL) {
          thermodynamic_params_path = (char*) _rb_safe_malloc(datum_len + 1);
          strcpy(thermodynamic_params_path, datum);
          thermodynamic_path_changed = 1;
        }
        /* check if path changes */
	else if (strcmp(thermodynamic_params_path, datum)) {
	  free(thermodynamic_params_path);
	  thermodynamic_params_path = (char*) _rb_safe_malloc(datum_len + 1); 
	  strcpy(thermodynamic_params_path, datum);
	  thermodynamic_path_changed = 1;
        }
        continue;
      }
      /* weights for objective functions  */
      /* CHANGE TEMP/temp -> TM/tm */
      COMPARE_FLOAT("PRIMER_WT_TM_GT", pa->p_args.weights.temp_gt);
      COMPARE_FLOAT("PRIMER_WT_TM_LT", pa->p_args.weights.temp_lt);
      COMPARE_FLOAT("PRIMER_WT_GC_PERCENT_GT", pa->p_args.weights.gc_content_gt);
      COMPARE_FLOAT("PRIMER_WT_GC_PERCENT_LT", pa->p_args.weights.gc_content_lt);
      COMPARE_FLOAT("PRIMER_WT_SIZE_LT", pa->p_args.weights.length_lt);
      COMPARE_FLOAT("PRIMER_WT_SIZE_GT", pa->p_args.weights.length_gt);
      COMPARE_FLOAT("PRIMER_WT_SELF_ANY", pa->p_args.weights.compl_any);
      COMPARE_FLOAT("PRIMER_WT_SELF_END", pa->p_args.weights.compl_end);
      COMPARE_FLOAT("PRIMER_WT_SELF_ANY_TH", pa->p_args.weights.compl_any_th);
      COMPARE_FLOAT("PRIMER_WT_SELF_END_TH", pa->p_args.weights.compl_end_th);
      COMPARE_FLOAT("PRIMER_WT_HAIRPIN_TH", pa->p_args.weights.hairpin_th);
      COMPARE_FLOAT("PRIMER_WT_NUM_NS", pa->p_args.weights.num_ns);
      COMPARE_FLOAT("PRIMER_WT_LIBRARY_MISPRIMING", pa->p_args.weights.repeat_sim);
      COMPARE_FLOAT("PRIMER_WT_SEQ_QUAL", pa->p_args.weights.seq_quality);
      COMPARE_FLOAT("PRIMER_WT_END_QUAL", pa->p_args.weights.end_quality);
      COMPARE_FLOAT("PRIMER_WT_POS_PENALTY", pa->p_args.weights.pos_penalty);
      COMPARE_FLOAT("PRIMER_WT_END_STABILITY",
                    pa->p_args.weights.end_stability);
      COMPARE_FLOAT("PRIMER_WT_TEMPLATE_MISPRIMING",
                    pa->p_args.weights.template_mispriming);
      COMPARE_FLOAT("PRIMER_WT_TEMPLATE_MISPRIMING_TH",
		                        pa->p_args.weights.template_mispriming_th);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_TM_GT", pa->o_args.weights.temp_gt);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_TM_LT", pa->o_args.weights.temp_lt);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_GC_PERCENT_GT", pa->o_args.weights.gc_content_gt);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_GC_PERCENT_LT", pa->o_args.weights.gc_content_lt);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_SIZE_LT", pa->o_args.weights.length_lt);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_SIZE_GT", pa->o_args.weights.length_gt);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_SELF_ANY", pa->o_args.weights.compl_any);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_SELF_END", pa->o_args.weights.compl_end);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_SELF_ANY_TH", pa->o_args.weights.compl_any_th);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_SELF_END_TH", pa->o_args.weights.compl_end_th);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_HAIRPIN_TH", pa->o_args.weights.hairpin_th);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_NUM_NS", pa->o_args.weights.num_ns);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_LIBRARY_MISHYB", pa->o_args.weights.repeat_sim);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_SEQ_QUAL", pa->o_args.weights.seq_quality);
      COMPARE_FLOAT("PRIMER_INTERNAL_WT_END_QUAL", pa->o_args.weights.end_quality);
      COMPARE_FLOAT("PRIMER_WT_TEMPLATE_MISPRIMING_TH",
		    pa->o_args.weights.template_mispriming_th);
      COMPARE_FLOAT("PRIMER_PAIR_WT_PR_PENALTY", 
                    pa->pr_pair_weights.primer_quality);
      COMPARE_FLOAT("PRIMER_PAIR_WT_IO_PENALTY",
                    pa->pr_pair_weights.io_quality);
      COMPARE_FLOAT("PRIMER_PAIR_WT_DIFF_TM",
                    pa->pr_pair_weights.diff_tm);
      COMPARE_FLOAT("PRIMER_PAIR_WT_COMPL_ANY",
                    pa->pr_pair_weights.compl_any);
      COMPARE_FLOAT("PRIMER_PAIR_WT_COMPL_END",
                    pa->pr_pair_weights.compl_end);
      COMPARE_FLOAT("PRIMER_PAIR_WT_COMPL_ANY_TH",
		    pa->pr_pair_weights.compl_any_th);
      COMPARE_FLOAT("PRIMER_PAIR_WT_COMPL_END_TH",
		    pa->pr_pair_weights.compl_end_th);
      COMPARE_FLOAT("PRIMER_PAIR_WT_PRODUCT_TM_LT",
                    pa->pr_pair_weights.product_tm_lt);
      COMPARE_FLOAT("PRIMER_PAIR_WT_PRODUCT_TM_GT",
                    pa->pr_pair_weights.product_tm_gt);
      COMPARE_FLOAT("PRIMER_PAIR_WT_PRODUCT_SIZE_GT",
                    pa->pr_pair_weights.product_size_gt);
      COMPARE_FLOAT("PRIMER_PAIR_WT_PRODUCT_SIZE_LT",
                    pa->pr_pair_weights.product_size_lt);
      COMPARE_FLOAT("PRIMER_PAIR_WT_LIBRARY_MISPRIMING",
                    pa->pr_pair_weights.repeat_sim);
      COMPARE_FLOAT("PRIMER_PAIR_WT_TEMPLATE_MISPRIMING",
                    pa->pr_pair_weights.template_mispriming);
      COMPARE_FLOAT("PRIMER_PAIR_WT_TEMPLATE_MISPRIMING_TH",
		    pa->pr_pair_weights.template_mispriming_th);
        };



print"start processing\n";
# Remove the comments
$c_string =~ s/\/\*(.*?)\*\///g;
$c_string =~ s/(.*?)\"(.*?)\"(.*)/$2/g;

my @raw_c_tags = split '\n', $c_string;

my %c_tags;
my %h_doc_tags;
my %all_tags;

foreach my $tag_holder (@raw_c_tags) {
	if (($tag_holder=~ /^SEQUENCE_/) or ($tag_holder=~ /^P3_/) 
				or ($tag_holder=~ /^PRIMER_/)){
		$c_tags{$tag_holder} = "";
		$all_tags{$tag_holder} = "";
		#print $tag_holder."\n";
	}
}

foreach my $tag_holder (@docTags) {
	$h_doc_tags{$tag_holder} = "";
	$all_tags{$tag_holder} = "";
	#print $tag_holder."\n";
}

my $tag_count = 0;
my $seperate_count = 0;
my $any_diff = 0;

print "\nTags only in C-code:\n\n";
foreach my $tag_holder (%all_tags) {
	if (($tag_holder=~ /^SEQUENCE_/) or ($tag_holder=~ /^P3_/) 
				or ($tag_holder=~ /^PRIMER_/)){
		$tag_count++;
		#print $tag_holder."\n";
		if (!defined $h_doc_tags{$tag_holder}) {
			$seperate_count++;
			$any_diff = 1;
			print "Tag: ".$tag_holder."\n";
		}
		
	}
}
print "\nTags only in the Manual:\n\n";
foreach my $tag_holder (%all_tags) {
	if (($tag_holder=~ /^SEQUENCE_/) or ($tag_holder=~ /^P3_/) 
				or ($tag_holder=~ /^PRIMER_/)){
		#print $tag_holder."\n";
		if (!defined $c_tags{$tag_holder}) {
			$seperate_count++;
			$any_diff = 1;
			print "Tag: ".$tag_holder."\n";
		}
		
	}
}

#print "\nTags in Both:\n\n";
foreach my $tag_holder (%all_tags) {
	if (($tag_holder=~ /^SEQUENCE_/) or ($tag_holder=~ /^P3_/) 
				or ($tag_holder=~ /^PRIMER_/)){
		#print $tag_holder."\n";
		if ((defined $c_tags{$tag_holder}) and (defined $h_doc_tags{$tag_holder})) {
			#print $tag_holder."\n";
		}
		
	}
}

print"\nEvaluated $tag_count Tags\n";
if ($any_diff == 0) {
    print"No differences found!\n\n";
} else {
	print"Found $seperate_count different Tags\n\n";
}

print"end processing\n";

