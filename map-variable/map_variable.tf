# variable "usersage" {
#   type = map(any)
#   default = {
#     Deep   = 23
#     Prerna = 21
#   }
# }

# output "userage" {
#   value = "My name is Prerna Singh and my age is ${lookup(var.usersage, "Prerna")}"

# }

variable "usersage" {
  type = map(any)
  default = {
    Deep   = 23
    Prerna = 21
  }
}

variable "username" {
  type = string

}

output "userage" {
  value = "My name is ${var.username} and my age is ${lookup(var.usersage, var.username)}"

}


//Command to run in termial terraform plan --var "users=Deep"