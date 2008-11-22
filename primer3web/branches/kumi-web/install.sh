#! /bin/sh

# Primer-web installation script
# 
# -kumi <kkhawi@gmail.com>, 2006

package="primer3-web"

## ---- Edit these strings to change default installation directory

#- dry-run


#- Windows (highly Mingw/MSYS specific)

# for win32, file path HAS to be in Apache format; use forward slashes instead of backslashes.
SERVERROOT="C:/Program Files/Apache Software Foundation/Apache2.2/" # configuration for installation
SITEROOT="/primer/"  # configuration in relation to webserver
CGIBIN="/cgi-bin/primer/"        #primer specific scripts
PRIMER_BIN="${CGIBIN}primer3_core.exe"
HTML="${SERVERROOT}htdocs/primer/"
SEQDATA="${SERVERROOT}htdocs/primer/data"
DOC="${SERVERROOT}htdocs/primer/doc"
PERL="C:/Perl/bin/perl.exe"   # file path; Apache format, for #! generation

#- Unix
#SERVERROOT="/var/www/"                    # root of the httpd server  
#PRIMER_BIN="/usr/local/bin/primer3_core" # the primer executable
#CGIBIN="/var/www/cgi-bin"               # cgi scripts
#HTML="/var/www/primer-html"             # html files accompanying scripts
#SEQDATA="/var/www/primer-data/"          # genetic sequence data
#DOC="/usr/local/doc/"                    # primer-web README and helpfiles
#PERL="/usr/bin/perl"

## -----------------------------------------------------------------

OS=`uname | cut -c1-4`

progname=`echo $0 | sed -e 's,.*/,,'`

#echo "$progname; $cgibin; $htdocs; $data; $docs"

# Check to see if we have all the required files

# Configure the installation directories    
if [ "${OS}" = "MING" ]
then 
    printf "Mingw based windows detected. You will be prompted for options\n"
    printf "or press Ctrl-c and edit $progname yourself. Continue? [y/n]: "
    read answer
    if [ "$answer" != "y" ]
    then
	exit 1
    fi
fi

printf "\nJust press <enter> to accept defaults\n"


printf "SERVERROOT [${SERVERROOT}]="
read answer
if test -n "$answer"
then SERVERROOT=$answer 
fi

printf "PRIMER_BIN [${PRIMER_BIN}]="
read answer
if test -n "$answer"
then 
    PRIMER_BIN=$answer 
fi

printf "CGIBIN [${CGIBIN}]="
read answer
if test -n "$answer"
then
    CGI=$answer 
fi
	
printf "HTML [${HTML}]="
read answer
if test -n "$answer"
then
    HTML=$answer 
fi
	
printf "SEQDATA [${SEQDATA}]="
read answer
if test -n "$answer"
then SEQDATA=$answer 
fi

printf "DOC [${DOC}]="
read answer
if test -n "$answer"
then DOC=$answer 
fi

printf "PERL [${PERL}]="
read answer
if test -n "$answer"
then PERL=$answer 
fi


# Generate the scripts with the right paths set
echo ""
echo "--- Configuration"
echo "\$SERVERROOT=\"$SERVERROOT\";"
echo "\$CGIBIN=\"$CGIBIN\";"
echo "\$PRIMER_BIN=\"$PRIMER_BIN\";"
echo "\$HTML=\"$HTML\";"
echo "\$SEQDATA=\"$SEQDATA\";"
echo "\$DOC=\"$DOC\";"
echo "\$PERL=\"$PERL\";"



