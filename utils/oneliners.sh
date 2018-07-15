# kill process running on port 8080
lsof -i :8080 | awk '{l=$2} END {print l}' | xargs kill 

# get cwd of executed script
$(cd "$(dirname "$0")" && pwd)

# show 10 largest open files
lsof / | awk '{ if($7 > 1048576) print $7/1048576 "MB" " " $9 " " $1 }' | sort -n -u | tail

# show status of all git repos in ~ and subdirectories
find ~ -name ".git" 2> /dev/null | sed 's/\/.git/\//g' | awk '{print "-------------------------\n\033[1;32mGit Repo:\033[0m " $1; system("git --git-dir="$1".git --work-tree="$1" status")}'

# print 10 sequential numbers
echo {01..10}

# print 2nd and 4th column of the file
awk '{print $2,$4}' input.txt
