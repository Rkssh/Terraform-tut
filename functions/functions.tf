//This all functions are string types.
//join Function

output "printfirst" {
  value = join("-->", var.users)
}

# //Upper functions
# output "printupper" {
#   value = upper(var.users[2])

# }

//Lower Functions
output "printlower" {
  value = lower(var.users[2])

}

//Title Functions
output "printtittle" {
  value = title(var.users[2])

}

output "giving_output" {
  value = join("-->>", var.users)

}

output "printupper" {
  value = upper(var.users[0])

}