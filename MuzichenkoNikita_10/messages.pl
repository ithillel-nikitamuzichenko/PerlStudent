#!/usr/bin/perl -w
use strict; 
use CGI;
my $databace="bd.dat";
my $query=new CGI;
my $count;
my @arr;
if(!$query->param){
    print $query->header,$query->start_html('messages');
    open(GB_DAT,"$databace")|| die("Can not open test file: - $databace");
     print <<HTML;
<body style="background:#CCCFC9">
<form action=messages.pl method=post>
<h4>Name:</h4> <input type=text name=name><br>
<h4>Message:</h4><textarea cols="70" rows="10" name=mess></textarea><br>
<input type=submit value=write><input type=reset value=Clear>
</form>
HTML
    print $query->end_html;
    my @el=<GB_DAT>; 
    
    for(my $i=@el-1;$i>=0;$i--){ 

if($el[$i]=~/(7777)/){ @arr=split(/7777/,$el[$i]);

print "<br><font color=\"green\">autor :</font> $arr[1] </br>";$count=$arr[0];next
};
        print " <font size=\"4\"><kbd>$el[$i]<br></kbd></font>";
    }
 
    close(GB_DAT);
  print $query->end_html;

}else{
    open(GB_DAT,">>$databace")|| die("Can not open test file: - $databace");
    
    flock(GB_DAT,2)|| die("Can not lock  file: - $databace - $databace");
#$count=$count+1;
   my @message = reverse(split(/\n/,$query->param('mess')));
my $name=$query->param('name');unless($name){$name="Guest"};
    foreach (@message){print GB_DAT "$_\n"};
    print GB_DAT "$count","7777",$name," ",(localtime)[5] + 1900,'.',(localtime)[4] + 1,'.',(localtime)[3],'  ',(localtime)[2],":",(localtime)[1],"\n";
    close(GB_DAT);
    print $query->redirect('messages.pl');
}
