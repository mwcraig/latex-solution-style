#!/usr/bin/perl

use strict;

my @files = ();
my ($file_arg,$target,$file,$filelist,$dependencies);

die "Usage:\n\t $0 target\n" if $#ARGV<0;
$file_arg=$ARGV[0];
die "Cannot calculate dependencies for non-existent file" if ! -f $file_arg;
$file_arg =~ /^(.*)\.tex$/;
$target = $1;
push @files, $file_arg;
while (scalar @files)
{
    $file = pop @files;
    open(SRC, $file);
    print $file."\n";
    while(<SRC>)
    {
	next if /^%/;
	if (/^.*\\input\{([^\}]*)\}/)
	{
	    push @files, $1;
	}
	if (/^.*\\include\{([^\}]*)\}/)
	{
	    push @files, $1.".tex";
	}
	if (/^.*\\bibliography\{([^\}]*)\}/)
	{
	    push @files, $1.".bib";
	}
	if (/^.*\\epsfig\{file=([^,]*)/)
	{
	    push @files, $1;
	}
	if (/^.*\\psfig\{file=([^,]*)/)
	{
	    push @files, $1;
	}
	if (/^.*\\includegraphics.*\{([^,}]*)/)
	{
	    push @files, $1;
	}
    }
    $filelist.=" $file";
    close SRC;
}

$dependencies = <<EOP;
$target.dvi : $filelist $target.d
$target.d : $filelist
EOP

open MAKEFILE, "> ".$target.".d";
print MAKEFILE $dependencies;
close MAKEFILE;


