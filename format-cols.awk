#############################################################################
#   Description:
#  
#   Arguments:
#
#   Returns:
#
#   History: 
#   Date        Name        Modification
#   2020-09-23  Jason Bacon Begin
#############################################################################

function format_col(col, cols)

{
    #printf("Checking for %s in ", col);
    #for (c in cols) printf("%s ", c);
    #printf("\n");
    for (c in cols)
    {
	if (c == col)
	{
	    #printf("%s is in array\n", col, cols);
	    return 1;
	}
    }
    return 0;
}


function abs(num)
{
    if ( num < 0 )
	return -num;
    else
	return num;
}


BEGIN {
    #printf("cutoff=%s sig_figs=%s col_str=%s\n", cutoff, sig_figs, col_str);
    split(col_str, cols, "[\t ]");
    #printf("cols = ");
    #for (c in cols) printf("%s ", c);
    #printf("\n");
}
{
    for (c = 1; c <= NF; ++c)
    {
	if ( ($c ~ "[0-9]*\.[0-9]+(e[0-9])*") && format_col(c, cols) )
	{
	    #printf("Formatting %s... ", $c);
	    if (abs($c) < cutoff)
	    {
		printf("%0.*e\t", sig_figs, $c);
	    }
	    else
	    {
		printf("%0.*g\t", sig_figs, $c);
	    }
	}
	else
	    printf("%s\t", $c);
    }
    printf("\n");
}
END {
}
