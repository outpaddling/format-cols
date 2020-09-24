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

function format_col(_col, _col_array)

{
    #printf("Checking for %s in ", col);
    #for (c in col_array) printf("%s ", col_array[c]);
    #printf("\n");
    for (_c in _col_array)
    {
	if (_col_array[_c] == _col)
	{
	    #printf("found %s ", col);
	    return 1;
	}
    }
    return 0;
}


function abs(_num)
{
    if ( _num < 0 )
	return -_num;
    else
	return _num;
}


BEGIN {
    #printf("cutoff=%s sig_figs=%s col_str='%s'\n", cutoff, sig_figs, col_str);
    split(col_str, col_array, "[ \t]");
    #printf("col_array = ");
    #for (c in col_array) printf("%s ", col_array[c]);
    #printf("\n");
}
{
    for (c = 1; c <= NF; ++c)
    {
	if ( ($c ~ "[0-9]*\.[0-9]+(e[0-9])*") && format_col(c, col_array) )
	{
	    if (abs($c) < cutoff)
	    {
		#printf("Formatting %s... ", $c);
		printf("%0.*e%s", sig_figs, $c, FS);
	    }
	    else
	    {
		printf("%0.*g%s", sig_figs, $c, FS);
	    }
	}
	else
	    printf("%s%s", $c, FS);
    }
    printf("\n");
}
END {
}
