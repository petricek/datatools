my @S = (
"        print(\"my \@S = (\\n\");	",
"        foreach my \$line (\@S)	",
"        {	",
"                my \$escapedLine = \$line;	",
"                \$escapedLine =~ s/\$/\\\$/g;	",
"                \$escapedLine =~ s/\\/\\\\/g;	",
"                \$escapedLine =~ s/\"/\\\"/g;	",
"                \$escapedLine =~ s/@/\\\@/g;	",
"                \$escapedLine =~ s/\$/\\\"/g;	",
"                \$escapedLine =~ s/^/\\\"/g;	",
"                print \"\\\"\$escapedLine\\\",\\n\";	",
"        }	",
"        foreach my \$line (\@S)	",
"        {	",
"                print(\$line . \"\\n\");	",
"        }	",
"        print(\"    }\\n\");	",
"        print(\"}\\n\");	",
        );
        print("my \@S = (\n");
        foreach my $line (@S)
        {
		my $escapedLine = $line;
		$escapedLine =~ s/\$/\\\$/g;
		$escapedLine =~ s/\\/\\\\/g;
		$escapedLine =~ s/\"/\\\"/g;
		$escapedLine =~ s/@/\@/g;
		$escapedLine =~ s/^/\"/g;
		$escapedLine =~ s/$/\"/g;
		print "$escapedLine,\n";
        }
        foreach my $line (@S)
	{
		print($line . "\n");
	}
        print("    }\n");
        print("}\n");
