resource "null_resource" "null" {
  #count = 3
  for_each = toset(["a","b","c"])
}

# moved {
#   from = null_resource.null[0]
#   to   = null_resource.null["a"]
# }


# moved {
#   from = null_resource.null[1]
#   to   = null_resource.null["b"]
# }

# moved {
#   from = null_resource.null[2]
#   to   = null_resource.null["c"]
# }
