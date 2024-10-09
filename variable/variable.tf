### here in this we are going to update the variable value and we will use in the terraform code for just practice ###

#This variable is created with given default value which is = Shriyanshu #
# This will be example of variable type string #

variable "nameofuser" {
  type = string
  description = "This is my name"
  default = "Vikash"
}

# This variable is created for asking the value at time of terraform plan or apply command #
# This will be example of variable type number #
variable "age" {
    type = number
    default = 28
}
