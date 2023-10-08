variable "windowsconfig" {
  type = map(string)
  default = {
    region     = "ap-southeast-2"
    vpc        = "vpc-0047bb15d5c383ca3"
    ami        = "ami-0b79ab0b8cfba7ecd"
    itype      = "t2.xlarge"
    subnet     = "subnet-0971126764e26e3c8"
    publicip   = true
    keyname    = "default-keypair"
    secgroupid = "sg-0827481a9ae9805b4"
    size       = "100"
    type       = "gp2"
    devicename = "/dev/sdh"
    count      = "1"
  }
}
