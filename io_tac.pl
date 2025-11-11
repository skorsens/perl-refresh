# Outputs the input line in the reverse order
# E.g. 
# `perl io_tac.pl f1.txt f2.txt`
# outputs all lines of f2.txt in the reverse order and then all lines of
# f1.txt in the reverse order
my @lLines = reverse <>;

print @lLines;
