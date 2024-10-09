
# This output variable is aksing for the values from the input variable.tf file and giving the output to us #
output "printname" {
  value = "${var.nameofuser}=${var.age}"
}