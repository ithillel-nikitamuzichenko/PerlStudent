#!/usr/bin/perl -w
use strict;
use CGI qw{:all};
my $query = new CGI;
print $query->header( -type => 'text/html', -charset => 'charset=cp1251' ),
  $query->start_html('start');
print <<HTML;
<body style="background:#CCFCFF">
<center><form action=24.pl method=post>
<h3>Login:</h4> <input type=text name=login><br>
<h3>Password:</h4> <input type=password name=pass><br>
<br><input type=submit value=submit><input type=reset value=Clear>
<br><br>
<input  type="checkbox"  name=user value=user > Registration new user!
<h3>hidden: 
<input type="radio" checked="checked" name=session value=hidden>
<br/>
cookie: 
<input type="radio" name=session value=cookie></h3>
<INPUT type=HIDDEN name=ses value=ses>
</form><center>
HTML

print $query->end_html;

