variable "usersage" {
  type = map(any)
  default = {
    Deep   = 23
    Prerna = 21
  }
}

output "userage" {
  value = "My name is Prerna Singh and my age is ${lookup(var.usersage, "Prerna")}"

}