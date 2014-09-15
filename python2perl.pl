#!/usr/bin/perl -w

$file = $ARGV[0];

open F, "<$file";


while ($line = <F>) {

	#if the line ends with python and is the starting line
	if ($line =~ /#!\/usr\/bin\/python$/) {
		$line =~ s/python$/perl -w/;
	}

	#if the line is an empty line remove it
	if ($line =~ /^(\n)$/) {
		chomp $line;
	}

	#if the line starts with a print statement
	if ($line =~ /^print/) {
		if ($line =~ /^print \"/) {
			$line =~ s/\"\n/\"/;
			$line =~ s/(\")$/\", \"\\n\"\;\n/;
		} else {
			$line =~ s/^print /print \"\$/;
			$line =~ s/\n/\\n\"\;\n/;
		}
	}

	#if your line contains an assignment statement
	if ($line =~ /\=/) {

		if ($line =~ /\-[0-9]/) {
			$line =~ s/\-/\- /g;
		}

		# if the line ends in numbers then add a $ sign to the variable name & the semi colon
		# otherwise just add the semi colon
		if ($line =~ /[0-9]$/) {
			$line =~ s/^/\$/;
			$line =~ s/\n/\;\n/;
		} else {
			$line =~ s/^/\$/;
			$line =~ s/\=/\=\"/;
			$line =~ s/\n/\"\;\n/;
		}
	}

	#print the line
	print "$line";
}