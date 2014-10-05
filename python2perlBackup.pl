#!/usr/bin/perl -w

$file = $ARGV[0];

open F, "<$file";

#stores the number of lines in the file (also used for array indexing)
$numLines = 0;

#place the file line bu line into an array
while ($lineOne = <F>) {
	$pythonFile[$numLines++] = $lineOne;
}


foreach $line (@pythonFile) {

	#if the line ends with python and is the starting line
	if ($line =~ /#!\/usr\/bin\/python$/) {
		$line =~ s/python$/perl -w/;
	}

	#if the line is an empty line remove it
	if ($line =~ /^(\n)$/) {
		chomp $line;
	}

	#if the line is a while loop
	if ($line =~ /^while/) {

		#if its an inline while loop
		if ($line =~ /: [a-zA-Z0-9]/) {

			#if the inline loop has more than 2 operations
			if ($line =~ /\;/) {
				# body...

			} else {
				#add a variable $ and a new line followed by the appropriate indentation
				$line =~ s/^while /while \(\$/;
				$line =~ s/:(\s)*/\) \{\n    /;

				#if the line contains subtraction add a space
				if ($line =~ /\-[0-9]/) {
					$line =~ s/\-/\- /g;
				}

				#if the line contains addition add a space
				if ($line =~ /\+[0-9]/) {
					$line =~ s/\+/\+ /g;
				}
					
				#if the line contains multiplication add a space
				if ($line =~ /\*[0-9]/) {
					$line =~ s/\*/\* /g;
				}
					
				#if the line contains division add a space
				if ($line =~ /\/[0-9]/) {
					$line =~ s/\//\/ /g;
				}

				#if the line contains an expression after the 4 spaces since it is an inline if statement
				if ($line =~ /\n( ){4}[a-zA-Z]/) {
					$line =~ s/\n( ){4}/\n    \$/;

					#if the line contains operation followed by a variable name:
					if ($line =~ /\- [a-zA-Z]/) {
						$line =~ s/\- /\- \$/g;
					}

					if ($line =~ /\+ [a-zA-Z]/) {
						$line =~ s/\+ /\+ \$/g;
					}

					if ($line =~ /\* [a-zA-Z]/) {
						$line =~ s/\* /\* \$/g;
					}

					if ($line =~ /\/ [a-zA-Z]/) {
						$line =~ s/\/ /\/ \$/g;
					}

					if ($line =~ /\ = [a-zA-Z]/) {
						$line =~ s/ \= / \= \$/g;	
					}

					# if the line ends in numbers then add a $ sign to the variable name & the semi colon
					# otherwise just add the semi colon
					if ($line =~ /[a-zA-Z0-9]$/) {
						$line =~ s/\n$/\;\n\}\n/;
					}
				}
			}
		} else {

		}
	} else {
		#if the line is an if statement
		if ($line =~ /^if/) {		
			
			#if the line is an inline if statement
			if ($line =~ /: [a-zA-Z0-9]/) {
				#add a variable $ and a new line followed by the appropriate indentation
				$line =~ s/^if /if \(\$/;
				$line =~ s/:(\s)*/\) \{\n    /;

				#if the line contains subtraction add a space
				if ($line =~ /\-[0-9]/) {
					$line =~ s/\-/\- /g;
				}

				#if the line contains addition add a space
				if ($line =~ /\+[0-9]/) {
					$line =~ s/\+/\+ /g;
				}
					
				#if the line contains multiplication add a space
				if ($line =~ /\*[0-9]/) {
					$line =~ s/\*/\* /g;
				}
					
				#if the line contains division add a space
				if ($line =~ /\/[0-9]/) {
					$line =~ s/\//\/ /g;
				}

				#if the line contains an expression after the 4 spaces since it is an inline if statement
				if ($line =~ /\n( ){4}[a-zA-Z]/) {
					$line =~ s/\n( ){4}/\n    \$/;

					#if the line contains operation followed by a variable name:
					if ($line =~ /\- [a-zA-Z]/) {
						$line =~ s/\- /\- \$/g;
					}

					if ($line =~ /\+ [a-zA-Z]/) {
						$line =~ s/\+ /\+ \$/g;
					}

					if ($line =~ /\* [a-zA-Z]/) {
						$line =~ s/\* /\* \$/g;
					}

					if ($line =~ /\/ [a-zA-Z]/) {
						$line =~ s/\/ /\/ \$/g;
					}

					if ($line =~ /\ = [a-zA-Z]/) {
						$line =~ s/ \= / \= \$/g;	
					}

					# if the line ends in numbers then add a $ sign to the variable name & the semi colon
					# otherwise just add the semi colon
					if ($line =~ /[a-zA-Z0-9]$/) {
						$line =~ s/\n$/\;\n\}\n/;
					}
				}

				#if it is a multistage if statement
			} else {
				$line =~ s/^if /if \(\$/;
				$line =~ s/:/\)/;
			}
		} else {
			#if the line starts with a print statement
			if ($line =~ /^print/) {

				#if the line is a string with quotations
				if ($line =~ /^print \"/) {
					$line =~ s/\"\n/\"/;
					$line =~ s/(\")$/\", \"\\n\"\;\n/;
				} else {

					if ($line =~ /[\+\-\/\*]/) {
						#get rid of any new line characters or trailing white space
						$line =~ s/(\s)$//;
						chomp $line;

						$line =~ s/^print /print \$/;
						#if the line contains operation followed by a variable name:
						if ($line =~ /\- [a-zA-Z]/) {
							$line =~ s/\- /\- \$/g;
						}

						if ($line =~ /\+ [a-zA-Z]/) {
							$line =~ s/\+ /\+ \$/g;
						}

						if ($line =~ /\* [a-zA-Z]/) {
							$line =~ s/\* /\* \$/g;
						}

						if ($line =~ /\/ [a-zA-Z]/) {
							$line =~ s/\/ /\/ \$/g;
						}

						$line = $line."\, \"\\n\"\;\n";
					} else {
						$line =~ s/^print /print \"\$/;
					
						#get rid of any new line characters or trailing white space
						$line =~ s/(\s)$//;
						chomp $line;

						$endLine = "\\n\"\;\n";
						$line = $line.$endLine;
					}
				}
			}

			#if your line contains an assignment statement or an equation but not a print
			if ($line =~ /\=/ && $line =~ /[^(print)]/) {

				#if the line contains subtraction add a space
				if ($line =~ /\-[0-9]/) {
					$line =~ s/\-/\- /g;
				}

				#if the line contains addition add a space
				if ($line =~ /\+[0-9]/) {
					$line =~ s/\+/\+ /g;
				}
				
				#if the line contains multiplication add a space
				if ($line =~ /\*[0-9]/) {
					$line =~ s/\*/\* /g;
				}
				
				#if the line contains division add a space
				if ($line =~ /\/[0-9]/) {
					$line =~ s/\//\/ /g;
				}

				#if the line contains operation followed by a variable name:
				if ($line =~ /\- [a-zA-Z]/) {
					$line =~ s/\- /\- \$/g;
				}

				if ($line =~ /\+ [a-zA-Z]/) {
					$line =~ s/\+ /\+ \$/g;
				}

				if ($line =~ /\* [a-zA-Z]/) {
					$line =~ s/\* /\* \$/g;
				}

				if ($line =~ /\/ [a-zA-Z]/) {
					$line =~ s/\/ /\/ \$/g;
				}

				if ($line =~ /\= [a-zA-Z]/) {
					$line =~ s/\= /\= \$/g;
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
		}
	}

	#print the line
	print "$line";
}