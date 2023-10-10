variable "windowsconfig" {
  type = map(string)
  default = {
    region     = "us-east-1"
    vpc        = "vpc-06f584a255a8ccdaf"
    ami        = "ami-0be0e902919675894"
    itype      = "t2.xlarge"
    subnet     = "subnet-037d616a52ee725e1"
    publicip   = true
    keyname    = "default-keypair"
    secgroupid = "NA"
    size       = "100"
    type       = "gp2"
    devicename = "/dev/sdh"
    count      = "1"
  }
}