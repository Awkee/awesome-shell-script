BEGIN{
	FS=":"; date = "January 1, 1988"
	hfmt = "%36s %8s %12s %7s %12s\n"
	tfmt = "%33s %10s %10s %9s\n"
	TOTfmt = "  TOTAL for %-13s%7d%11.1f%11d%10.1f\n"
	printf("%-18s %-40s %19s\n\n", "Report No. 3",
		   "POPULATION, AREA, POPULATION DENSITY", date)
	printf(" %-14s %-14s %-23s %-14s.%-11s\n\n",
	"CONTINENT", "COUNTRY", "POPULATION", "AREA", "POP. DEN.")
	printf(hfmt, "Millions ", "Pet. of", "Thousands ", "Pet. of", "People per")
	printf(hfmt, "of People", "Total ", "of Sq. Mi.","Total ", "Sq. Mi. ")
	printf(hfmt, "---------", "-------", "----------", "-------","----------")
}
{
	if( $1 != prev) {
		if(NR > 1)
			totalprint()
		prev = $1
		poptot = $8; poppct = $4
		areatot = $9; areapct = $6
	} else {
		$1 = ""
		poppct += $4; areapct += $6
	}
	printf(" %-15s%-10s %6d %10.1f %10d %9.1f %10.1f\n",$1, $2, $3, $4, $5, $6, $7)
	gpop += $3; gpoppct += $4
	garea += $5; gareapct += $6
}
END{
	totalprint()
	printf(" GRAND TOTAL %20d %10.1f %10d %9.1f\n", 
		   gpop, gpoppct, garea, gareapct)
	printf(tfmt, "=====", "======", "=====", "======")
}
function totalprint() { #print totals for previous continent
	printf(tfmt, "----", "-----", "-----", "-----")
	printf(TOTfmt, prev, poptot, poppet, areatot, areapct)
	printf(tfmt, "====", "=====", "=====", "=====")
}




