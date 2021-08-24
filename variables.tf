
variable "tenancy_ocid" {
}

variable "user_ocid" {
}

variable "fingerprint" {
}

variable "private_key_path" {
}

variable "region" {
}

variable "ad_region_mapping" {
  type = map(string)

  default = {
    sa-saopaulo-1 = 1
  }
}

variable "ssh_public_key" {
  type = string
}

variable "images" {
  type = map(string)

  default = {
    arm = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa6tu6jsuqnm6ulb4ppgos54xng6qndg3rhd5sw2ertqef4tdxhknq"
    amd = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaaocax5uxxfuum6rgpnlymsustzdcdejilsrnxkc2cgt4mmg3fbsnq"
  }
}
