#!/bin/perl

# Primer-web installation script
# 
# -kumi <kkhawi@gmail.com>, 2006

## ---- Edit these strings to change default installation directory

#- dry-run


#- Windows (highly Mingw/MSYS specific)

# for win32, file path HAS to be in Apache format; use forward slashes instead of backslashes.
$SERVERROOT="C:/Program Files/Apache Software Foundation/Apache2.2/"; # webserver installation location
$SITEROOT="/primer/";                                                 # configuration in relation to webserver
$CGIBIN="/cgi-bin/primer/";                                           #primer specific scripts
$PRIMER_BIN="${CGIBIN}primer3_core.exe";                              # the primer executable
$HTML="${SERVERROOT}htdocs/primer/";                                 # web-user documentation
$SEQDATA="${SERVERROOT}htdocs/primer/data/";                          # sequence data
$DOC="${SERVERROOT}htdocs/primer/doc/";                               # maintainer documentation
$PERL="C:/Perl/bin/perl.exe";   # file path; Apache format, for #! generation

#- Unix
#SERVERROOT="/var/www/";                    # root of the httpd server  
#PRIMER_BIN="/usr/local/bin/primer3_core";  # the primer executable
#CGIBIN="/var/www/cgi-bin";                 # cgi scripts
#HTML="/var/www/primer-html";               # html files accompanying scripts
#SEQDATA="/var/www/primer-data/";           # genetic sequence data
#DOC="/usr/local/doc/";                     # primer-web README and helpfiles
#PERL="/usr/bin/perl";

## -----------------------------------------------------------------


use File::Spec::Functions;

$path = File::Spec->catfile


foreach opt ($SERVERROOT $PRIMERBIN $CGIBIN $HTML $SEQDATA $DOC $PERL) {
    if (-e )
	

}





