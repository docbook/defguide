# -*- Perl -*-

# dtdformat module for RefEntrys for DB:TDG

my $VERSION = "SF DocBook 1.0";

my $PUBLIC_ID   = "-//OASIS//DTD DocBook XML V4.1.2//EN";
my $SYSTEM_ID   = "http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd";

$fileext    = ".xml";
$libdir     = "/sourceforge/docbook/defguide/en/build/lib";

$config{'expanded-element-index'} = "elements";
$config{'unexpanded-element-index'} = "dtdelem";
$config{'expanded-entity-index'} = "entities";
$config{'unexpanded-entity-index'} = "dtdent";
$config{'expanded-entity-dir'} = 'paraments';
$config{'unexpanded-entity-dir'} = 'paraments';
$config{'notation-index'} = 'notations';

$option{'base-id'} = 'dbre';
$option{'base-dir'} = "$libdir/../../refpages";
$option{'seealso'} = 1;

my %entity_classes = ();
my @entity_classes = ();
my @entity_pats    = ();

my %revision = ('productionset' => 'EBNF',
		'production' => 'EBNF',
		'lhs' => 'EBNF',
		'rhs' => 'EBNF',
		'nonterminal' => 'EBNF',
		'constraint' => 'EBNF',
		'productionrecap' => 'EBNF',
		'constraintdef' => 'EBNF',

		'bibliocoverage' => '4.2',
		'biblioid' => '4.2',
		'bibliorelation' => '4.2',
		'bibliosource' => '4.2',
		'blockinfo' => '4.2',
		'citebiblioid' => '4.2',
		'coref' => '4.2',
		'errortext' => '4.2',
		'personblurb' => '4.2',
		'personname' => '4.2',
		'refsection' => '4.2',
		'refsectioninfo' => '4.2',
		'textdata' => '4.2',

		'appendixinfo' => '4.0',
		'articleinfo' => '4.0',
		'bibliographyinfo' => '4.0',
		'chapterinfo' => '4.0',
		'classsynopsis' => '4.0',
		'classsynopsisinfo' => '4.0',
		'constructorsynopsis' => '4.0',
		'destructorsynopsis' => '4.0',
		'exceptionname' => '4.0',
		'fieldsynopsis' => '4.0',
		'glossaryinfo' => '4.0',
		'indexinfo' => '4.0',
		'initializer' => '4.0',
		'interfacename' => '4.0',
		'methodname' => '4.0',
		'methodparam' => '4.0',
		'methodsynopsis' => '4.0',
		'modifier' => '4.0',
		'ooclass' => '4.0',
		'ooexception' => '4.0',
		'oointerface' => '4.0',
		'partinfo' => '4.0',
		'prefaceinfo' => '4.0',
		'refentryinfo' => '4.0',
		'referenceinfo' => '4.0',
		'remark' => '4.0',
		'revdescription' => '4.0',
		'setindexinfo' => '4.0',
		'sidebarinfo' => '4.0',
		'simplemsgentry' => '4.0',

		'mediaobject' => '3.1',
		'mediaobjectco' => '3.1',
		'inlinemediaobject' => '3.1',
		'videoobject' => '3.1',
		'audioobject' => '3.1',
		'imageobject' => '3.1',
		'imageobjectco' => '3.1',
		'textobject' => '3.1',
		'objectinfo' => '3.1',
		'videodata' => '3.1',
		'audiodata' => '3.1',
		'imagedata' => '3.1',
		'caption' => '3.1',
		'informalfigure' => '3.1',
		'colophon' => '3.1',
		'section' => '3.1',
		'sectioninfo' => '3.1',
		'qandaset' => '3.1',
		'qandadiv' => '3.1',
		'qandaentry' => '3.1',
		'question' => '3.1',
		'answer' => '3.1',
		'constant' => '3.1',
		'varname' => '3.1');

# ======================================================================
{
    print "\nLoading parament classes...";

    local *F, $_;
    my $class, $regexp;
    my %classes = ();
    open (F, "$libdir/parament.classes");
    while (<F>) {
	chop;
	if (/^\s+(\S+)/) {
	    $entity_classes{$1} = $class;
	} elsif (/^(\S+)\s+(\S+)/) {
	    $class = $1;
	    $regexp = $2;
	    $regexp =~ s/\./\\\./g;
	    $regexp =~ s/\*/\.\*/g;
	    push(@entity_classes, $class);
	    push(@entity_pats, $regexp);
	    $classes{$class} = 1;
	} elsif (/^(\S+)\s*$/) {
	    $class = $1;
	    $classes{$class} = 1;
	} else {
	    warn "Unexpected line in parament.classes: $_\n";
	}
    }

    print "\nCleaning up parament class files...";

    foreach $class (keys %classes) {
	my $basedir = $option{'base-dir'};
	my $path = $basedir . "/" . $config{'expanded-entity-dir'};
	unlink("$path/$class.e.gen");
	$path = $basedir . "/" . $config{'unexpanded-entity-dir'};
	unlink("$path/$class.u.gen");
    }
}

END {
    # Now that we've written out all those parameter entity files,
    # make sure the entities in them are sorted...

    &status("Sorting entities...",1);

    my $basedir = $option{'base-dir'};
    my $path = $basedir . "/" . $config{'expanded-entity-dir'};
    opendir (DIR, $path);
    while (my $name = readdir(DIR)) {
	my $file = "$path/$name";
	next if $name !~ /\.gen$/;
	next if -d $file;
	open (F, $file);
	read (F, $_, -s $file);
	close (F);

	my %refsects = ();
	while (/<refsect2.*?id=([\'\"])(.*?)\1.*?<\/refsect2>\s+/s) {
	    my $sect = $&;
	    my $id = $2;
	    $_ = $` . $'; # '
	    die "Duplicate refsect ID: $2\n" if $refsects{$id};
	    $refsects{$id} = $sect;
	}

	die "Unexpected content in $file: $_\n" if !/^\s*$/s;

	open (F, ">$file");
	foreach my $id (sort keys %refsects) {
	    print F $refsects{$id};
	}
	close (F);
    }
    closedir (DIR);

    print "\n";

}

# ======================================================================

sub elementRefpurpose {
    my $count   = shift;
    my $name    = $elements[$count];

    return "&$name.purpose;";
}

sub entityRefpurpose {
    my $count  = shift;
    my $name   = $entities[$count];
    my $entity = $entities{$name};

    return "&$baseid.purp." . $entity->getAttribute('type') . "." . $name;
}

sub notationRefpurpose {
    my $count   = shift;
    my $name    = $notations[$count];

    return "&$baseid.purp.notn.$name;";
}

sub elementDescription {
    my $count = shift;
    my $name  = $elements[$count];
    my $desc  = "$descdir/$name.sgm";
    local $_;

#    return "&" . "desc.elem.$name;";

    open (F, $desc);
    read (F, $_, -s $desc);
    close (F);

    return "\n" . $_;
}

sub entityDescription {
    my $count = shift;

    return "<para>desc</para>\n";
}

sub notationDescription {
    my $count = shift;

    return "<para>desc</para>\n";
}

# ======================================================================

sub basenames {
    my @names = @_;
    my %basename = ();
    my %usedname = ();

    foreach my $name (@names) {
	my $count = 2;
	my $bname = lc($name);

	if ($usedname{$bname}) {
	    $bname = lc($name) . $count;
	    while ($usedname{$bname}) {
		$bname++;
	    }
	}

	$basename{$name} = $bname;
	$usedname{$name} = 1;
    }

    return %basename;
}

# ======================================================================

sub formatElement {
    my $count   = shift;
    my $html    = "";

    my $name    = $elements[$count];
    my $element = $elements{$name};

    my $cmex    = undef;
    my $cmunx   = undef;
    my $incl    = undef;
    my $excl    = undef;

    my $node = $element->getFirstChild();
    while ($node) {
	if ($node->getNodeType() == XML::DOM::ELEMENT_NODE) {
	    $cmex = $node if $node->getTagName() eq 'content-model-expanded';
	    $cmunx = $node if $node->getTagName() eq 'content-model';
	    $incl = $node if $node->getTagName() eq 'inclusions';
	    $excl = $node if $node->getTagName() eq 'exclusions';
	}
	$node = $node->getNextSibling();
    }

    $html .= &formatElementHeader($count);

    $html .= &formatElementTitle($count);

    if ($option{'synopsis'}) {
	if ($expanded eq 'expanded') {
	    $html .= &formatElementSynopsis($count, $cmex, $cmex, $incl, $excl);
	} else {
	    $html .= &formatElementSynopsis($count, $cmunx, $cmex, $incl, $excl);
	}
    }

    $html .= &formatElementDescription($count) if $option{'description'};

    $html .= &formatElementAttrDescription($count) if $option{'attributes'};

    $html .= &formatElementSeeAlso($count) if $option{'seealso'};

    $html .= &formatElementExample($count) if $option{'examples'};

    $html .= &formatElementFooter($count);
}

sub formatElementHeader {
    my $count     = shift;
    my $html      = "";
    my $name      = $elements[$count];
    my $element   = $elements{$name};

    my $pub = "-//OASIS//DTD DocBook XML V4.2//EN";
    my $sys = "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd";

    my $dir = $option{'base-dir'} . "/elements/$name";
    if (! -d $dir) {
	mkdir($dir, 0755);
    }

    my $filename = "reference.e.xml";

    my $rpub = "-//O'Reilly//ENTITIES DocBook RefPurposes V2.0//EN";
    my $rsys = "../../../entities/refpurps.ent";

    $html = "";
    $html .= "<!DOCTYPE reference PUBLIC \"$pub\"\n";
    $html .= "          \"$sys\" [\n";
    $html .= "<!ENTITY % refpurps.ent PUBLIC \"$rpub\" \"$rsys\">\n";
    $html .= "%refpurps.ent;\n";
    $html .= "<!ENTITY % entities.ent SYSTEM \"entities.e.ent\">\n";
    $html .= "%entities.ent;\n";
    $html .= "<!ENTITY refentry.xml SYSTEM \"refentry.xml\">\n";
    $html .= "]>\n";
    $html .= "<reference><title>$name Refentry</title>\n";
    $html .= "&refentry.xml;\n";
    $html .= "</reference>\n";

    if (! -f "$dir/$filename") {
	open (F, ">$dir/$filename");
	print F $html;
	close (F);
    }

    $filename = "reference.u.xml";

    $html = "";
    $html .= "<!DOCTYPE reference PUBLIC \"$pub\"\n";
    $html .= "          \"$sys\" [\n";
    $html .= "<!ENTITY % refpurps.ent PUBLIC \"$rpub\" \"$rsys\">\n";
    $html .= "%refpurps.ent;\n";
    $html .= "<!ENTITY % entities.ent SYSTEM \"entities.u.ent\">\n";
    $html .= "%entities.ent;\n";
    $html .= "<!ENTITY refentry.xml SYSTEM \"refentry.xml\">\n";
    $html .= "]>\n";
    $html .= "<reference><title>$name Refentry</title>\n";
    $html .= "&refentry.xml;\n";
    $html .= "</reference>\n";

    if (! -f "$dir/$filename") {
	open (F, ">$dir/$filename");
	print F $html;
	close (F);
    }

    $html = "";
    $html .= "<refentry id=\"$name.element\"";
    $html .= " revision='" . $revision{$name} . "'" if $revision{$name};
    $html .= ">\n";
    $html .= "<?dbhtml filename=\"$name.html\"?>\n\n";

    return $html;
}

sub formatElementTitle {
    my $count   = shift;
    my $name    = $elements[$count];
    my $element = $elements{$name};
    my $html = "";

    $html .= "<refmeta>\n";
    $html .= "<indexterm><primary>elements</primary>\n";
    $html .= "<secondary>" . $element->getAttribute('name') . "</secondary></indexterm>\n";

    $html .= "<refentrytitle>";
    $html .= $element->getAttribute('name');
    $html .= "</refentrytitle>\n";
    $html .= "<refmiscinfo>Element</refmiscinfo>\n";
    $html .= "</refmeta>\n";

    $html .= "<refnamediv>\n";
    $html .= "<refname>" . $element->getAttribute('name') . "</refname>\n";
    $html .= "<refpurpose>";
    $html .= &elementRefpurpose($count);
    $html .= "</refpurpose>\n";
    $html .= "</refnamediv>\n\n";

    return $html;
}

sub formatElementSynopsis {
    my $count   = shift;
    my $name    = $elements[$count];
    my $element = $elements{$name};
    my $cm      = shift;
    my $cmex    = shift;
    my $incl    = shift;
    my $excl    = shift;
    my $html = "";

    # What are the possibilities: mixed content, element content, or
    # declared content...
    my $mixed    = $element->getAttribute('content-type') eq 'mixed';
    my $declared = (!$mixed &&
		    $element->getAttribute('content-type') ne 'element');

    $html .= "<refsynopsisdiv><title>Synopsis</title>\n";
    $html .= "<informaltable frame='all' role='elemsynop'>\n";
    $html .= "<tgroup cols='3'>\n";
    $html .= "<colspec colnum='1' colname='c1'/>\n";
    $html .= "<colspec colnum='2' colname='c2'/>\n";
    $html .= "<colspec colnum='3' colname='c3'/>\n";
    $html .= "<tbody>\n";

    $html .= "<row condition='ref.synopsis' rowsep='0' role='cmtitle'>\n";
    $html .= "<entry namest='c1' nameend='c3' align='left'\n";
    $html .= "><emphasis role='bold'>";

    if ($mixed) {
	$html .= "Mixed Content Model";
    } elsif ($declared) {
	$html .= "Declared Content";
    } else {
	$html .= "Content Model";
    }

    $html .= "</emphasis></entry>\n";
    $html .= "</row>\n";

    $html .= "<row condition='ref.synopsis' rowsep='1' role='cmsynop'>\n";
    $html .= "<entry namest='c1' nameend='c3' align='left'\n";
    $html .= "><synopsis>";
    $html .= $element->getAttribute('name') . " ::=\n";
    $html .= &formatContentModel($count, $cm);

    $html .= "</synopsis></entry>\n";
    $html .= "</row>\n";

    $html .= &formatInclusions($count, $incl)
        if $incl && $option{'inclusions'};

    $html .= &formatExclusions($count, $excl)
        if $excl && $option{'exclusions'};

    $html .= &formatAttributeList($count) if $option{'attributes'};

    $html .= &formatTagMinimization($count) if $option{'tag-minimization'};

    $html .= &formatElementAppearsIn($count) if $option{'appears-in'};

    $html .= "</tbody>\n";
    $html .= "</tgroup>\n";
    $html .= "</informaltable>\n";
    $html .= "</refsynopsisdiv>\n";

    my $dir = $option{'base-dir'} . "/elements/$name";
    if (! -d $dir) {
	mkdir($dir, 0755);
    }

    my $filename = "synopsis";
    if ($expanded eq 'expanded') {
	$filename .= ".e";
    } else {
	$filename .= ".u";
    }

    open (SYNOP, ">$dir/$filename.gen") || die "Can't open: $dir/$filename.gen: $!";
    print SYNOP $html;
    close (SYNOP);

    $html = "&$name.synopsis.gen;\n";

    return $html;
}

sub formatInclusions {
    my $count   = shift;
    my $cm      = shift;
    my $name    = $elements[$count];
    my $element = $elements{$name};
    my $html    = "";

#    $html .= "<![ %" . "$baseid.ms.elem.inclusions; [\n";
    $html .= "<row condition='ref.inclusions' rowsep='0' role='incltitle'>\n";
    $html .= "<entry namest='c1' nameend='c3' align='left'\n";
    $html .= "><emphasis role='bold'>Inclusions</emphasis></entry>\n";
    $html .= "</row>\n";

    $html .= "<row condition='ref.inclusions' rowsep='1' role='inclsynop'>\n";
    $html .= "<entry namest='c1' nameend='c3' align='left'\n";
    $html .= "><synopsis>";
    $html .= &formatContentModel($count, $cm);
    $html .= "</synopsis></entry>\n";
    $html .= "</row>\n";
#    $html .= "]]>\n";

    return $html;
}

sub formatExclusions {
    my $count   = shift;
    my $cm      = shift;
    my $name    = $elements[$count];
    my $element = $elements{$name};
    my $html    = "";

#    $html .= "<![ %" . "$baseid.ms.elem.exclusions; [\n";
    $html .= "<row condition='ref.exclusions' rowsep='0' role='excltitle'>\n";
    $html .= "<entry namest='c1' nameend='c3' align='left'\n";
    $html .= "><emphasis role='bold'>Exclusions</emphasis></entry>\n";
    $html .= "</row>\n";

    $html .= "<row condition='ref.exclusions' rowsep='1' role='exclsynop'>\n";
    $html .= "<entry namest='c1' nameend='c3' align='left'\n";
    $html .= "><synopsis>";
    $html .= &formatContentModel($count, $cm);
    $html .= "</synopsis></entry>\n";
    $html .= "</row>\n";
#    $html .= "]]>\n";

    return $html;
}

sub formatAttributeList {
    my $count   = shift;
    my $html    = "";
    my $name    = $elements[$count];
    my $element = $elements{$name};
    my $attlist = $attlists{$name};
    my %attrs   = ();
    my %cmnatt  = ('id' => 0,
		   'role' => 0,
		   'lang' => 0,
		   'remap'=> 0,
		   'xreflabel' => 0,
		   'revisionflag' => 0,
		   'arch' => 0,
		   'conformance' => 0,
		   'os' => 0,
		   'revision' => 0,
		   'userlevel' => 0,
		   'vendor' => 0,
		   'security' => 0,
		   'condition' => 0);
    my $common  = 1;
    my $uncommon = 0;

    # Check for DocBook common attributes

    if (defined($attlist)) {
	my $attelem = $attlist->getElementsByTagName("attribute");

	for (my $count = 0; $count < $attelem->getLength(); $count++) {
	    my $attr = $attelem->item($count);
	    my $name = $attr->getAttribute('name');
	    $attrs{$name} = 1;
	    if (exists $cmnatt{lc($name)}) {
		$cmnatt{lc($name)} = 1;
	    } else {
		$uncommon = 1;
	    }
	}

	foreach my $attr (keys %cmnatt) {
	    $common = 0 if $cmnatt{$attr} == 0;
	}

	if ($common) {
	    foreach my $attr (keys %attrs) {
		delete $attrs{$attr} if exists $cmnatt{lc($attr)};
	    }
	}
    }

#    $html .= "<![ %" . "$baseid.ms.elem.refsynopsisdiv.attr; [\n";

    my $rowsep = "1";
    $rowsep = "0" if defined($attlist) && ($uncommon || !$common);

    $html .= "<row condition='ref.rsdiv.attr' rowsep='$rowsep' role='attrtitle'>\n";
    $html .= "<entry colsep='0'\n";
    $html .= "><emphasis role='bold'>Attributes</emphasis></entry>\n";

    if (!defined($attlist)) {
	$html .= "<entry namest='c2' nameend='c3'>";
	$html .= "None";
	$html .= "</entry>\n";
    } elsif ($common) {
	$html .= "<entry namest='c2' nameend='c3'>";
	$html .= "<phrase role=\"common.attributes\">";
	$html .= "Common attributes";
	$html .= "</phrase>";
#	$html .= "<link linkend=\"$baseid.x.common\">Common attributes</link>";
	$html .= "</entry>\n";
    } else {
	$html .= "<entry namest='c2' nameend='c3'></entry>\n";
    }

    $html .= "</row>\n";

    if (defined($attlist) && ($uncommon || !$common)) {
	$html .= "<row condition='ref.rsdiv.attr' rowsep='1' role='attrheader'>\n";
	$html .= "<entry role='th'><para\n";
	$html .= "><emphasis role='bold'>Name</emphasis></para></entry>\n";
	$html .= "<entry role='th'><para\n";
	$html .= "><emphasis role='bold'>Type</emphasis></para></entry>\n";
	$html .= "<entry role='th'><para\n";
	$html .= "><emphasis role='bold'>Default</emphasis></para></entry>\n";
	$html .= "</row>\n";
	$html .= &formatAttributes($attlist, 'ref.rsdiv.attr', %attrs);
    }

#    $html .= "]]>\n\n";

    return $html;
}

sub formatAttributes {
    my $attlist = shift;
    my $condition = shift;
    my %atthash = @_;
    my $html    = "";
    my $attrs   = $attlist->getElementsByTagName("attribute");
    my $last    = "";

    # figure out the last; have to do it this way because we may
    # skip some attributes, possibly the one that's last in the
    # actual list.
    for (my $count = 0; $count < $attrs->getLength(); $count++) {
	my $attr = $attrs->item($count);
	my $name     = $attr->getAttribute('name');
	next if !exists $atthash{$name};
	$last = $name;
    }

    for (my $count = 0; $count < $attrs->getLength(); $count++) {
	my $attr = $attrs->item($count);

	my $name     = $attr->getAttribute('name');
	my $type     = $attr->getAttribute('value');
	my $decltype = $attr->getAttribute('type');
	my $default = "";

	next if !exists $atthash{$name};

	if ($decltype eq '#IMPLIED') {
	    $default = "<emphasis>None</emphasis>";
	} elsif ($decltype eq '#REQUIRED') {
	    $default = "<emphasis>Required</emphasis>";
	} elsif ($decltype eq '#CONREF') {
	    $default = "<emphasis>Content reference</emphasis>";
	} else {
	    $default = $attr->getAttribute('default');
	    if ($default =~ /\"/) {
		$default = "'" . $default . "'";
	    } else {
		$default = "\"" . $default . "\"";
	    }
	}

	if ($decltype eq '#FIXED') {
	    $default = $default . " <emphasis>(fixed)</emphasis>";
	}

	if ($name eq $last) {
	    $html .= "<row condition='$condition' rowsep=\"1\" role=\"attr\">\n";
	} else {
	    $html .= "<row condition='$condition' role=\"attr\">\n";
	}

	$html .= &formatCell($name);
	$html .= &formatValues($type, $attr);
	$html .= &formatCell($default);
	$html .= "</row>\n";
    }

    return $html;
}

sub formatCell {
    my $value = shift;

    return "<entry align='left' valign='top'>$value</entry>\n";
}

sub formatValues {
    my $values = shift;
    my $attr = shift;
    my $enum = $attr->getAttribute('enumeration');
    my $html = "";

    if ($enum eq 'no' || $enum eq '') {
	return &formatCell($values);
    }

    $html .= "<entry align='left' valign='top'>";
    if ($enum eq 'notation') {
	$html .= "<para><emphasis>Enumerated notation:</emphasis>\n</para>";
    } else {
	$html .= "<para><emphasis>Enumeration:</emphasis>\n</para>";
    }

    $html .= "<simplelist>\n";
    foreach my $val (sort { uc($a) cmp uc($b) }
		     split(/\s+/, $attr->getAttribute('value'))) {
	$html .= "<member>$val</member>\n";
    }
    $html .= "</simplelist></entry>\n";

    return $html;
}

sub formatTagMinimization {
    my $count   = shift;
    my $name    = $elements[$count];
    my $element = $elements{$name};
    my $html    = "";
    my $stagm   = $element->getAttribute('stagm') || "-";
    my $etagm   = $element->getAttribute('etagm') || "-";

    if ($element->getAttribute('stagm')
	|| $element->getAttribute('etagm')) {
	my (%min) = ('--' => "Both the start- and end-tags are required for this element.",
		     'OO' => "Both the start- and end-tags are optional for this element, if your SGML declaration allows tag minimization.",
		     'O-' => "The start-tag is optional for this element, if your SGML declaration allows tag minimization.  The end-tag is required.",
		     '-O' => "The start-tag is required for this element.  The end-tag is optional, if your SGML declaration allows minimization."
		    );

#	$html .= "<![ %" . "$baseid.ms.elem.refsynopsisdiv.tagmin; [\n";
	$html .= "<row condition='ref.rsdiv.tagmin' rowsep='0' role='tmtitle'>\n";
	$html .= "<entry namest='c1' nameend='c3' align='left'\n";
	$html .= "><emphasis role='bold'>Tag Minimization</emphasis>";
	$html .= "</entry>\n";
	$html .= "</row>\n";

	$html .= "<row condition='ref.rsdiv.tagmin' rowsep='1' role='tmsynop'>\n";
	$html .= "<entry namest='c1' nameend='c3' align='left'\n";
	$html .= "><para>";
	$html .= $min{$stagm . $etagm};
	$html .= "</para></entry>\n";
	$html .= "</row>\n";
#	$html .= "]]>\n\n";
    }

    return $html;
}

sub formatElementAppearsIn {
    my $count = shift;
    my $html = "";
    my $elementname = $elements[$count];
    my $element = $elements{$elementname};
    my %appears = ();

    %appears = %{$APPEARSIN{$elementname}} if exists $APPEARSIN{$elementname};

    if (%appears) {
	my @ents = sort { uc($a) cmp uc($b) } keys %appears;

#	$html .= "<![ %" . "$baseid.ms.elem.refsynopsisdiv.pe; [\n";
	$html .= "<row condition='ref.rsdiv.pe' rowsep='0' role='petitle'>\n";
	$html .= "<entry namest='c1' nameend='c3' align='left'\n";
	$html .= "><emphasis role='bold'>Parameter Entities</emphasis>";
	$html .= "</entry>\n";
	$html .= "</row>\n";

	while (@ents) {
	    $html .= "<row condition='ref.rsdiv.pe' rowsep='0' role='pe'>\n";

	    for (my $count = 0; $count < 3; $count++) {
		my $name = shift @ents;
		if ($name) {
		    my $entity = $entities{$name};
		    $html .= "<entry colsep='0'>";
		    $html .= "<sgmltag class='paramentity'>";
		    $html .= $entity->getAttribute('name');
		    $html .= "</sgmltag>";
		    $html .= "</entry>\n";
		} else {
		    $html .= "<entry colsep='0'></entry>\n";
		}
	    }

	    $html .= "</row>\n";
	}

#	$html .= "]]>\n";
    }

    return $html;
}

sub formatElementDescription {
    my $count   = shift;
    my $name    = $elements[$count];
    my $element = $elements{$name};
    my $desc    = &elementDescription($count);
    my $html    = "";

    $html = "<refsect1 condition='ref.description'><title>Description</title>

<para></para>

<refsect2><title>Processing expectations</title>
<para></para>
</refsect2>\n\n";

    $html .= &formatParents($count);
    $html .= &formatChildren($count);

    $html .= "\n</refsect1>\n\n";

    return $html;
}

sub formatParents {
    my $count   = shift;
    my $name    = $elements[$count];
    my $element = $elements{$name};
    my $html    = "";

    if (exists $PARENTS{$name}) {
	$html .= "<refsect2 condition='ref.desc.parents'><title>Parents</title>\n";
	$html .= "<para>These elements contain ";
	$html .= $element->getAttribute('name') . ":\n";
	$html .= "<simplelist type='inline'>";

	my $pname;
	foreach $pname (sort { uc($a) cmp uc($b) } keys %{$PARENTS{$name}}) {
	    my $child = $elements{$pname};
	    $html .= "<member>";
#	    $html .= "<link linkend=\"$baseid.elem.$pname\">";
	    $html .= "<sgmltag>" . $child->getAttribute('name') . "</sgmltag>";
#	    $html .= "</link>";
	    $html .= "</member>\n";
	}

	$html .= "</simplelist>.</para>\n";
	$html .= "</refsect2>\n";

	my $dir = $option{'base-dir'} . "/elements/$name";
	if (! -d $dir) {
	    mkdir($dir, 0755);
	}

	my $filename = "parents";
	if ($expanded eq 'expanded') {
	    open (PAR, ">$dir/$filename.gen") || die "Can't open: $dir/$filename.gen: $!";
	    print PAR $html;
	    close (PAR);
	} else {
	    # unexpanded is exactly the same
	}

	$html = "&$name.parents.gen;\n";
    }

    return $html;
}

sub formatChildren {
    my $count   = shift;
    my $name    = $elements[$count];
    my $element = $elements{$name};
    my $html    = "";
    my $mixed    = $element->getAttribute('content-type') eq 'mixed';
    my $declared = (!$mixed &&
		    $element->getAttribute('content-type') ne 'element');

    return "" if $declared; # can't be any children...

    if (exists $CHILDREN{$name}
	|| exists $POSSINCL{$name}
	|| exists $POSSEXCL{$name}) {
	$html .= "<refsect2 condition='ref.desc.children'><title>Children</title>\n";
    }

    if (exists $CHILDREN{$name}) {
	$html .= "<para>The following elements occur in ";
	$html .= $element->getAttribute('name') . ":\n";
	$html .= "<simplelist type='inline'>";

	my $cname;
	foreach $cname (sort { uc($a) cmp uc($b) } keys %{$CHILDREN{$name}}) {
	    my $child = $elements{$cname};

	    die "Unexpected error (1): can't find element \"$cname\".\n"
		if !$child;

	    $html .= "<member>";
#	    $html .= "<link linkend=\"$baseid.elem.$cname\">";
	    $html .= "<sgmltag>";
	    $html .= $child->getAttribute('name');
	    $html .= "</sgmltag>";
#	    $html .= "</link>";
	    $html .= "</member>\n";
	}

	$html .= "</simplelist>.</para>\n";
    }

    if (exists $POSSINCL{$name}) {
	$html .= "<para>In some contexts, the following elements are\n";
	$html .= "allowed anywhere:\n";
	$html .= "<simplelist type='inline'>\n";

	my $cname;
	foreach $cname (sort { uc($a) cmp uc($b) } keys %{$POSSINCL{$name}}) {
	    my $child = $elements{$cname};

	    die "Unexpected error (2): can't find element \"$cname\".\n"
		if !$child;

	    $html .= "<member>";
#	    $html .= "<link linkend=\"$baseid.elem.$cname\">";
	    $html .= "<sgmltag>";
	    $html .= $child->getAttribute('name');
	    $html .= "</sgmltag>";
#	    $html .= "</link>";
	    $html .= "</member>\n";
	}

	$html .= "</simplelist>.</para>\n\n";
    }

    if (exists $POSSEXCL{$name}) {
	$html .= "<para>In some contexts, the following elements are\n";
	$html .= "excluded:\n";
	$html .= "<simplelist type='inline'>\n";

	my $cname;
	foreach $cname (sort { uc($a) cmp uc($b) } keys %{$POSSEXCL{$name}}) {
	    my $element = $elements{$cname};
	    $html .= "<member>";
#	    $html .= "<link linkend=\"$baseid.elem.$cname\">";
	    $html .= "<sgmltag>";
	    $html .= $element->getAttribute('name');
	    $html .= "</sgmltag>";
#	    $html .= "</link>";
	    $html .= "</member>\n";
	}

	$html .= "</simplelist>.</para>\n\n";
    }

    if (exists $CHILDREN{$name}
	|| exists $POSSINCL{$name}
	|| exists $POSSEXCL{$name}) {
	$html .= "</refsect2>\n";

	my $dir = $option{'base-dir'} . "/elements/$name";
	if (! -d $dir) {
	    mkdir($dir, 0755);
	}

	my $filename = "children";
	if ($expanded eq 'expanded') {
	    open (CHD, ">$dir/$filename.gen") || die "Can't open: $dir/$filename.gen: $!";
	    print CHD $html;
	    close (CHD);
	} else {
	    # unexpanded is exactly the same
	}

	$html = "&$name.children.gen;\n";
    }

    return $html;
}

sub formatElementAttrDescription {
    my $count   = shift;
    my $name    = $elements[$count];
    my $html    = "";
    my $attlist = $attlists{$name};
    my %attrs   = ();
    my %cmnatt  = ('id' => 0,
		   'role' => 0,
		   'lang' => 0,
		   'remap'=> 0,
		   'xreflabel' => 0,
		   'revisionflag' => 0,
		   'arch' => 0,
		   'conformance' => 0,
		   'os' => 0,
		   'revision' => 0,
		   'userlevel' => 0,
		   'vendor' => 0,
		   'security' => 0,
		   'condition' => 0);

    # Check for DocBook common attributes

    if (defined($attlist)) {
	my $attelem = $attlist->getElementsByTagName("attribute");

	for (my $count = 0; $count < $attelem->getLength(); $count++) {
	    my $attr = $attelem->item($count);
	    my $name = $attr->getAttribute('name');
	    $attrs{$name} = 1 if !defined($cmnatt{lc($name)});
	}
    }

    return $html if !%attrs;

    $html .= "<refsect1 condition='ref.elem.attrdesc'><title>Attributes</title>\n";

    $html .= "<variablelist>\n";

    foreach $attr (sort keys %attrs) {
	my $desc = "attr." . lc($attr) . ".$name";

	$html .= "<varlistentry><term>$attr</term>\n";
	$html .= "<listitem>\n";
	$html .= "&$desc;\n";
	$html .= "</listitem>\n";
	$html .= "</varlistentry>\n";
    }

    $html .= "</variablelist>\n";

    $html .= "</refsect1>\n";

    return $html;
}

my %SeeAlso = ();

sub formatElementSeeAlso {
    my $count = shift;
    my $name  = $elements[$count];
    my @group = ();
    my $html  = "";

    if (!%SeeAlso) {
	my $ingroup = 0;

	open (F, "$libdir/seealso") || die "Failed to open: $libdir/seealso\n";
	while (<F>) {
	    chop;
	    if (/^\s+(\S+)/) {
		push(@group, lc($1));
		$ingroup = 1;
	    }

	    if (/^\S/ && $ingroup) {
		$ingroup = 0;
		foreach my $elem (@group) {
		    $SeeAlso{$elem} = {} if ! exists $SeeAlso{$elem};
		    foreach my $grelem (@group) {
			$SeeAlso{$elem}->{$grelem} = 1;
		    }
		}
		@group = ();
	    }

	    if (/^\S/) {
		$title = $_;
	    }
	}
	close (F);
    }

    @group = ();
    foreach my $grelem (sort keys %{$SeeAlso{$name}}) {
	push (@group, $grelem) unless $name eq $grelem;
    }

    if (@group) {
	$html .= "<para>";
	$html .= "<simplelist type=\"inline\">\n";
	foreach my $elem (@group) {
	    my $element = $elements{$elem};
	    $html .= "<member>";
#	    $html .= "<link linkend=\"$baseid.elem.$elem\">";
	    $html .= "<sgmltag>";

	    if ($element) {
		$html .= $element->getAttribute('name');
	    } else {
		print STDERR "No element $elem in formatElementSeeAlso???\n";
		$html .= "???";
	    }

	    $html .= "</sgmltag>";
#	    $html .= "</link>";
	    $html .= "</member>\n";
	}
	$html .= "</simplelist>.\n</para>\n";

	my $dir = $option{'base-dir'} . "/elements/$name";
	if (! -d $dir) {
	    mkdir($dir, 0755);
}

	my $filename = "seealso";
	if ($expanded eq 'expanded') {
	    open (SEE, ">$dir/$filename.gen") || die "Can't open: $dir/$filename.gen: $!";
	    print SEE $html;
	    close (SEE);
	} else {
	    # unexpanded is exactly the same
	}

	$html = "<refsect1 condition='ref.elem.seealso'><title>See Also</title>\n";
	$html .= "&$name.seealso.gen;\n";
	$html .= "</refsect1>\n";
    }

    return $html;
}

sub formatElementExample {
    my $count   = shift;
    my $name    = $elements[$count];
    my $element = $elements{$name};
    my $examplehead = "<refsect1><title>Examples</title>\n\n";
    my $examplefoot = "</refsect1>\n";
    my $see     = "";
    my $example = "";
    my $done    = 0;
    my $excount = 1;

    my %format  = (
		   'blockquote' => 1,
		   'caution' => 1,
		   'cmdsynopsis' => 1,
		   'equation' => 1,
		   'example' => 1,
		   'figure' => 1,
		   'formalpara' => 1,
		   'funcsynopsis' => 1,
		   'glosslist' => 1,
		   'important' => 1,
		   'informalexample' => 1,
		   'informalfigure' => 1,
		   'informaltable' => 1,
		   'itemizedlist' => 1,
		   'mediaobject' => 1,
		   'mediaobjectco' => 1,
		   'msgset' => 1,
		   'note' => 1,
		   'orderedlist' => 1,
		   'para' => 1,
		   'procedure' => 1,
		   'programlistingco' => 1,
		   'qandaset' => 1,
		   'screen' => 1,
		   'screenshot' => 1,
		   'segmentedlist' => 1,
		   'simpara' => 1,
		   'simplelist' => 1,
		   'synopsis' => 1,
		   'table' => 1,
		   'tip' => 1,
		   'variablelist' => 1,
		   'warning' => 1,
		  );

    local *F, $_;

    # this really just makes .txt and .gen versions of the files

    my $dir = $option{'base-dir'} . "/elements/$name";
    if (! -d $dir) {
	mkdir($dir, 0755);
    }

    while (!$done) {
	$done = 1;
	my $filename = "$dir/example.$excount";
	$file = "$filename.xml";

	if (open (F, $file)) {
	    read (F, $_, -s $file);
	    close (F);
	    #$_ .= "\n" if substr($_, length($_), 1) ne "\n";

	    my $doctype = "";
	    if (/(<!DOCTYPE[^>]+\[.*?\]\>\s*)(.*)$/s) {
		$doctype = $1;
		$_ = $2;
	    } elsif (/(<!DOCTYPE[^>]+>\s*)(.*)$/s) {
		$doctype = $1;
		$_ = $2;
	    } else {
		warn "No doctype declaration on $filename?\n";
	    }

	    my $tag = $1 if /^[^<]*<([a-zA-Z0-9]+)/s;

	    open (EX, ">$filename.txt") || die "Can't open: $filename.txt: $!";
	    my $text = $doctype . $_;
	    $text =~ s/\&/\&amp;/sg;
	    $text =~ s/\</\&lt;/sg;
	    $text =~ s/\>/\&gt;/sg;
	    print EX $text;
	    close (EX);

	    if ($format{lc($tag)}) {
		open (EX,">$filename.gen") || die "Can't open: $filename.gen $!";
		print EX $_;
		close (EX);
	    }

	    $done = 0;
	}

	$excount++;
    }

    $excount -= 2; # yes, two. because of the way that loop works.

    my $html = "";

    if ($excount > 0) {
	$html .= "\n<refsect1 condition='ref.examples'><title>Examples</title>\n\n";
	for (my $count = 1; $count <= $excount; $count++) {
	    $html .= "<informalexample role='example-source'>\n";
	    $html .= "<programlisting>&$name.example.$count.txt;</programlisting>\n";
	    $html .= "</informalexample>\n\n";

	    $html .= "<anchor id='ex.os.$name.$count' role='HACK-ex.out.start'/>\n";
	    $html .= "&$name.example.$count.gen;\n";
	    $html .= "<anchor id='ex.oe.$name.$count' role='HACK-ex.out.end'/>\n\n";

	    $html .= "</refsect1>\n\n";
	}
    }

    return $html;
}

sub formatElementFooter {
    my $count = shift;
    my $html = "";

    $html .= "</refentry>\n\n";

    return $html;
}

# ----------------------------------------------------------------------

my $state = 'NONE';
my $depth = 0;
my $col = 0;

sub formatContentModel {
    my $count = shift;
    my $cm = shift;
    my $node = $cm->getFirstChild();
    my $html = "";

    $state = "NONE";
    $depth = 0;
    $col = 0;
    while ($node) {
	if ($node->getNodeType == XML::DOM::ELEMENT_NODE) {
	    $html .= formatContentModelElement($node);
	}
	$node = $node->getNextSibling();
    }

    return $html;
}

sub formatContentModelElement {
    my $node = shift;
    my $html = "";

    if ($node->getNodeType == XML::DOM::ELEMENT_NODE) {
	if ($node->getTagName() eq 'sequence-group') {
	    $html .= &formatCMGroup($node, ",");
	} elsif ($node->getTagName() eq 'or-group') {
	    $html .= &formatCMGroup($node, "|");
	} elsif ($node->getTagName() eq 'and-group') {
	    $html .= &formatCMGroup($node, "&");
	} elsif ($node->getTagName() eq 'element-name') {
	    $html .= &formatCMElement($node);
	} elsif ($node->getTagName() eq 'parament-name') {
	    $html .= &formatCMParament($node);
	} elsif ($node->getTagName() eq 'pcdata') {
	    $html .= &formatCMPCDATA($node);
	} elsif ($node->getTagName() eq 'cdata') {
	    $html .= &formatCMCDATA($node);
	} elsif ($node->getTagName() eq 'rcdata') {
	    $html .= &formatCMRCDATA($node);
	} elsif ($node->getTagName() eq 'empty') {
	    $html .= &formatCMEMPTY($node);
	} else {
	    die "Unexpected node: \"" . $node->getTagName() . "\"\n";
	}
	$node = $node->getNextSibling();
    } else {
	die "Unexpected node type.\n";
    }

    return $html;
}

sub formatCMGroup {
    my $group = shift;
    my $occur = $group->getAttribute('occurrence');
    ;my $sep = shift;
    my $first = 1;
    my $html = "";

    if ($state ne 'NONE' && $state ne 'OPEN') {
	$html .= "\n";
	$html .= " " x $depth if $depth > 0;
	$col = $depth;
	$state = 'NEWLINE';
    }

    $html .= "(";
    $state = 'OPEN';
    $depth++;
    $col++;

    my $node = $group->getFirstChild();
    while ($node) {
	if ($node->getNodeType() == XML::DOM::ELEMENT_NODE) {
	    if (!$first) {
		my $name = $node->getAttribute('name');
		my $occur = $node->getAttribute('occurrence');

		$html .= $sep;
		$col++;

		if ($state ne 'NEWLINE'
		    && ($col + length($name) + length($occur) > 65)) {
		    $html .= "\n";
		    $html .= " " x $depth if $depth > 0;
		    $col = $depth;
		    $state = 'NEWLINE';
		}
	    }
	    $html .= &formatContentModelElement($node);
	    $first = 0;
	}
	$node = $node->getNextSibling();
    }

    $html .= ")";
    $col++;

    if ($occur) {
	$html .= $occur;
	$col++;
    }

    $state = 'CLOSE';
    $depth--;

    return $html;
}

sub formatCMElement {
    my $element = shift;
    my $name = $element->getAttribute('name');
    my $occur = $element->getAttribute('occurrence');
    my $html = "";

    $name = lc($name) if !$option{'case-sensitive'};

    if ($state eq 'CLOSE') {
	$html .= "\n";
	$html .= " " x $depth if $depth > 0;
	$col = $depth;
	$state = 'NEWLINE';
    }

#    $html .= "<link linkend='$baseid.elem.$name'>";
    $html .= "<sgmltag>";
    $html .= $element->getAttribute('name');
    $html .= "</sgmltag>";
#    $html .= "</link>";
    $col += length($name);

    if ($occur) {
	$html .= $occur;
	$col++;
    }

    $state = 'ELEMENT';

    return $html;
}

sub formatCMParament {
    my $element = shift;
    my $name = $element->getAttribute('name');
    my $html = "";

    if ($state eq 'CLOSE') {
	$html .= "\n";
	$html .= " " x $depth if $depth > 0;
	$col = $depth;
	$state = 'NEWLINE';
    }

#    $html .= "<link linkend='$baseid.param.$name'>";
    $html .= "<sgmltag class=\"paramentity\">";
    $html .= $name;
    $html .= "</sgmltag>";
#    $html .= "</link>";
    $col += length($name) + 2;

    $state = 'PARAMENT';

    return $html;
}

sub formatCMPCDATA {
    my $html = "";

    $html .= "#PCDATA";
    $col += 7;
    $state = 'PCDATA';

    return $html;
}

sub formatCMCDATA {
    my $html = "";

    $html .= "CDATA";
    $col += 5;
    $state = 'CDATA';

    return $html;
}

sub formatCMRCDATA {
    my $html = "";

    $html .= "RCDATA";
    $col += 5;
    $state = 'RCDATA';

    return $html;
}

sub formatCMEMPTY {
    my $html = "";

    $html .= "EMPTY";
    $col += 5;
    $state = 'EMPTY';

    return $html;
}

# ======================================================================

sub formatEntity {
    my $count   = shift;
    my $name    = $entities[$count];
    my $entity  = $entities{$name};
    my $html    = "";

    my $textnl, $altnl;

    if ($expanded eq 'expanded') {
	$textnl = $entity->getElementsByTagName("text-expanded");
	$altnl  = $entity->getElementsByTagName("text");
    } else {
	$textnl = $entity->getElementsByTagName("text");
	$altnl  = $entity->getElementsByTagName("text-expanded");
    }

    # Hack; we're appending to a single file, just return the VLE synopsis...
    return &formatEntityVLESynopsis($count, $textnl, $altnl);

    $html .= &formatEntityHeader($count);

    $html .= &formatEntityTitle($count);

    $html .= &formatEntitySynopsis($count, $textnl, $altnl)
	if $option{'synopsis'};

    $html .= &formatEntityAppearsIn($count) if $option{'appears-in'};

    $html .= &formatEntityDescription($count) if $option{'description'};

    $html .= &formatEntityExamples($count) if $option{'examples'};

    $html .= &formatEntityFooter($count);

    return $html;
}

sub formatEntityHeader {
    my $count     = shift;
    my $html      = "";
    my $name      = $entities[$count];

    $html .= "<refentry id=\"$name.parament\">\n";
    $html .= "<!-- Generated by DTDParse version $VERSION -->\n";
    $html .= "<!-- see http://www.sf.net/projects/dtdparse/ -->\n\n";

    return $html;
}

sub formatEntityTitle {
    my $count  = shift;
    my $name   = $entities[$count];
    my $entity = $entities{$name};
    my $type   = $entity->getAttribute("type");
    my $html   = "";

#    $html .= "<![ %" . "$baseid.ms.param.refmeta; [\n";
    $html .= "<refmeta>\n";
    $html .= "<refentrytitle>";
    $html .= $entity->getAttribute('name');
    $html .= "</refentrytitle>\n";

    if ($type eq 'gen') {
	$html .= "<refmiscinfo>General Entity</refmiscinfo>\n";
    } else {
	$html .= "<refmiscinfo>Parameter Entity</refmiscinfo>\n";
    }

    $html .= "</refmeta>\n";
#    $html .= "]]>\n\n";

    $html .= "<refnamediv>\n";
    $html .= "<refname>" . $entity->getAttribute('name') . "</refname>\n";
    $html .= "<refpurpose>";
    $html .= &entityRefpurpose($count);
    $html .= "</refpurpose>\n";
    $html .= "</refnamediv>\n\n";
}

sub formatEntitySynopsis {
    my $count   = shift;
    my $textnl  = shift;
    my $altnl   = shift;
    my $name    = $entities[$count];
    my $entity  = $entities{$name};
    my $html    = "";
    my $type    = $entity->getAttribute("type");
    my $public  = $entity->getAttribute("public");
    my $system  = $entity->getAttribute("system");
    my $text    = "";

    if ($textnl->getLength() > 0) {
	my $textnode = $textnl->item(0);
	my $content = $textnode->getFirstChild();
	if ($content) {
	    $text = $content->getData();
	} else {
	    $text = "";
	}
    }

#    $html .= "<![ %" . "$baseid.ms.param.refsynopsisdiv; [\n";
    $html .= "<refsynopsisdiv>\n";
    $html .= "<informaltable frame='all' role='elemsynop'>\n";
    $html .= "<tgroup cols='3'>\n";
    $html .= "<colspec colnum='1' colname='c1'/>\n";
    $html .= "<colspec colnum='2' colname='c2'/>\n";
    $html .= "<colspec colnum='3' colname='c3'/>\n";
    $html .= "<tbody>\n";

    $html .= "<row rowsep='0' role='cmtitle'>\n";
    $html .= "<entry namest='c1' nameend='c3' align='left'\n";
    $html .= "><emphasis role='bold'>";

    if ($type eq 'gen') {
	$html .= "General Entity";
	$html .= "</emphasis></entry>\n";
	$html .= "</row>\n";
	$html .= "<row rowsep='1' role='cmsynop'>\n";
	$html .= "<entry namest='c1' nameend='c3' align='left'\n";
	$html .= "><synopsis>";

	if ($text =~ /\"/) {
	    $html .= "'$text'\n";
	} else {
	    $html .= "\"$text\"\n";
	}

	$html .= "</synopsis></entry>\n";
	$html .= "</row>\n";
    }

    if ($type eq 'param') {
	if ($public || $system) {
	    $html .= "External Entity";
	    $html .= "</emphasis></entry>\n";
	    $html .= "</row>\n";
	    $html .= "<row rowsep='1' role='cmsynop'>\n";
	    $html .= "<entry namest='c1' nameend='c3' align='left'\n";
	    $html .= ">";

	    $html .= "<para><emphasis role='bold'>Public identifier</emphasis>: $public\n</para>" if $public;
	    $html .= "<para><emphasis role='bold'>System identifier</emphasis>: $system\n</para>" if $system;

	    $html .= "</entry>\n";
	    $html .= "</row>\n";
	} else {
	    $html .= "Parameter Entity\n";
	    $html .= "</emphasis></entry>\n";
	    $html .= "</row>\n";
	    $html .= "<row rowsep='1' role='cmsynop'>\n";
	    $html .= "<entry namest='c1' nameend='c3' align='left'\n";

	    if ($text eq '') {
		$html .= "><para>";
		$html .= "The replacement text for this entity is empty.";
		$html .= "</para>";
	    } else {
		$html .= "><synopsis>";
		$html .= &formatEntitySynopsisContent($text);
		$html .= "</synopsis>";
	    }

	    $html .= "</entry>\n";
	    $html .= "</row>\n";

	    # output the expanded version as well, in the unexpanded case
	    if ($expanded eq 'unexpanded') {
		if ($altnl->getLength() > 0) {
		    my $textnode = $altnl->item(0);
		    my $content = $textnode->getFirstChild();
		    if ($content) {
			$text = $content->getData();
		    } else {
			$text = "";
		    }
		}

		$html .= "<row rowsep='0' role='cmtitle'>\n";
		$html .= "<entry namest='c1' nameend='c3' align='left'\n";
		$html .= "><emphasis role='bold'>";
		$html .= "Parameter Entity (Expanded)\n";
		$html .= "</emphasis></entry>\n";
		$html .= "</row>\n";
		$html .= "<row rowsep='1' role='cmsynop'>\n";
		$html .= "<entry namest='c1' nameend='c3' align='left'\n";

		if ($text eq '') {
		    $html .= "><para>";
		    $html .= "The replacement text for this entity is empty.";
		    $html .= "</para>";
		} else {
		    $html .= "><synopsis>";
		    $html .= &formatEntitySynopsisContent($text);
		    $html .= "</synopsis>";
		}

		$html .= "</entry>\n";
		$html .= "</row>\n";
	    }
	}
    }

    $html .= "</tbody>\n";
    $html .= "</tgroup>\n";
    $html .= "</informaltable>\n";
    $html .= "</refsynopsisdiv>\n\n";

    return $html;
}

sub formatEntityVLESynopsis {
    my $count   = shift;
    my $textnl  = shift;
    my $altnl   = shift;
    my $name    = $entities[$count];
    my $entity  = $entities{$name};
    my $html    = "";
    my $type    = $entity->getAttribute("type");
    my $public  = $entity->getAttribute("public");
    my $system  = $entity->getAttribute("system");
    my $text    = "";
    my %attr    = ();

    if ($textnl->getLength() > 0) {
	my $textnode = $textnl->item(0);
	my $content = $textnode->getFirstChild();
	if ($content) {
	    $text = $content->getData();
	} else {
	    $text = "";
	}
    }

    $html .= "<informaltable frame='all' role='elemsynop'>\n";
    $html .= "<tgroup cols='3'>\n";
    $html .= "<colspec colnum='1' colname='c1'/>\n";
    $html .= "<colspec colnum='2' colname='c2'/>\n";
    $html .= "<colspec colnum='3' colname='c3'/>\n";
    $html .= "<tbody>\n";

    $html .= "<row rowsep='0' role='vle-cmtitle'>\n";
    $html .= "<entry namest='c1' nameend='c3' align='left'\n";
    $html .= "><emphasis role='bold'>";

    if ($type eq 'gen') {
	$html .= "General Entity";
	$html .= "</emphasis></entry>\n";
	$html .= "</row>\n";
	$html .= "<row rowsep='1' role='cmsynop'>\n";
	$html .= "<entry namest='c1' nameend='c3' align='left'\n";
	$html .= "><synopsis>";

	if ($text =~ /\"/) {
	    $html .= "'$text'\n";
	} else {
	    $html .= "\"$text\"\n";
	}

	$html .= "</synopsis></entry>\n";
	$html .= "</row>\n";
    }

    if ($type eq 'param') {
	if ($public || $system) {
	    $html .= "External Entity";
	    $html .= "</emphasis></entry>\n";
	    $html .= "</row>\n";
	    $html .= "<row rowsep='1' role='cmsynop'>\n";
	    $html .= "<entry namest='c1' nameend='c3' align='left'\n";
	    $html .= ">";

	    $html .= "<para><emphasis role='bold'>Public identifier</emphasis>: $public\n</para>" if $public;
	    $html .= "<para><emphasis role='bold'>System identifier</emphasis>: $system\n</para>" if $system;

	    $html .= "</entry>\n";
	    $html .= "</row>\n";
	} else {
	    $html .= "Parameter Entity\n";
	    $html .= "</emphasis></entry>\n";
	    $html .= "</row>\n";

	    my $temptext = $text;
	    $temptext =~ s/--.*?--//sg;

	    if (($name =~ /\.attrib$/
		 || $name eq 'bodyatt'
		 || $name eq 'secur'
		 || $name eq 'tbl.table.att'
		 || $name eq 'tbl.tgroup.att')
		&& ($temptext ne "")
		&& ($expanded eq 'expanded')) {
		my $table;
		($table, %attr) = &formatEntityAttributeContent($temptext);
		$html .= $table;
	    } else {
		$html .= "<row rowsep='1' role='cmsynop'>\n";
		$html .= "<entry namest='c1' nameend='c3' align='left'\n";

		if ($temptext eq '') {
		    $html .= "><para>";
		    $html .= "The replacement text for this entity is empty.";
		    $html .= "</para>";
		} else {
		    $html .= "><synopsis>";
		    $html .= &formatEntitySynopsisContent($text);
		    $html .= "</synopsis>";
		}

		$html .= "</entry>\n";
		$html .= "</row>\n";
	    }

	    # output the expanded version as well, in the unexpanded case
	    if ($expanded eq 'unexpanded') {
		if ($altnl->getLength() > 0) {
		    my $textnode = $altnl->item(0);
		    my $content = $textnode->getFirstChild();
		    if ($content) {
			$text = $content->getData();
		    } else {
			$text = "";
		    }
		}

		$html .= "<row rowsep='0' role='cmtitle'>\n";
		$html .= "<entry namest='c1' nameend='c3' align='left'\n";
		$html .= "><emphasis role='bold'>";
		$html .= "Parameter Entity (Expanded)\n";
		$html .= "</emphasis></entry>\n";
		$html .= "</row>\n";

		my $temptext = $text;
		$temptext =~ s/--.*?--//sg;

		$html .= "<row rowsep='1' role='cmsynop'>\n";
		$html .= "<entry namest='c1' nameend='c3' align='left'\n";

		if ($temptext eq '') {
		    $html .= "><para>";
		    $html .= "The replacement text for this entity is empty.";
		    $html .= "</para>";
		} else {
		    $html .= "><synopsis>";
		    $html .= &formatEntitySynopsisContent($text);
		    $html .= "</synopsis>";
		}

		$html .= "</entry>\n";
		$html .= "</row>\n";
	    }
	}
    }

    $html .= &formatEntityVLEAppearsIn($name);

    $html .= "</tbody>\n";
    $html .= "</tgroup>\n";
    $html .= "</informaltable>\n";

# On further consideration, don't do this. Let users look at the individual
# elements for attribute description.
#    if (%attr) {
#	$html .= &formatEntityAttributeDesc($name, %attr);
#    }

    return $html;
}

sub formatEntityAttributeContent {
    my $text = shift;
    my $html = "";
    my %attrs = ();
    my %cmnatt  = ('id' => 0,
		   'role' => 0,
		   'lang' => 0,
		   'remap'=> 0,
		   'xreflabel' => 0,
		   'revisionflag' => 0,
		   'arch' => 0,
		   'conformance' => 0,
		   'os' => 0,
		   'revision' => 0,
		   'userlevel' => 0,
		   'vendor' => 0,
		   'security' => 0,
		   'condition' => 0);

    # This function is only called if $text is not empty.
    # Interpret it as a well-formed section of an attlist decl
    $text =~ s/--.*?--//sg;
#    $html .= "<!-- $text -->\n";

    $html .= "<row rowsep='1' role='attrheader'>\n";
    $html .= "<entry role='th'><para><emphasis role='bold'>Name</emphasis></para></entry>\n";
    $html .= "<entry role='th'><para><emphasis role='bold'>Type</emphasis></para></entry>\n";
    $html .= "<entry role='th'><para><emphasis role='bold'>Default</emphasis></para></entry>\n";
    $html .= "</row>\n";

    $text =~ s/\n/ /sg; # make it all one line..

    while ($text !~ /^\s*$/) {
	$html .= "<row role='attr'>\n";

	$text =~ /^\s*(\S+)(.*?)$/;
	my $token = $1;
	$text = $2;

	$attrs{$token} = 1 if !defined($cmnatt{lc($token)});

	$html .= "<entry align='left' valign='top'>$token</entry>\n";

	$text =~ /^\s*(\S+)(.*?)$/;
	$token = $1;
	$text = $2;

	if ($token =~ /NOTATION/
	   || $token =~ /^\s*\(/) {
	    $html .= "<entry align='left' valign='top'><para>";
	    if ($token =~ /NOTATION/) {
		$html .= "<emphasis>Enumerated notation:</emphasis>";
		$text =~ /^\s*(\S+)\s+(.*)$/;
		$token = $1;
		$text = $2;
	    } else {
		$html .= "<emphasis>Enumerated:</emphasis>";
	    }
	    $html .= "</para><simplelist>";

	    if ($token =~ /\)\s*$/) {
		# we got the whole thing...
	    } else {
		$text =~ /^(.*?)\)/;
		$token .= $1;
		$text = $'; # '
	    }

	    $token =~ s/[\(\)\|]/ /sg;
	    $token =~ s/^\s*//sg;
	    $token =~ s/\s*$//sg;
	    my @members = split(/\s+/, $token);
	    foreach my $member (@members) {
		$html .= "<member>$member</member>\n";
	    }

	    $html .= "</simplelist></entry>\n";
	} else {
	    $html .= "<entry align='left' valign='top'>$token</entry>\n";
	}

	$text =~ /^\s*(\S+)(.*?)$/s;
	$token = $1;
	$text = $2;

	if ($token eq '#IMPLIED') {
	    $token = "<emphasis>None</emphasis>";
	} elsif ($token eq '#REQUIRED') {
	    $token = "<emphasis>Required</emphasis>";
	} elsif ($token eq '#CONREF') {
	    $token = "<emphasis>Content reference</emphasis>";
	}

	$html .= "<entry align='left' valign='top'>$token</entry>\n";
	$html .= "</row>\n";
    }

    return ($html, %attrs);
}

sub formatEntityAttributeDesc {
    my $name = shift;
    my %attrs = @_;
    my $html = "";

    # find an element that uses entity %name
    if (!defined($EAPPEARSIN{"%$name"})) {
	print "No EA for %$name\n";
	return $html;
    }

    my %elem = %{$EAPPEARSIN{"%$name"}};
    my @elems = keys %elem;
    my $elemname = $elems[0];

    $html .= "<para><emphasis role='bold'>Attribute descriptions:";
    $html .= "</emphasis></para>\n";

    $html .= "<variablelist>\n";
    foreach my $attr (sort keys %attrs) {
	$html .= "<varlistentry><term>$attr</term>\n";
	$html .= "<listitem>\n";
	$html .= "&attr." . lc($attr) . ".$elemname;\n";
	$html .= "</listitem>\n";
	$html .= "</varlistentry>\n";
    }
    $html .= "</variablelist>\n";

    return $html;
}

sub formatEntityVLEAppearsIn {
    my $name = shift;
    my $html = "";

    my %appears = %{$EAPPEARSIN{"%$name"}} if exists $EAPPEARSIN{"%$name"};

    if (%appears) {
	my @ents = sort { uc($a) cmp uc($b) } keys %appears;

	$html .= "<row rowsep='0' role='vle-petitle'>\n";
	$html .= "<entry namest='c1' nameend='c3' align='left'\n";
	$html .= "><emphasis role='bold'>%$name; appears in:</emphasis>";
	$html .= "</entry>\n";
	$html .= "</row>\n";

	while (@ents) {
	    $html .= "<row rowsep='0' role='vle-pe'>\n";

	    for (my $count = 0; $count < 3; $count++) {
		my $name = shift @ents;
		if ($name) {
		    my $elem = $elements{$name};
		    die "Cannot find element $name\n" if !$elem;
		    $html .= "<entry colsep='0'>";
		    $html .= "<sgmltag>";
		    $html .= $elem->getAttribute('name');
		    $html .= "</sgmltag>";
		    $html .= "</entry>\n";
		} else {
		    $html .= "<entry colsep='0'></entry>\n";
		}
	    }

	    $html .= "</row>\n";
	}
    }

    return $html;
}

sub formatEntitySynopsisContent {
    my $text = shift;
    my $html = "";

    # OK, it's a parameter entity. Now, does it look like a
    # content model fragment

    my $cmfragment = &cmFragment($text);

    while ($text =~ /\%?[-a-z0-9.:_]+;?/is) {
	my $pre = $`;
	my $match = $&;
	$text = $'; # '

	$html .= $pre;

	if ($pre =~ /\#$/) {
	    # if it comes after a '#', it's a keyword...
	    $html .= $match;
	    next;
	}

	if ($match =~ /\%([^;]+);?/) {
	    $name = $1;
	    if (exists $entities{$name}) {
#		$html .= "<link linkend=\"$baseid.param.$name\">";
		$html .= $match;
#		$html .= "</link>";
	    } else {
		$html .= $match;
	    }
	} elsif ($cmfragment) {
	    $name = $match;
	    $name = lc($name) if !$option{'case-sensitive'};
	    if (exists $elements{$name}) {
		my $linkend = "$baseid.elem.$name";
#		$html .= "<link linkend=\"$linkend\">";
		$html .= "$match";
#		$html .= "</link>";
	    } else {
		$html .= $match;
	    }
	} else {
	    $html .= $match;
	}
    }

    return $html;
}

sub formatEntityAppearsIn {
    my $count = shift;
    my $html = "";
    my $entityname = $entities[$count];
    my $entity = $entities{$entityname};
    my %appears = ();
    my $key = "%$entityname";

    if (exists $APPEARSIN{$key}) {
	%appears = %{$APPEARSIN{$key}};
	my @ents = sort { uc($a) cmp uc($b) } keys %appears;

#	$html .= "<![ %" . "$baseid.ms.param.refsynopsisdiv.pe; [\n";
	$html .= "<refsect1 condition='ref.rsdiv.pe'><title>Parameter Entities</title>\n";
	$html .= "<para>The following parameter entities contain ";
	$html .= "<sgmltag class=\"paramentity\">";
	$html .= $entity->getAttribute('name');
	$html .= "</sgmltag>:\n";
	$html .= "<simplelist type='inline'>\n";

	for (my $count = 0; $count <= $#ents; $count++) {
	    my $entity = $entities{$ents[$count]};
	    $html .= "<member>";
#	    $html .= "<link linkend=\"$baseid.";
#	    $html .= $entity->getAttribute('type') . ".";
#	    $html .= $entity->getAttribute('name') . "\">";
	    $html .= "<sgmltag class=\"paramentity\">";
	    $html .= $entity->getAttribute('name');
	    $html .= "</sgmltag>";
#	    $html .= "</link>";
	    $html .= "</member>\n";
	}
	$html .= "</simplelist></para>\n";
	$html .= "</refsect1>\n";
#	$html .= "]]>\n\n";
    }

    my $refsect = "refsect1";
    if (exists($EAPPEARSIN{$key}) && exists($XAPPEARSIN{$key})) {
	$refsect = "refsect2";
#	$html .= "<![ %" . "$baseid.ms.param.refsynopsisdiv.pe; [\n";
	$html .= "<refsect1 condition='ref.rsdiv.pe'><title>Elements</title>\n";
	$html .= "<para>Some element content models are effected both\n";
	$html .= "directly and indirectly by the\n";
	$html .= "<sgmltag class=\"paramentity\">";
	$html .= $entity->getAttribute('name');
	$html .= "</sgmltag> parameter entity.</para>\n";
    }

    if (exists($EAPPEARSIN{$key})) {
	%appears = %{$EAPPEARSIN{$key}};

	my @elem = sort { uc($a) cmp uc($b) } keys %appears;

	if (exists($EAPPEARSIN{$key}) && exists($XAPPEARSIN{$key})) {
	    $html .= "<refsect2><title>Directly Effected</title>\n";

#	    print "\n", $entity->getAttribute('name'), " ($key):\n";
#	    print "\t", $#elem, "\n";
#	    foreach my $foo (keys %{$EAPPEARSIN{$key}}) {
#		print "\t'$foo'='", $EAPPEARSIN{$key}->{$foo}, "'\n";
#	    }
	} else {
	    $html .= "<refsect1><title>Elements</title>\n";
	}

	$html .= "<para>The content models of the following elements\n";
	$html .= "contain ";
	$html .= "<sgmltag class=\"paramentity\">";
	$html .= $entity->getAttribute('name');
	$html .= "</sgmltag> directly:\n";
	$html .= "<simplelist type='inline'>\n";

	for (my $count = 0; $count <= $#elem; $count++) {
	    my $element = $elements{$elem[$count]};
	    $html .= "<member>";
#	    $html .= "<link linkend=\"$baseid.elem.";
#	    $html .= $elem[$count] . "\">";
	    $html .= "<sgmltag>";
	    $html .= $element->getAttribute('name');
	    $html .= "</sgmltag>";
#	    $html .= "</link>";
	    $html .= "</member>\n";
	}
	$html .= "</simplelist></para>\n";
	$html .= "</$refsect>\n";
    }

    if (exists $XAPPEARSIN{$key}) {
	%appears = %{$XAPPEARSIN{$key}};

	my @elem = sort { uc($a) cmp uc($b) } keys %appears;

	if (exists($EAPPEARSIN{$key}) && exists($XAPPEARSIN{$key})) {
	    $html .= "<refsect2><title>Indirectly Effected</title>\n";
	} else {
	    $html .= "<refsect1><title>Elements</title>\n";
	}

	$html .= "<para>The content models of the following elements\n";
	$html .= "contain ";
	$html .= "<sgmltag class=\"paramentity\">";
	$html .= $entity->getAttribute('name');
	$html .= "</sgmltag> indirectly:\n";
	$html .= "<simplelist type='inline'>\n";

	for (my $count = 0; $count <= $#elem; $count++) {
	    my $element = $elements{$elem[$count]};
	    $html .= "<member>";
#	    $html .= "<link linkend=\"$baseid.elem.";
#	    $html .= $elem[$count] . "\">";
	    $html .= "<sgmltag>";
	    $html .= $element->getAttribute('name');
	    $html .= "</sgmltag>";
#	    $html .= "</link>";
	    $html .= "</member>\n";
	}
	$html .= "</simplelist></para>\n";
	$html .= "</$refsect>\n";
    }

    $html .= "</refsect1>\n"
	if (exists($EAPPEARSIN{$key}) && exists($XAPPEARSIN{$key}));

#    $html .= "]]>\n\n";

    return $html;
}

sub formatEntityDescription {
    my $count   = shift;
    my $name    = $entities[$count];
    my $entity  = $entities{$name};
    my $desc    = &entityDescription($count);
    my $html    = "";

    return "" if !defined($desc);

    $html .= "<refsect1><title>Description</title>\n";
    $html .= $desc;
    $html .= "</refsect1>\n\n";

    return $html;
}

sub formatEntityExamples {
    my $count   = shift;
    my $name    = $entities[$count];
    my $entity  = $entities{$name};

    return "";
}

sub formatEntityFooter {
    my $count = shift;
    my $html = "";

    $html .= "</refentry>\n";

    return $html;
}

# ======================================================================

sub formatNotation {
    my $count   = shift;
    my $html    = "";

    my $name    = $notations[$count];
    my $element = $notations{$name};

    $html .= &formatNotationHeader($count);

    $html .= &formatNotationTitle($count);

    if ($option{'synopsis'}) {
	$html .= &formatNotationSynopsis($count);
    }

    $html .= &formatNotationDescription($count)
        if $option{'description'};

    $html .= &formatNotationExamples($count) if $option{'examples'};

    $html .= &formatNotationFooter($count);
}

sub formatNotationHeader {
    my $count     = shift;
    my $html      = "";
    my $name      = $notations[$count];

    $html .= "<refentry id=\"$name.notation\">\n";
    $html .= "<!-- Generated by DTDParse version $VERSION -->\n";
    $html .= "<!-- see http://www.sf.net/projects/dtdparse/ -->\n\n";

    return $html;
}

sub formatNotationTitle {
    my $count    = shift;
    my $name     = $notations[$count];
    my $notation = $notations{$name};
    my $html = "";

    $html .= "<refmeta>\n";
    $html .= "<refentrytitle>";
    $html .= $notation->getAttribute('name');
    $html .= "</refentrytitle>\n";
    $html .= "<refmiscinfo>Notation</refmiscinfo>\n";
    $html .= "</refmeta>\n\n";

    $html .= "<refnamediv>\n";
    $html .= "<refname>" . $notation->getAttribute('name') . "</refname>\n";
    $html .= "<refpurpose>";
    $html .= &notationRefpurpose($count);
    $html .= "</refpurpose>\n";
    $html .= "</refnamediv>\n\n";
}

sub formatNotationSynopsis {
    my $count    = shift;
    my $name     = $notations[$count];
    my $notation = $notations{$name};
    my $html    = "";
    my $public  = $notation->getAttribute("public");
    my $system  = $notation->getAttribute("system");

    $html .= "<refsynopsisdiv>\n";

    if ($public) {
	$html .= "<para>\nPublic identifier:\n";
	$html .= "<emphasis>$public</emphasis>.";
	$html .= "</para>\n\n";
    }

    if ($system) {
	$html .= "<para>\nSystem identifier:\n";
	$html .= "<emphasis>$system</emphasis>.";
	$html .= "</para>\n\n";
    }

    if (!$public && !$system) {
	$html .= "<para>\n<quote>System</quote> specified\n";
	$html .= "without a system identifier.";
	$html .= "</para>\n\n";
    }

    return $html;
}

sub formatNotationDescription {
    my $count    = shift;
    my $name     = $notations[$count];
    my $notation = $notations{$name};
    my $desc     = &notationDescription($count);
    my $html     = "";

    return "" if !defined($desc);

    $html .= "<refsect1><title>Description</title>\n";
    $html .= $desc;
    $html .= "</refsect1>\n\n";

    return $html;
}

sub formatNotationExamples {
    my $count   = shift;
    my $name    = $notations[$count];
    my $element = $notations{$name};

    return "";
}

sub formatNotationFooter {
    my $count = shift;
    my $html = "";

    $html .= "</refentry>\n";

    return $html;
}

# ======================================================================

sub createDir {
    my $dir = shift;
    my $mode = shift;
    # nop
}

sub checkDir {
    my $dir = shift;
    # nop
}

sub writeElement {
    my $count = shift;
    my $path = shift;
    my $basename = shift;
    my $fileext = shift;
    my $html = shift;
    my $name      = $elements[$count];
    my $element   = $elements{$name};

    my $dir = $option{'base-dir'} . "/elements/$basename";
    if (! -d $dir) {
	mkdir($dir, 0755);
    }

    # DON'T OVERWRITE THIS FILE ANYMORE!
    if (! -f "$dir/refentry$fileext") {
	open (F, ">$dir/refentry$fileext");
	print F $html;
	close (F);
    }

    open (F, ">$dir/entities.e.ent");
    print F "<!ENTITY $name.synopsis.gen SYSTEM \"synopsis.e.gen\">\n"
	if -f "$dir/synopsis.e.gen";

    foreach my $f ("children", "parents", "seealso", "example.seealso") {
	print F "<!ENTITY $name.$f.gen SYSTEM \"$f.gen\">\n"
	    if -f "$dir/$f.gen";
    }

    for (my $count = 1; -f "$dir/example.$count.gen"; $count++) {
	print F "<!ENTITY $name.example.$count.gen SYSTEM \"example.$count.gen\">\n";
    }

    for (my $count = 1; -f "$dir/example.$count.txt"; $count++) {
	print F "<!ENTITY $name.example.$count.txt SYSTEM \"example.$count.txt\">\n";
    }

    close (F);

    open (F, ">$dir/entities.u.ent");
    print F "<!ENTITY $name.synopsis.gen SYSTEM \"synopsis.u.gen\">\n"
	if -f "$dir/synopsis.u.gen";

    foreach my $f ("children", "parents", "seealso", "example.seealso") {
	print F "<!ENTITY $name.$f.gen SYSTEM \"$f.gen\">\n"
	    if -f "$dir/$f.gen";
    }

    for (my $count = 1; -f "$dir/example.$count.gen"; $count++) {
	print F "<!ENTITY $name.example.$count.gen SYSTEM \"example.$count.gen\">\n";
    }

    for (my $count = 1; -f "$dir/example.$count.txt"; $count++) {
	print F "<!ENTITY $name.example.$count.txt SYSTEM \"example.$count.txt\">\n";
    }

    close (F);
}

sub writeEntity {
    my $count = shift;
    my $path = shift;
    my $basename = shift;
    my $fileext = shift;
    my $html = shift;
    my $name    = $entities[$count];
    my $entity  = $entities{$name};
    my $class   = $entity_classes{$name};

    # Hack; actually append a subset of the entity to a single file...

    if (!defined($class)) {
	for (my $cnt = 0; $cnt <= $#entity_classes; $cnt++) {
	    if ($name =~ /$entity_pats[$cnt]/) {
		$class = $entity_classes[$cnt];
		last;
	    }
	}
    }

    if ($class ne '') {
	my $bdir   = $option{'base-dir'};
	my $edir   = $config{$expanded . '-entity-dir'};
	my $ext    = "e.gen";
	my $entdir = "$bdir/$edir";
	my $bid    = $option{'base-id'};
	local *F;

	if ($expanded ne 'expanded') {
	    $ext = "u.gen";
	}

	if ($class ne 'isochars') {
	    open (F, ">>$entdir/$class.$ext");
	    print F "<refsect2 id=\"$name.parament\">";
	    print F "<title>%$name;</title>\n";
	    print F $html;
	    print F "</refsect2>\n\n";
	    close (F);
	}
    } else {
	print "No class defined for entity $name\n";
    }
}

sub writeNotation {
    my $count = shift;
    my $path = shift;
    my $basename = shift;
    my $fileext = shift;
    my $html = shift;

    # No, we're not writing individual notation pages.
    # But thanks for asking.
}

sub writeElementIndexes {
    my $basedir   = shift;
    my $title     = $dtd->getDocumentElement->getAttribute('title');
    my ($entfile, $sgmfile, $sysdir);
    local (*F, $_);

    return;

    $entfile = $basedir . "/" . $config{$expanded . "-element-index"} . ".ent";
    $sgmfile = $basedir . "/" . $config{$expanded . "-element-index"} . ".sgm";
    $sysdir  = $config{$expanded . "-element-dir"};

    open (F, ">$entfile");
    foreach $name (@elements) {
	my $basename = $ELEMBASE{$name};
	print F "<!ENTITY $baseid.elem.$name ";
	print F "SYSTEM \"$sysdir/$basename$fileext\">\n";
	print F "<!ENTITY $baseid.purp.elem.$name \"purpose\">\n";
    }
    close (F);

    open (F, ">$sgmfile");
    print F "<reference><title>$title Element Reference</title>\n";
    foreach $name (@elements) {
	print F "&$baseid.elem.$name;\n";
    }
    print F "</reference>\n";
    close (F);
}

sub writeEntityIndexes {
    my $basedir   = shift;
    my $title     = $dtd->getDocumentElement->getAttribute('title');
    my ($entfile, $sgmfile, $sysdir);
    local (*F, $_);

    return;

    $entfile = $basedir . "/" . $config{$expanded . "-entity-index"} . ".ent";
    $sgmfile = $basedir . "/" . $config{$expanded . "-entity-index"} . ".sgm";
    $sysdir  = $config{$expanded . "-entity-dir"};

    open (F, ">$entfile");
    foreach $name (@entities) {
	my $entity = $entities{$name};
	my $basename = $ENTBASE{$name};
	print F "<!ENTITY $baseid.param.$name ";
	print F "SYSTEM \"$sysdir/$basename$fileext\">\n";
	print F "<!ENTITY $baseid.purp.", $entity->getAttribute('type'), ".$name \"purpose\">\n";
    }
    close (F);

    open (F, ">$sgmfile");
    print F "<reference><title>$title Entity Reference</title>\n";
    foreach $name (@entities) {
	print F "&$baseid.param.$name;\n";
    }
    print F "</reference>\n";
    close (F);
}

sub writeNotationIndexes {
    my $basedir   = shift;
    my $basedir = $option{'base-dir'};
    my $path = $basedir . "/" . $config{'notation-dir'};
    local (*F, $_);

    # hack. write the notation .gen file instead of a proper index

    $notnfile = "$path/notations.gen";

    open (F, ">$notnfile");

    foreach $name (sort @notations) {
	$notation = $notations{$name};

	print F "<varlistentry id=\"$name.notation\">\n";
	print F "<term>$name</term>\n";
	print F "<listitem>\n";

	print F "<para>Public id: ";
	if ($notation->getAttribute('public') ne '') {
	    print F "<literal>";
	    print F $notation->getAttribute('public');
	    print F "</literal>\n";
	} else {
	    print F "<emphasis>undefined</emphasis>\n";
	}

	print F "</para>\n";

	print F "<para>System id: ";

	if ($notation->getAttribute('system') ne '') {
	    print F "<literal>";
	    print F $notation->getAttribute('system');
	    print F "</literal>\n";
	} else {
	    print F "<emphasis>undefined</emphasis>\n";
	}

	print F "</para>\n";

	print F "</listitem>\n";
	print F "</varlistentry>\n";
    }
    close (F);
}

sub writeIndex {
    my $basedir   = shift;
    my $title     = $dtd->getDocumentElement->getAttribute('title');
    my $entfile   = $config{"expanded-entity-index"};
    my $elemfile  = $config{"expanded-element-index"};
    my $notfile   = $config{"notation-index"};
    my $root = $dtd->getDocumentElement();
    my $elements = $root->getElementsByTagName('element');
    my $entities = $root->getElementsByTagName('entity');
    my $notations = $root->getElementsByTagName('notation');
    my $elemcount = $elements->getLength();
    my $entcount = $entities->getLength();
    my $notcount = $notations->getLength();
    local (*F, $_);

    return;

    open (F, ">" . $basedir . "/" . $config{'home'});

    print F "<HTML>\n<HEAD>\n<TITLE>$title</TITLE>\n";
    print F "</HEAD>\n<BODY>\n";

    print F "<H1>$title</h1>\n";

    print F "[<A HREF=\"$elemfile\">Elements</A>]\n";
    print F "[<A HREF=\"$entfile\">Entities</A>]\n";
    print F "[<A HREF=\"$notfile\">Notations</A>]\n";

    print F "<HR>\n";

    print F "<P>";
    print F "The $title ";
    print F "DTD " if $title !~ / DTD$/i;
    print F "is composed of $elemcount elements, ";

    if ($entcount == 0) {
	print F "no entities, ";
    } elsif ($entcount == 1) {
	print F "1 entity, ";
    } else {
	print F "$entcount entities, ";
    }

    print F "and ";

    if ($notcount == 0) {
	print F "no notations.\n";
    } elsif ($notcount == 1) {
	print F "1 notation.\n";
    } else {
	print F "$notcount notations.\n";
    }

    my %etypes = ();
    for (my $count = 0; $count < $entities->getLength(); $count++) {
	my $ent = $entities->item($count);
	my $type = &entityType($ent);
	$etypes{$type} = 0 if !exists($etypes{$type});
	$etypes{$type}++;
    }

    print F "<UL COMPACT>\n";
    print F "<LI>$elemcount elements\n";
    print F "<LI>$entcount ", $entcount == 1 ? "entity" : "entities\n";

    print F "<UL COMPACT>\n";
    print F ("<LI>", $etypes{'param'}, " parameter ",
	     $etypes{'param'} == 1 ? "entity" : "entities", "\n")
	if $etypes{'param'} > 0;
    print F ("<LI>", $etypes{'paramext'}, " external ",
	     $etypes{'paramext'} == 1 ? "entity" : "entities", "\n")
	if $etypes{'paramext'} > 0;
    print F ("<LI>", $etypes{'sdata'}, " SDATA ",
	     $etypes{'sdata'} == 1 ? "entity" : "entities", "\n")
	if $etypes{'sdata'} > 0;
    print F ("<LI>", $etypes{'charent'}, " character ",
	     $etypes{'charent'} == 1 ? "entity" : "entities", "\n")
	if $etypes{'charent'} > 0;
    print F ("<LI>", $etypes{'msparam'}, " Marked section ",
	     $etypes{'msparam'} == 1 ? "entity" : "entities", "\n")
	if $etypes{'msparam'} > 0;
    print F ("<LI>", $etypes{'gen'}, " general ",
	     $etypes{'gen'} == 1 ? "entity" : "entities", "\n")
	if $etypes{'gen'} > 0;
    print F "</UL>\n";

    print F "<LI>$notcount ", $notcount == 1 ? "notation" : "notations\n";
    print F "</UL>\n";

    print F "It ";
    if ($root->getAttribute('public-id')) {
	print F "has the public identifier \"";
	print F $root->getAttribute('public-id');
	print F "\" and ";
    }

    print F "claims to be an ";
    if ($root->getAttribute('xml')) {
	print F "XML";
    } else {
	print F "SGML";
    }
    print F " DTD. Element ";
    print F "and notation " if $notcount > 0;
    print F "names are ";
    print F "not " if $root->getAttribute('namecase-general');
    print F "case sensitive. Entity names are ";
    print F "not " if $root->getAttribute('namecase-entity');
    print F "case sensitive.\n";
    print F "</P>\n";

    print F "<HR>\n";
    print F "HTML Presentation of ";
    print F $dtd->getDocumentElement->getAttribute('title');
    print F " by <A HREF=\"http://www.sf.net/projects/dtdparse/\">";
    print F "DTDParse</A>\n";
    print F "</BODY>\n";
    print F "</HTML>\n";

    close (F);
}

1;
