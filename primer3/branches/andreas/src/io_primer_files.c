/*
Copyright (c) 1996,1997,1998,1999,2000,2001,2004,2006,2007
Whitehead Institute for Biomedical Research, Steve Rozen
(http://jura.wi.mit.edu/rozen), and Helen Skaletsky
All rights reserved.

    This file is part of primer3 and the primer3 suite.

    Primer3 and the primer3 suite are free software;
    you can redistribute them and/or modify them under the terms
    of the GNU General Public License as published by the Free
    Software Foundation; either version 2 of the License, or (at
    your option) any later version.

    This software is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this file (file gpl-2.0.txt in the source
    distribution); if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNERS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/
#include <stdio.h>
#include <string.h>

#include <signal.h>
#include <errno.h>
#include <stdlib.h>
#include <setjmp.h>

#include "io_primer_files.h"
#include "libprimer3.h"

/* Andreas, this is the idea, argument list will need
   to be cleaned up */
static int    p3_print_one_oligo_list(const seq_args *, 
				      int, const primer_rec[],
				      const oligo_type, const int, 
				      const int, FILE *);
static int    print_list_header(FILE *, oligo_type, int, int);
static int    print_oligo(FILE *, const seq_args *, int, const primer_rec *,
			  oligo_type, int, int);
static void*  pr_safe_malloc(size_t x);

static jmp_buf _jmp_buf;

/* return 0 on success, 1 on error */
/* This function is for backward compatability
   in boulder io testing. FIX ME: Does that still holds true? */
int
p3_print_oligo_lists(const p3retval *retval,
		     const seq_args *sa,
		     const p3_global_settings *pa,
		     pr_append_str *err)
{
	/* Figure out if the sequence starts at position 1 or 0 */
    int   first_base_index = pa->first_base_index;
    int   ret;
    /* Start building up a filename */
    char *file = pr_safe_malloc(strlen(sa->sequence_name) + 5);
    FILE *fh;

    /* Check if the left primers have to be printed */
    if(pa->pick_left_primer) {
    /* OK pa->primer_task != pick_right_only 
	   && pa->primer_task != pick_hyb_probe_only*/
      /* Create the file name and open file*/
	  strcpy(file, sa->sequence_name);
      strcat(file, ".for");
      if (!(fh = fopen(file,"w"))) {
	pr_append_new_chunk(err, "Unable to open file ");
	pr_append(err, file);
	pr_append(err, " for writing");
	free(file);
	return 1;
      }
      /* Print the content to the file */
      ret = p3_print_one_oligo_list(sa, retval->n_f, retval->f, 
			      OT_LEFT, first_base_index, 
			      NULL != pa->p_args.repeat_lib, fh);
      fclose(fh);
      if (ret) return 1;
    }

    /* Check if the right primers have to be printed */
    if (pa->pick_right_primer) {
	/* pa->primer_task != pick_left_only 
	   && pa->primer_task != pick_hyb_probe_only*/ 
      /* Create the file name and open file*/
      strcpy(file, sa->sequence_name);
      strcat(file, ".rev");
      if (!(fh = fopen(file,"w"))) {
	pr_append_new_chunk(err, "Unable to open file ");
	pr_append(err, file);
	pr_append(err, " for writing");
	free(file);
	return 1;
      }
      /* Print the content to the file */
      ret = p3_print_one_oligo_list(sa, retval->n_r, retval->r, 
				    OT_RIGHT, first_base_index,
				    NULL != pa->p_args.repeat_lib, fh);

      fclose(fh);
      if (ret) return 1;
    }

    /* Check if the internal oligos have to be printed */
    if (pa->pick_internal_oligo) { 
    /* pa->primer_task == pick_pcr_primers_and_hyb_probe 
	   || pa->primer_task == pick_hyb_probe_only */ 
      /* Create the file name and open file*/
      strcpy(file, sa->sequence_name);
      strcat(file, ".int");
      if (!(fh = fopen(file,"w"))) {
	pr_append_new_chunk(err, "Unable to open file ");
	pr_append(err, file);
	pr_append(err, " for writing");
	free(file);
	return 1;
      }
      /* Print the content to the file */
      ret = p3_print_one_oligo_list(sa, retval->n_m, retval->mid, OT_INTL,
			  first_base_index,
			  NULL != pa->o_args.repeat_lib,
			  fh);
      fclose(fh);
      if (ret) return 1;
    }
    free(file);
    return 0;
}

/* Print out the content of one primer array */
/* Return 1 on error, otherwise 0. */
static int
p3_print_one_oligo_list(const seq_args *sa,
			int n,
			const primer_rec oligo_arr[],
			const oligo_type o_type,
			const int first_base_index, 
			const int print_lib_sim,
			FILE  *fh
			)
{
  int i;
  
    /* Print out the header for the table */
    if (print_list_header(fh, o_type, first_base_index, print_lib_sim))
      return 1; /* error */
    /* Iterate over the array */
    for (i = 0; i < n; i++) {
    /* Print each single oligo */
	if (print_oligo(fh, sa, i, &oligo_arr[i], o_type,
			first_base_index, print_lib_sim))
	  return 1; /* error */
    }
    return 0; /* success */
}

static int
print_list_header(fh, type, first_base_index, print_lib_sim)
    FILE *fh;
    oligo_type type;
    int first_base_index, print_lib_sim;
{
  int ret;
    ret = fprintf(fh, "ACCEPTABLE %s\n",
            OT_LEFT == type ? "LEFT PRIMERS"
            : OT_RIGHT == type ? "RIGHT PRIMERS" : "INTERNAL OLIGOS");
    if (ret < 0) return 1;

    ret = fprintf(fh, "                               %4d-based     ", 
	    first_base_index);
    if (ret < 0) return 1;

    if (print_lib_sim)
	ret = fprintf(fh, "#               self  self   lib  qual-\n");
    else
	ret = fprintf(fh, "#               self  self  qual-\n");
    if (ret < 0) return 1;    

    ret = fprintf(fh, "   # sequence                       start ln  "); 
    if (ret < 0) return 1;

    if (print_lib_sim)
	ret = fprintf(fh, "N   GC%%     Tm   any   end   sim   lity\n");
    else 
	ret = fprintf(fh, "N   GC%%     Tm   any   end   lity\n");

    if (ret < 0) return 1;
    return 0;
}

static int
print_oligo(FILE *fh,
	    const seq_args *sa, 
	    int index, 
	    const primer_rec *h, 
	    oligo_type type, 
	    int first_base_index, 
	    int print_lib_sim)
{
  int ret;
    char *p =  /* WARNING, *p points to static storage that
		  is overwritten on next call to pr_oligo_sequence
		  or pr_oligo_rev_c_sequence. */
      (OT_RIGHT != type) 
      ? pr_oligo_sequence(sa, h) 
      : pr_oligo_rev_c_sequence(sa, h);

    if (print_lib_sim) {
	ret = fprintf(fh,
		"%4d %-30s %5d %2d %2d %5.2f %5.3f %5.2f %5.2f %5.2f %6.3f\n",
		index, p, h->start+sa->incl_s + first_base_index, 
		h->length,
		h->num_ns, h->gc_content, h->temp,
		h->self_any / PR_ALIGN_SCORE_PRECISION,
		h->self_end / PR_ALIGN_SCORE_PRECISION,
		h->repeat_sim.score[h->repeat_sim.max] /PR_ALIGN_SCORE_PRECISION,
		h->quality);
    } else {
	ret = fprintf(fh,
		"%4d %-30s %5d %2d %2d %5.2f %5.3f %5.2f %5.2f %6.3f\n",
		index, p, h->start+sa->incl_s + first_base_index, 
		h->length,
		h->num_ns, h->gc_content, h->temp,
		h->self_any / PR_ALIGN_SCORE_PRECISION,
		h->self_end / PR_ALIGN_SCORE_PRECISION,
		h->quality);
    }
    if (ret < 0) return 1;
    else return 0;
}


/* =========================================================== */
/* Malloc and realloc wrappers that longjmp() on failure       */
/* =========================================================== */
static void *
pr_safe_malloc(size_t x)
{
    void *r = malloc(x);
    if (NULL == r) longjmp(_jmp_buf, 1);
    return r;
}

/* End of malloc/realloc wrappers. */
/* =========================================================== */
