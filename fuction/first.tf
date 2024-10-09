
variable "users" {
  type = list
  description = "Here we update the primeuser's list"
  default = ["Shriyansu", "Akash", "Arpit", "Deepak"]
}

### here we are using the fuction and fuction which we are using here is (join) and the < "|" > is the seprator which basically seprate the name between the 

output "primeuser" {
  value = "${join("|",var.users)}"
}

## this is also fuction we are using here we can use lower and upper fuction which change the user's speling into the upper and lower case ##

output "primeuser1" {
  value = "${upper(var.users[2])}"
}

output "primeuser2" {
  value = "${lower(var.users[3])}"
}