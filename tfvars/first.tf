
variable "age" {
  type = number

}

variable "username" {
  type = string
}

output "printname" {
  value = "Hello ${var.username}, and you are ${var.age} years old"
}