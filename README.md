# ticket-136331
Change from count to for_each test repository



```shell
terraform init
```

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

```shell
terraform state list
```

Output of `terraform state list`
```shell
null_resource.null[0]
null_resource.null[1]
null_resource.null[2]
```
