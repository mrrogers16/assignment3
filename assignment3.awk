BEGIN {
FS = ","
}
{

call_id[NR] = $1;
timestamp[NR] = $2;
problem_type[NR] = $3;
address[NR] = $4;
division[NR] = $5;

pblm[$3]++
div[$5]++

#Pull out the date from the record
current_date = substr($2, 2, 10)

#Build array of unique dates
if(!(current_date in unique_dates))
{
        unique_dates[current_date] = 1
        first_call[current_date] = $0
        last_call[current_date] = $0
}

# Update first and last calls for the current date
# MIN MAX functions for first and last calls in respect to each unique date
#Set Last Call
if (timestamp[NR] < timestamp[last_call[current_date]])
{
        last_call[current_date] = $0
}
#Set First Call
if (timestamp[NR] > timestamp[first_call[current_date]])
{
        first_call[current_date] = $0
}
}
END{


##Print total number of calls
for(id in call_id)
{
count++
}
print "Total Calls = " count
print ""
print ""

#Print unique dates and entire record from first/last_call arrays
for(current_date in unique_dates)
{
print "Date: " current_date
print "\tFirst Call: " first_call[current_date]
print "\t Last Call: " last_call[current_date]
print "\n"
}

#Print Per Problem totals
print "Per Problem Totals: "
for(problem in pblm)
print "\t" problem ":" pblm[problem]
print ""


##Print Per-Division totals
print "Per-Division Totals: "
for(di in div)
print "\t" di ":" div[di]

}
