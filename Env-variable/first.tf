
### here we basically tring to create the environment variable which we will be stored in the system not in the terraform file and we will be exporting them from terraform plan command.

variable "username" {
  type = string
}

output "printname" {
  value = "Hello, ${var.username}"
}

### Now for creating the environment variable we will use the variable name of this file into the system and run the command mentioned below
### << export TF_VAR_username=Shri >> here basically we are updating the (TF_VAR), So the terraform can understand that variable is for us, username is the variable which we are using in this file
### and the shri is the username variable value.
### This command we will execute in the terminal and once we will run this command and after this we will run the command called << terraform plan >>.check " ###
