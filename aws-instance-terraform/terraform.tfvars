
ports = [22, 80, 443, 3306, 27017, 8080, 9090] # This is a variable value of port which used to open the inbound port. 
# So if we make any changes into the ports, it will not create new one because security groups are mutating so it makes the changes into existing one only.
# But in some case if it make changes into the existing one, so it create sort of problems, so we use terraform taint. means it's an damage

# {terraform taint aws_security_group.sydney-tf-sg1} when we run this command so the terraform understand that this particular resource is damage so it will create new one. behalf of it.
# sydney-tf-sg1 = resource name
# aws_security_group = resource type

# Once we marked the resource as "tainted" then we can see the particular resource status inside the "terraform.tfstate" file as taint. 

# Importent:- But terraform never recommand to run terraform taint command.

instance_type = "t2.micro"
image_name = "ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"

