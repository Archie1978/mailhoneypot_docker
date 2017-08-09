# mailhoneypot_docker

I'm going into several software publishing companies that do not use the right reflex to test mail sending.
This is why with docker this tool allows to test the emails in a development environment.

## Installation
1) Create image
Clone the git repositery and go into this folder.
   docker built -t idesi/mailhoneypot .
  
2) Create container
Edit the .env and docker-compose.yml.dist
   mv docker-compose.yml.dist docker-compose.yml
   docker-compose create
   
3) Over SSL or TLS
One certificate is installed by default, but you can install your certificat or your certificat from your CA. You can create the key on conf/key.crt and certificate on conf/mail.crt
The certificate are load when the container start.

3) Test installation
All mail sent by this server will go to the MAIL_COLLECTOR_LOCAL. Take a browser and go into the cube round, if you are on the same computer url is http://localhost.
The authentification says "YES" together so key in "test_my_email@gmail.com". Then compose you email to taratata@hotmail.com and send this email.

The mail send is into MAIL_COLLECTOR_LOCAL ( default:test@test.fr), you can check this email via roundcube. 

#Avantages for developpement
* All client MTA can connect this server like outlook, thunderbird, mail(mac).
* The email are as a closed circuit.

# Note
I installed this container on datacenter and you can see how the spam create their email.
