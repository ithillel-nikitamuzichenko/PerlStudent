#!/usr/bin/perl -w

use strict;
use CGI qw{:all};
my $query=new CGI;
print $query->header,$query->start_html('mail');
     print <<HTML;
<body style="background:#CCFCFF">
<form action=23.pl align=center>
<h1 align=center>login exists! Try again!<h1>
<center><input type=submit value=ok></center>

</form>
HTML
 print $query->end_html;