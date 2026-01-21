#!/bin/bash

echo "=== GREP/EGREP/FGREP COMMANDS ==="
echo "1. Find lines starting with 'var':"
grep -n '^var' data/regex_lab.txt

echo ""
echo "2. Find time patterns:"
egrep '[0-9]{1,2}:[0-9]{2} (am|pm)' data/regex_lab.txt

echo ""
echo "3. Find literal 'a*b*' string:"
fgrep 'a*b*' data/regex_lab.txt

echo ""
echo "=== TR COMMANDS ==="
echo "1. Convert to uppercase:"
cat data/regex_lab.txt | tr 'a-z' 'A-Z' | head -3

echo ""
echo "2. Delete all digits:"
cat data/regex_lab.txt | tr -d '0-9' | head -5

echo ""
echo "=== SED COMMANDS ==="
echo "1. Replace 'amount' with 'price' globally:"
sed 's/amount/price/g' data/regex_lab.txt | grep price

echo ""
echo "2. Delete lines containing 'EMPTYLINE':"
sed '/EMPTYLINE/d' data/regex_lab.txt | head -5
