provider "aws" {
	region = "us-east-1"
}


terraform {
  backend "s3" {
    bucket = "vadim-terraform-state"
    key    = "state/prod/services/webserver-cluster/terraform.tfstate}"
    region = "us-west-2"
  }
}


module "webserver-cluster" {
    source    = "../../../modules/services/webserver-cluster"

    cluster_name	= "webserver-prod"
    db_remote_state_bucket = "vadim-terraform-state"
    db_remote_state_key = "state/prod/data-stores/mysql/terraform.tfstate"

    instance_type = "t2.micro"
    image_id = "ami-059eeca93cf09eebd"
    
    min_size		= 2
    max_size		= 9
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
    scheduled_action_name = "scale-out-during-business-hours"
    min_size            = 2
    max_size            = 10
    desired_capacity    = 10
    recurrence          = "0 9 * * *"

    autoscaling_group_name  = "${module.webserver-cluster.asg_name}"
    
}


resource "aws_autoscaling_schedule" "scale_in_at_night" {
    scheduled_action_name = "scale-in-at-night"
    min_size            = 2
    max_size            = 10
    desired_capacity    = 2
    recurrence          = "0 17 * * *"

    autoscaling_group_name  = "${module.webserver-cluster.asg_name}"
    
}
