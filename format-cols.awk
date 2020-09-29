#############################################################################
#   Description:
#       Format numbers in given columns according to user preferences
#
#   History: 
#   Date        Name        Modification
#   2020-09-23  Jason Bacon Begin
#############################################################################

function format_col(_col, _col_array)

{
    for (_c in _col_array)
    {
	if (_col_array[_c] == _col)
	{
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
    split(col_str, col_array, "[ \t]");
    OFS=FS;
}
{
    for (c = 1; c <= NF; ++c)
    {
	if ( ($c ~ "[0-9]*\.[0-9]+(e[0-9])*") && format_col(c, col_array) )
	{
	    if (abs($c) < cutoff)
	    {
		printf("%0.*e", sig_figs, $c);
	    }
	    else
	    {
		printf("%0.*g", sig_figs, $c);
	    }
	}
	else
	    printf("%s", $c);
	if ( c < NF ) printf("%s", FS);
    }
    printf("\n");
}
