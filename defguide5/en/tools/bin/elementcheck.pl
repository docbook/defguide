#!/usr/bin/perl -- # -*- Perl -*-

use strict;
use English;

my $root = "/sourceforge/docbook/defguide5/en";

my $elemlist = "$root/build/lib/elementlist.txt";
my $refdir = "$root/refpages/elements";

my %elements = ();

open (F, $elemlist);
while (<F>) {
    chop;
    die "Unparseable: $_\n" if !/^(\S+) (\d+) (\S+)$/;
    my $element = $1;
    my $count = $2;
    my $pattern = $3;

    $elements{$element} = 0 if ! exists $elements{$element};
    $elements{$element}++;

    my $dir = $element;
    $dir =~ s/:.*$//;

    if (-d "$refdir/$dir") {
	if (! -f "$refdir/$dir/$pattern.xml") {
	    print "Missing file: $dir/$pattern.xml\n";
	}
    } else {
	print "Missing directory: $dir\n";
    }
}
close (F);

opendir (DIR, $refdir);
while (my $name = readdir(DIR)) {
    next if $name =~ /\.\.?$/;
    my $dir = "$refdir/$name";
    next if ! -d $dir;

    if ($elements{$name} || $name eq 'html') {
	# html is a special case...
	opendir (XMLDIR, $dir);
	while (my $fname = readdir (XMLDIR)) {
	    my $fspec = "$dir/$fname";
	    next if -d $fspec;
	    next if $fspec !~ /\.xml$/;
	    next if $fname =~ /^example\./;

	    my $found = 0;
	    open (F, $fspec);
	    while (<F>) {
		chop;
		my $pat = "";
		$pat = $1 if /<releaseinfo\s+role=.pattern.\s*>(.*?)<\/rel/;
		$found = 1 if $fname eq "$pat.xml";
		last if $found;
	    }
	    close (F);
	    print "No pattern: $fspec\n" if !$found;
	}
	closedir (XMLDIR);
    } else {
	print "Extra directory: $name\n";
    }
}
closedir (DIR);
