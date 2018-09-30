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
<<<<<<< HEAD
      source = "git::git@github.com:vek64/modules.git//services/webserver-cluster?ref=v0.0.3"
=======
      source = "git::git@github.com:vek64/modules.git//services/webserver-cluster"
>>>>>>> 8938d8aa0733f628fd8f2f0cc163c10c3e24e196

//    source    = "../../../modules/services/webserver-cluster"

    cluster_name	= "webserver-stage"
    db_remote_state_bucket = "vadim-terraform-state"
    db_remote_state_key = "state/stage/data-stores/mysql/terraform.tfstate"

    instance_type = "t2.micro"
    image_id = "ami-0e32ec5bc225539f5"

    min_size		= 2
    max_size		= 3
<<<<<<< HEAD
=======
    enable_autoscaling = false
>>>>>>> 8938d8aa0733f628fd8f2f0cc163c10c3e24e196
}

