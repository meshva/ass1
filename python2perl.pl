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
	if ($line =~ /^#!\/usr\/bin\/python$/) {
		$line =~ s/python$/perl -w/;
	} else {
		#if the line is an empty line remove it
		if ($line =~ /^(\n)$/) {
			chomp $line;
		}

		#case for printing strings
		if ($line =~ /^print \"/) {
			$line =~ s/\n$//;
			$endLine = "\, \"\\n\"\;\n";
			$line = $line.$endLine;
			print $line;
			next;
		}

		#if the line contains subtraction add a space
		if ($line =~ /\-[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\-/\- /g;
		}

		if ($line =~ /[a-zA-Z0-9]\-/ && $line =~ /[^(print)]/) {
			$line =~ s/\-/ \-/g;
		}

		#if the line contains addition add a space
		if ($line =~ /\+[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\+/\+ /g;
		}

		if ($line =~ /[a-zA-Z0-9]\+/ && $line =~ /[^(print)]/) {
			$line =~ s/\+/ \+/g;
		}

		if ($line =~ /[a-zA-Z0-9]\// && $line =~ /[^(print)]/) {
			$line =~ s/\// \//g;
		}

		if ($line =~ /[a-zA-Z0-9]\*/ && $line =~ /[^(print)]/) {
			$line =~ s/\*/ \*/g;
		}
						
		#if the line contains multiplication add a space
		if ($line =~ /\*[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\*/\* /g;
		}
						
		#if the line contains division add a space
		if ($line =~ /\/[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\//\/ /g;
		}

		#single equals
		if ($line =~ /\ =[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\=/\= /g;	
		}

		#comparison (double equals)
		if ($line =~ /\=\=[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\=\=/\=\= /g;	
		}

		#if the line has a modulus add a space
		if ($line =~ /\%[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\%/\% /;
		}

		if ($line =~ /[a-zA-Z0-9]\%/ && $line =~ /[^(print)]/) {
			$line =~ s/\%/ \%/g;
		}

		if ($line =~ /\*\*[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\*\*/\*\* /;
		}

		#bitwise operations
		if ($line =~ /\<[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\</\< /;
		}

		if ($line =~ /\>[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\>/\> /;
		}

		if ($line =~ /\<\=[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\<\=/\<\= /;
		}

		if ($line =~ /\>\=[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\>\=/\>\= /;
		}

		if ($line =~ /\<\>[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\<\>/\<\> /;
		}

		if ($line =~ /\!\=[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\!\=/\!\= /;
		}

		if ($line =~ /\>\>[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\>\>/\>\> /;
		}

		if ($line =~ /\<\<[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\<\</\<\< /;
		}

		if ($line =~ /\|[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\|/\| /;
		}

		if ($line =~ /\~[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\~/\~ /;
		}

		if ($line =~ /\&[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\&/\& /;
		}

		if ($line =~ /\^[a-zA-Z0-9]/ && $line =~ /[^(print)]/) {
			$line =~ s/\^/\^ /;
		}

		#if the line contains operation followed by a variable name, 
		#and it does not start with a print then add a $
		if ($line =~ /\- [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\- /\- \$/g;
		}

		if ($line =~ /\+ [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\+ /\+ \$/g;
		}

		if ($line =~ /\* [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\* /\* \$/g;
		}

		if ($line =~ /\/ [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\/ /\/ \$/g;
		}

		if ($line =~ /\ = [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/ \= / \= \$/g;	
		}

		if ($line =~ /[a-zA-Z0-9]=[a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\=/ \= \$/g;	
		}
			
		if ($line =~ /\% [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\% /\% \$/;
		}

		if ($line =~ /\*\* [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\*\* /\*\* \$/;
		}

		if ($line =~ /\< [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\< /\< \$/;
		}

		if ($line =~ /\> [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\> /\> \$/;
		}

		if ($line =~ /\<\= [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\<\= /\<\= \$/;
		}

		if ($line =~ /\>\= [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\>\= /\>\= \$/;
		}

		if ($line =~ /\<\> [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\<\> /\<\> \$/;
		}

		if ($line =~ /\!\= [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\!\= /\!\= \$/;
		}

		if ($line =~ /\>\> [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\>\> /\>\> \$/;
		}

		if ($line =~ /\<\< [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\<\< /\<\< \$/;
		}

		if ($line =~ /\| [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\| /\| \$/;
		}

		if ($line =~ /\~ [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\~ /\~ \$/;
		}

		if ($line =~ /\& [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\& /\& \$/;
		}

		if ($line =~ /\^ [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/\^ /\^ \$/;
		}

		if ($line =~ /and [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/and /and \$/;
		}

		if ($line =~ /or [a-zA-Z]/ and $line =~ /[^(print)]/) {
			$line =~ s/or /or \$/;
		}

		if ($line =~ /not [a-zA-Z]/ && $line =~ /[^(print)]/) {
			$line =~ s/not /not \$/;
		}

		#if the line is a while loop
		if ($line =~ /^while/) {

			#replace the word break with last - assuming that there are no variables or strings
			# with the word break or continue also assuming that break and continue are used in loops
			if ($line =~ /break/) {
				$line =~ s/break/last/;
			}

			#replace the word continue with next
			if ($line =~ /continue/) {
				$line =~ s/continue/next/;
			}

			#add a variable $ if the while comparison is for a variable
			if ($line =~ /^while [a-zA-Z]/) {
				$line =~ s/^while /while \(\$/;
			}

			#if its an inline while loop
			if ($line =~ /: [a-zA-Z0-9]/) {

				# add a new line followed by the appropriate indentation since this is an inline loop
				$line =~ s/:(\s)*/\) \{\n    /;

				#if the inline loop has 2 operations
				if ($line =~ /\;/) {
					

					#give the operation after the ; a new line and indentation
					$line =~ s/\; /\;\n    /;
					
					#if the expression after the new line is starting with a variable give it a $
					if ($line =~ /\;\n    [a-zA-Z]/) {

						if ($line =~ /\n( ){4}\s*last/) {
							# do nothing
						} else {
							if ($line =~ /\n( ){4}next/) {
								# body...
							} else {
								$line =~ s/\;\n    /\;\n    \$/;	
							}
						}
					}

					if ($line =~ /\n( ){4}[a-zA-Z]/) {

						#check if the line is a print statement otherwise its an assignment statement
						if ($line =~ /\n( ){4}print [a-zA-Z]/) {
							if ($line =~ /\n( ){4}print (.)*\;\n/) {
								$line =~ s/\n( ){4}print /\n    print \"\$/;
								$line =~ s/;/\\n\"\;/;
							}
						} else {
							if ($line =~ /\n( ){4}\s*last/) {
								# do nothing
							} else {
								if ($line =~ /\n( ){4}next/) {
									# body...
								} else {
									$line =~ s/\n( ){4}/\n    \$/;		
								}
							}					
						}

						if ($line =~ /[a-zA-Z0-9]$/) {
							$line =~ s/\n$//;
							$line =~ s/$/\;\n\}\n/;
						}
					}

					#if the inline loop only has one operation
				} else {
					#add a variable $ and a new line followed by the appropriate indentation
					$line =~ s/:(\s)*/\) \{\n    /;


					#if the line contains an expression after the 4 spaces since it is an inline if statement
					if ($line =~ /\n( ){4}[a-zA-Z]/) {

						if ($line =~ /\n( ){4}\s*last/) {
							# do nothing
						} else {
							if ($line =~ /\n( ){4}next/) {
								# body...
							} else {
								$line =~ s/\n( ){4}/\n    \$/;		
							}
						}
						

						# if the line ends in numbers then add a $ sign to the variable name & the semi colon
						# otherwise just add the semi colon
						if ($line =~ /[a-zA-Z0-9]$/) {
							$line =~ s/\n$//;
							$line =~ s/$/\;\n\}\n/;
						}
					}
				}
			} else {
				#multilevel while loops
			}
		} else {

			#if the line is a for loop
			if ($line =~ /^for/) {
				$line =~ s/^for /foreach \$/;
				$line =~ s/in//;

				if ($line =~ /range\(/) {
					#capturing the second number in the range
					$numTwo = $line;
					$numTwo =~ s/(.)*range\(//;
					$numTwo =~ s/(.)*,//;
					$numTwo =~ s/^ //;
					$numTwo =~ s/\)(.)*//;
					$numTwo = $numTwo-1;

					$line =~ s/ range\(/\(/;
					$line =~ s/, [a-zA-Z0-9]*/..$numTwo/;
				}

				$line =~ s/:/ \{/;
			}

			#if the line is an if statement
			if ($line =~ /^if/) {					
				#if the line is an inline if statement
				if ($line =~ /: [a-zA-Z0-9]/) {
					#add a variable $ and a new line followed by the appropriate indentation
					$line =~ s/^if /if \(/;
					if ($line =~ /^if \([a-zA-Z]/) {
						$line =~ s/^if \(/if \(\$/;
					}
					$line =~ s/:(\s)*/\) \{\n    /;

					#if the line contains an expression after the 4 spaces since it is an inline if statement
					if ($line =~ /\n( ){4}[a-zA-Z]/) {
						$line =~ s/\n( ){4}/\n    \$/;

						# add a semi colon unless it ends in a bracket already
						if ($line =~ /[^\{\}]$/) {
							if ($line =~ /\n$/) {
								$line =~ s/\n$//;
							}
							$line =~ s/$/\;\n\}\n/;
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

				if ($line =~ /( ){4}print/) {
					#if the line is a string with quotations
					if ($line =~ /( ){4}print \"/) {
						$line =~ s/\"\n/\"/;
						$line =~ s/(\")$/\", \"\\n\"\;\n/;
					} else {

						if ($line =~ /[\+\-\/\*]/) {
							#get rid of any new line characters or trailing white space
							$line =~ s/(\s)$//;
							chomp $line;

							$line =~ s/^print /print \$/;

							$line = $line."\, \"\\n\"\;\n";
						} else {
							if ($line =~ /[a-zA-Z0-9] [a-zA-Z0-9]/) {
								$line =~ s/\n$//;
								$endLine = "\\n\;\n";
								$line = $line.$endLine;
							} else {
								$line =~ s/print /print \"\$/;
								$line =~ s/\n$//;
								$endLine = "\\n\"\;\n";
								$line = $line.$endLine;
							}
						}
					}
				}

				#if your line contains an assignment statement or an equation but not a print
				if ($line =~ /\=/ && $line =~ /[^(print)]/) {

					# if the line ends in numbers then add a $ sign to the variable name & the semi colon
					# otherwise just add the semi colon
					if ($line =~ /[0-9]$/) {
						$line =~ s/^/\$/;
						$line =~ s/\n$//;
						$line =~ s/$/\;\n/;
					} else {
						$line =~ s/^/\$/;
						if ($line =~ /\=\"/ || $line =~ /\= \"/) {
							$line =~ s/\"\n/\"\;\n/;
						} else {
							$line =~ s/\=/\=\"/;
							$line =~ s/\n/\"\;\n/;
						}
						
					}
				}
			}
		}
	}

	#print the line
	print "$line";
}