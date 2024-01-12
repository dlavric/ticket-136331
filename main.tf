resource "null_resource" "null" {
  #count = 3
  for_each = toset(["a","b","c"])
}