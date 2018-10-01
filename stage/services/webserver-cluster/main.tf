provider "aws" {
	region = "us-west-2"
}


terraform {
  backend "s3" {
    bucket = "vadim-terraform-state"
    key    = "state/stage/services/webserver-cluster/terraform.tfstate}"
    region = "us-west-2"
  }
}


module "webserver-cluster" {
//      source = "git::git@github.com:vek64/modules.git//services/webserver-cluster?ref=v0.0.//3"
//      source = "git::git@github.com:vek64/modules.git//services/webserver-cluster"

    source    = "../../../../modules/services/webserver-cluster"

    cluster_name	= "webserver-stage"
    db_remote_state_bucket = "vadim-terraform-state"
    db_remote_state_key = "state/stage/data-stores/mysql/terraform.tfstate"

    server_text = "New server STAGE"

    instance_type = "t2.micro"
    ami = "ami-0e32ec5bc225539f5"

    min_size		= 2
    max_size		= 3
    enable_autoscaling = false
}

