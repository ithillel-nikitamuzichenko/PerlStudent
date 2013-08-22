#!/usr/bin/perl -w
use strict;
use CGI qw{:all};
use Storable;
my $query=new CGI;

my %hash=('nik'=>['123',1,1],'cono'=>['1234',1,1]);
store \%hash,'bd.txt';
 




