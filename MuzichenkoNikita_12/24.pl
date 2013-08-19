#!/usr/bin/perl -w
use strict;
use CGI qw{:all};
use CGI::Session;
use CGI::Cookie;
use Storable;
use LWP;
my $query = new CGI;
if ( param('ses') eq "" && param('next') eq '' ) {
	print $query->redirect('start.pl');
}
my %hash = %{ retrieve('bd.txt') };
if ( param('user') eq 'user' ) {
	foreach ( keys %hash ) {
		if ( param('login') eq "$_" ) {
			print $query->redirect('25.pl');
			exit;
		}
	}
	$hash{ param('login') } = [ param('pass'), 1, 1 ];
	store \%hash, 'bd.txt';
}
my $sid = param('id') || cookie('ID');
my $session =
  CGI::Session->load( "driver:File", $sid, { Directory => "sessions" } );
my $login = param('login') || $session->param('login');
my $pass  = param('pass');
my $index = '1';
if ( param('ses') eq 'ses' ) {
	if ( $pass ne @{ $hash{$login} }[0] || $login eq '' || $pass eq "" ) {
		print $query->redirect('start.pl');
		exit;
	}
}
if ( param('next') ne '' ) {
	$index = @{ $hash{$login} }[1] + 1;
	@{ $hash{$login} }[1] = $index;
	store \%hash, 'bd.txt';
}

#%hash=('nik'=>['123',1,1],'cono'=>['1234',1,1])
my $url     = "http://bash.im/quote/$index";
my $browser = LWP::UserAgent->new;
$session =
  CGI::Session->new( "driver:File", $sid, { Directory => "sessions" } );
$sid = $session->id;

my $cookie1 =
  CGI::Cookie->new( -name => 'ID', -value => $session->param('_SESSION_ID') );
print $query->header(
	-type    => 'text/html',
	-charset => 'windows-1251',
	-cookie  => [$cookie1]
  ),
  $query->start_html('mess');
$session->param( 'index' => $index, 'login' => $login );
print <<HTML;
<body style="background:#CCFCFF">
<form action=24.pl method=post>
<input type=submit name=next value=next>
<input type=submit name=exit value=exit>
<INPUT type=HIDDEN name=id value=$sid>
</form>
HTML
print $query->end_html;
my $response = $browser->get($url);

if ( $response->content =~
	/\<div class\=\"text\">(?<key>[\d\D]+)\<\/div\>\s\<div class\=\"quote\"\>/g
  )
{
	print "<h1>", $session->param('login'),
	  "  read  quote namber :      $index</h1><br><br><br>";
	print "<h1><em>$+{key}</em></h1>";
}
if ( param('exit') eq 'exit' ) {
	$session->delete;
	$session->flush();
	$query->redirect('start.pl');
	exit;
}
