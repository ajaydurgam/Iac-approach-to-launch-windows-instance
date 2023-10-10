variable "windowsconfig" {
  type = map(string)
  default = {
    region     = "us-east-1e"
    vpc        = "vpc-06f584a255a8ccdaf"
    ami        = "ami-037faf8d69ffcc8ec"
    itype      = "t2.xlarge"
    subnet     = "subnet-0971126764e26e3c8"
    publicip   = true
    keyname    = "default-keypair"
    secgroupid = "NA"
    size       = "100"
    type       = "gp2"
    devicename = "/dev/sdh"
    count      = "1"
  }
}
