#!/usr/bin/perl

use strict;

# simply split
my $mail="test\@test.fr";
if ( $ENV{"MAIL_COLLECTOR"} ne "" ) {
	$mail=$ENV{"MAIL_COLLECTOR"};
} 

my $SERVER_NAME="recette.idesi.fr"
if  ( $ENV{"SERVER_NAME"} ne "" ) {
	 $SERVER_NAME=$ENV{"SERVER_NAME"};	
}

my $name="";
my $domain="";
my $topDomain="";
if ($mail=~/^([\w\-]+(\.[\w\-]+)*)@([\w\-]+(\.[\w\-]+)*)\.(\w+)$/) {
         $name=$1;
         $domain=$3;
         $topDomain=$5;
}

if ($name eq "" ) {	print "Name of COLLECTOR UNKNOW\n"; exit(1);	}
if ($domain eq "" ) {     print "Domain of COLLECTOR UNKNOW\n"; exit(1);    }
if ($topDomain eq "" ) {     print "LTD of domain of COLLECTOR UNKNOW\n"; exit(1);    }



print "configure name=$name  domain=$domain tld=$topDomain for ".$ENV{"MAIL_COLLECTOR"}."\n";

my @listFileMigration=("/etc/postfix/vmailbox","/etc/postfix/vmaildomain","/etc/postfix/main.cf");
foreach my $pathFile (@listFileMigration) {
	`sed -e "s/###TLD###/$topDomain/g" -e "s/###DOMAIN###/$domain/g" -e "s/###NAME###/$name/g" -e "s/###SERVEUR_NAME###/${SERVER_NAME}/g" ${pathFile}.dist > $pathFile`;
}

if( -e "/conf/mail.crt" && -e "/conf/mail.key"){
	`cp /conf/mail.crt  /etc/ssl/certs/mail.crt `;	
	`cp /conf/mail.key  /etc/ssl/private/mail.key `;
}else{
	`cp /etc/ssl/certs/ssl-cert-snakeoil.pem	/etc/ssl/certs/mail.crt  `;
        `cp /etc/ssl/private/ssl-cert-snakeoil.key   /etc/ssl/private/mail.key `;
}


