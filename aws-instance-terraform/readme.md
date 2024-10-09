# Now here we are gona create the aws-resource, security group and ssh-key

# Tasks

<<##########################################################################################################################################################################>>

# SSH-key -> First-key # Assign it to the new aws-instance. - Done

When we generally create ssh-key it create 2 key's 1. Public key, 2. Private key

Machine uses the "Private Key" and the user who access the machine use's the "Public Key"

Private key appiear into machine inside the user home directory there will be .ssh folder inside that there will be authorized_key file. 
<</home/user-name/.ssh/authorized-key>>

# for creating the ssh key we use the command called "ssh-keygen" and which type of ssh-key we want to create so we use "-t" arguments into this.

<<ssh-keygen -t rsa>> # here we can (ssh-keygen)-command (-t)-argument and (rsa)-key type. after that it will ask to give a path to store the key's or if we don't provide it store in by default location which is nothing but. </home/user/.ssh/id_rsa>.

Now it will create keys with name of (id_rsa -> private key) (id_rsa.pub -> public key)

# Creating a security group and assigning it to aws-instance. - Done
 
# Create Key-pair and attach it with the instance. - Done

# install nginx and configure it.
- /var/www/html/index.html -> Hello, I am Shriyanshu Dwivedi. 




