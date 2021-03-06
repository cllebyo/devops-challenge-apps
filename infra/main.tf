provider "google" {
  credentials = "${file("account.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

provider "google-beta" {
  credentials = "${file("account.json")}"
  project     = "${var.project_id}"
  region      = "${var.region}"
}

module "devops-challenge-network" {
  source = "./modules/network"
  
  vpc_network_name        = "${var.project_name}-vpc"
  vpc_network_prefix      = "${var.project_name}"
  vpc_network_cidr_block  = "${var.vpc_cdir_range}"
}

module "devops-challenge-database" {
  source = "./modules/database"

  database_vpc_network      = "${module.devops-challenge-network.devops-challenge-vpc}"
  database_vpc_network_cdir = "${var.vpc_cdir_range}"
  database_vpc_private_ip   = "${module.devops-challenge-network.devops-challenge-vpc-global-address}"

  database_server_name      = "${var.project_name}-db"
  database_user_name        = "${var.database_user_name}"
  database_user_pwd         = "${var.database_user_pwd}"
}

# module "devops-challenge-k8s" {
#   source = "./modules/kubernetes"

#   cluster_vpc_network       = "${module.devops-challenge-network.devops-challenge-vpc-name}"

#   cluster_name      = "${var.project_name}-k8s"
#   cluster_user_name = "${var.cluster_user_name}"
#   cluster_user_pwd  = "${var.cluster_user_pwd}"
# }

