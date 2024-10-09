# # for commenting the multiline at one go we can use {ctrl+/} and same for uncommenting also. 

### Data Source-> Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.
## resource and it's type for data source we find from terraform documentation. 
data "aws_ami" "ubuntu" {        # resource type = "aws_ami" and it's name for terraform name = "ubuntu"
  most_recent = "true"           # "most_recent", and "owners" are arguments which we use update the values, this owner information we can find inside the ami search section in aws. 
  owners      = ["099720109477"] # we'll get owner id by searching the ami id inside the AMIs section in dashboard >> select public image >> update ami id >> serach it.
  # This will give's all the information about that particular ami id.


  filter { # This is also an argument which ask for many value for choosing the image like Name of the image which we can get from AMI's seach section.
    name   = "name"
    values = ["${var.image_name}"] # we used "*" here because we want that after this {ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server} any version can be ok.
  }

  filter {
    name   = "root-device-type" # "root-device-type" is aksing for the type root volume which has 2 types "EBS/instance-store".
    values = ["ebs"]            # root-volume is "EBS".
  }

  filter {
    name   = "virtualization-type" # "virtualization-type" Image virtualization has 2 types "praavirtual/hvm".
    values = ["hvm"]               # Image "virtualization-type" is "hvm" here.
  }

}

resource "aws_instance" "first-instance-tf" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.sydney-key.key_name           # Or we can directly write the key-pair name because we have created key-pair resource.
  vpc_security_group_ids = ["${aws_security_group.sydney-tf-sg1.id}"] # this perameter required the security group id, so we have provided the security group ID from it's output. And this required [].

  tags = {
    Name = "Server-1-tf"
  }
  user_data = file("${path.module}/userdata.sh")

  # Shell script induntation is very sensitive, It start without space from the line and if we want to ignore the induntation, so we need to give (-) just after the << and before the EOF. <<-EOF.
  # Or we can make a shell script for this and run's under the userdata. And use that script thrugh the file function.

  # That's how we can give multiline string value. <<EOF <content> EOF | This we <<EOF <content> EOF, we will use when we directly writing the shell script in userdata here.<<-EOF 

  # Passing the data into virtual machine and other compute resource. We use {"provisioner"}
  # Suppose in this directry there is a file which we want to copy inside the instance, so we use {"provisioner"} to do that. 
  # {"Provisioner"} has 3 types. 

  ### file        -> Provisioner copies files and directories from terraform machine to create resources.
  ### local-exec  -> Executes a command on the machine where Terraform is run (not on the target resource). Basically runs the commnad on the terraform machine for executing inside the created resource.  
  ### remote-exec -> Executes a command or script on the remote resource that has been created by Terraform (e.g., an EC2 instance) Useful for running commands on remote servers, such as configuration scripts or software installations.

  ### In once instance we can give multiple provisioners.

  # Here we are updating the connection because we have update 2 provisioner so the below connection works as global for both the provisioner, or we can write inside the provisioner's also for each provisioner.

  connection { ### Erlier our provision doesn't get executed due to we didn't provided the connection information like below. its and complusory to export data in resources. 
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host        = self.public_ip #But we can give resource type and its name for terraform because this resource is already created
    ## and it depends on it's own self. for the public_ip it can't create it's on self again, so because of this we update {self} in the place of resource type.
  }

  provisioner "file" {
    source      = "index.html"      # This will have in our local machine where we are running the terraform from. 
    destination = "/tmp/index.html" # In this specific path inside the newly created resource ec2 instance. 
    ### When we execute the provisioner and because of some case if the provisioner didnt' executed properly for the instance it will mark that instance as tainted (damaged)
  }

  ## Here we can write the content also which can be update into the file update in the destination secton.

  provisioner "file" {
    content     = "I am an DevOps Engineer and I am looking for the job" #We can write anything here. 
    destination = "/tmp/myfile.txt"                                      # It will create the file inside the /tmp and paste content inside the file. 
  }

  provisioner "file" {
    source      = "iphone"
    destination = "/tmp/"
  }

  ### We are here looking the "local-exec" provisioner. It used to store the created resource information in our local machine. 
  ### But some time we use local-exec if we want to create or configure something which depends on this resource output. Like running the jenkins from this output, it can be anything. 

  ### Once the resource will get created this "local-exec" get triggered and runs, that's why it's used in verious other automation and configuration tasks.
  provisioner "local-exec" {
    command = "echo ${self.public_ip} > /tmp/public-ip.txt" #Basically we are priting the public ip and updating into a public-ip.txt file.
  }

  provisioner "local-exec" {
    working_dir = "/tmp" # Here we specify the directroy in which we wanted to run the "echo" command.
    command     = "echo ${self.public_ip} > mypublicip.txt"
  }

  provisioner "local-exec" {
    interpreter = ["/usr/bin/python3", "-c"] #Our python3 interpretor was stored in /usr/bin/python3 in the local machine "-c" is command
    command     = "print('HelloWorld')"      # we wanted to print "Hello world" in python so we run inside the command section.
  }
  ### This working_dir and interpreters are the arguments which are optional and there are many other arguments also in local-exec. 

  provisioner "local-exec" {
    command = "env>env.txt" ## Here we are using the environmnet argument just like interpreter, and working_dir. # for env.txt we didn't provide any specific path, so it will get created in corrent directroy.
    environment = {
      envname = "envalue"
    }
  }

  provisioner "local-exec" { # This will run while creation of the resource.
    command    = "echo 'at create'"
    on_failure = continue # "on_failure" this argument either can mark your resource as tainted or continue working the same resource. 

  }

  provisioner "local-exec" {
    when    = destroy # This is when argument in "local-exec" #It basically used that when we can run the command so the value is stored as "destroy". It will run when resource will be get destroyed. 
    command = "echo 'at delete'"
  }

  ### When ever we use {when = destory} so the destory value never comes in the ("") because it's depricated.

  # We know that if provisioner failed so the terraform mark the resource as tainted and terraform apply commands get failed, so the resource need's to get recreated.
  # But not if the provisioner failed and still we want to run the same resource, so we have argument called "on_failure" in terraform.
  # So for this we can provide the value either "stop" or "continue". 


  ##### {remote-exec} provisioner #####
  # the "local-exec" was running in our local machine as name suggested, but "remote-exec" runs inside the created resource which ever is possible to take as remote access. 
  # as we also know that we can not take the secuirty group remote access or s3 remote access and run's the command inside it.

  provisioner "remote-exec" {
    inline = [ # Here "inline" argument we can run multiple commands. 
      "ifconfig > /tmp/ifconfig.output",
      "echo 'hello india' >/tmp/india.txt",
    ]
  }

  provisioner "remote-exec" {
    script = "./script.sh" # In "script" argument we can update script relative or abslute path. 
  }

}

