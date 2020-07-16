Jenkins will need installed on slave:

* Inspec
* Packer 
* Docker

Still to add

* gke-anthos binary into docker image

To run on local machine install:

* Inspec
* Packer 
* Docker

run the below

packer build -var-file=variables.json packer.json

If using AWS ECR use the below for vars for docker push:

https://www.packer.io/docs/post-processors/docker-push

Investigated HCL packer but no support for inspec provisioner and other functionality missing
