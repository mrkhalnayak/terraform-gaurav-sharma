
### that how we use the map-type variable

variable "userage" {
  type = map (number)
  default = {
       Shri   = 26
       Akash  = 26
       Arpit  = 28
       Deepak = 25
  }
}
 
### for dynamically reading the value from the map variable  we create an-other varibale###

variable "username" {
  type = string 
}

### Here we are using the lookup fuction and that's how we actully use it. ###
### value = ${lookup(var.variable name, "which value we are looking for")} ###
### Now here we have tried to use the username dynamically through the variable ###

output "userage" {
  value = "my name is ${var.username} and i am ${lookup(var.userage, "${var.username}")} years old "
}