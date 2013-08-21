#!/usr/bin/perl -w
use strict;
use CGI qw{:all};

use MIME::Lite;
MIME::Lite->send("sendmail","/usr/lib/sendmail -t -oi -oem ");
my $query=new CGI;
my $ne='not';
my $check='';
if(!$query->param){
my $random = rand(10);
if($random>5){$ne='';$check='checked'};
    print $query->header,$query->start_html('mail');
     print <<HTML;
<body style="background:#CCCCFF">
<form action=mail.pl method=post>
<INPUT type=HIDDEN name=ok value=$ne>
<h4>Mail:</h4><input type=text name=mail><br>
<h4>Topic:</h4> <input type=text name=topic><br>
<h4>Message:</h4><textarea cols="70" rows="10" name=mess></textarea><br>
<input type=submit value=write><input type=reset value=Clear>
<input  type="checkbox"  name="bot" value="boter" $check>i am $ne spam bot!
</form>
HTML

    print $query->end_html;
}else{
my $ok=param('ok');
my $spam=$query->param('bot');
 my $mail=$query->param('mail');
my $mess=param('mess');
my $topic=$query->param('topic');

if ( ( $ok eq '' & $spam eq "boter" ) || ( $ok eq 'not' & $spam eq '' ) ) {
		print $query->header, $query->start_html('mail');
		print <<HTML;
<body style="background:#CCCCFF">
<form align=center>
<h1 align=center> You SPAM BOT<h1>
<center><input type=submit value=ok></center>

</form>
HTML
		print $query->end_html;print "<h5><pre><top><blockquote>",'
                ```````````__________```____
                ````______/```\__//```\__/____\
                ``_/```\_/``:```````````//____\\
                `/|``````:``:``..``````/````````\
                |`|`````::`````::``````\````````/
                |`|`````:|`````||`````\`\______/
                |`|`````||`````||``````|\``/``|
                `\|`````||`````||``````|```/`|`\
                ``|`````||`````||``````|``/`/_\`\
                ``|`___`||`___`||``````|`/``/````\
                ```\_-_/``\_-_/`|`____`|/__/``````\
                ````````````````_\_--_/````\`````/
                ```````````````/____```````````/
                ``````````````/`````\`````````/
                ``````````````\______\_______/


',"</pre></h5></blockquote></p>"

;
		exit;
	}
if($mail || $topic >200){print $query->header, $query->start_html('mai');
		print <<HTML;
<body style="background:#CCCCFF">
<form align=center>
<h1 align=center>Very long topic or mail!!!<h1>
<center><input type=submit value=ok></center>

</form>
HTML
		print $query->end_html;exit}
	if ( $mail eq '' || $topic eq '' || $mess eq '' ) {
		print $query->header, $query->start_html('mai');
		print <<HTML;
<body style="background:#CCCCFF">
<form align=center>
<h1 align=center>Not all fields are filled<h1>
<center><input type=submit value=ok></center>

</form>
HTML
		print $query->end_html;exit

	};if ( $mail !~ /.*\@.*/g ) {
		print $query->header, $query->start_html('ma');
		print <<HTML;
<body style="background:#CCCCFF">
<form align=center>
<h1 align=center>Not correct "$mail" mail<h1>
<center><input type=submit value=ok></center>

</form>
HTML
		print $query->end_html;

	}else{
     my $msg = MIME::Lite->new (
      From =>'student@perlstudent.tm.local',
       To =>"$mail",
       Subject =>"$topic",
       
        Data =>"$mess"
       );
       $msg->send;
 print $query->redirect('mail.pl');
}}
