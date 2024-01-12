# ticket-136331
Change from count to for_each test repository


# How to refactor your Terraform code: count vs for_each

Please follow the below steps:

- Initialize your configuration and download all the required dependencies 
```shell
terraform init
```

- Apply the changes to your infrastructure
```shell
terraform apply
```

Output of `terraform apply`
```shell
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.null[0] will be created
  + resource "null_resource" "null" {
      + id = (known after apply)
    }

  # null_resource.null[1] will be created
  + resource "null_resource" "null" {
      + id = (known after apply)
    }

  # null_resource.null[2] will be created
  + resource "null_resource" "null" {
      + id = (known after apply)
    }

Plan: 3 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

null_resource.null[2]: Creating...
null_resource.null[1]: Creating...
null_resource.null[0]: Creating...
null_resource.null[0]: Creation complete after 0s [id=5588680990575368284]
null_resource.null[2]: Creation complete after 0s [id=2537175910110366838]
null_resource.null[1]: Creation complete after 0s [id=833659081052874052]

Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
```

- Check the resources that are created in the state file
```shell
terraform state list
```

Output of `terraform state list`
```shell
null_resource.null[0]
null_resource.null[1]
null_resource.null[2]
```

- Change the code and replace `count` with `for_each` in the `main.tf` file:
```hcl
resource "null_resource" "null" {
  #count = 3
  for_each = toset(["a","b","c"])
}
```

- Do another `terraform plan` and observe the following output
```shell
null_resource.null[1]: Refreshing state... [id=833659081052874052]
null_resource.null[2]: Refreshing state... [id=2537175910110366838]
null_resource.null[0]: Refreshing state... [id=5588680990575368284]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create
  - destroy

Terraform will perform the following actions:

  # null_resource.null[0] will be destroyed
  # (because resource does not use count)
  - resource "null_resource" "null" {
      - id = "5588680990575368284" -> null
    }

  # null_resource.null[1] will be destroyed
  # (because resource does not use count)
  - resource "null_resource" "null" {
      - id = "833659081052874052" -> null
    }

  # null_resource.null[2] will be destroyed
  # (because resource does not use count)
  - resource "null_resource" "null" {
      - id = "2537175910110366838" -> null
    }

  # null_resource.null["a"] will be created
  + resource "null_resource" "null" {
      + id = (known after apply)
    }

  # null_resource.null["b"] will be created
  + resource "null_resource" "null" {
      + id = (known after apply)
    }

  # null_resource.null["c"] will be created
  + resource "null_resource" "null" {
      + id = (known after apply)
    }

Plan: 3 to add, 0 to change, 3 to destroy.
```

- Now move the state of each resource that is destroyed and re-created with the following command, one by one:
```shell
terraform state mv 'null_resource.null[0]' 'null_resource.null["a"]'
```

- The expected output, when the resource has been moved should be the following:
```shell
Move "null_resource.null[0]" to "null_resource.null[\"a\"]"
Successfully moved 1 object(s).
```

- Continue with the remaining resources
```shell
terraform state mv 'null_resource.null[1]' 'null_resource.null["b"]'
``` 

- Confirm output is okay
```shell
Move "null_resource.null[1]" to "null_resource.null[\"b\"]"
Successfully moved 1 object(s).
```

- Move the last remaining resource
```shell
terraform state mv 'null_resource.null[2]' 'null_resource.null["c"]'
``` 

- Confirm output is okay
```shell
Move "null_resource.null[2]" to "null_resource.null[\"c\"]"
Successfully moved 1 object(s).
```

NOTE: Notice that for each operation a new file `terraform.tfstate.<id>.backup` will be created automatically in the folder.

- Now check the `terraform plan` operation until there is no change to your infrastructure:
```shell
null_resource.null["a"]: Refreshing state... [id=5588680990575368284]
null_resource.null["c"]: Refreshing state... [id=2537175910110366838]
null_resource.null["b"]: Refreshing state... [id=833659081052874052]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.
```
