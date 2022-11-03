# Interview helper code
This repo holds example code I use when interviewing candidates for SRE positions.

------------


# Terraform questions
Questions:
- What is this terraform doing in general?
- How can this be more secure/hardened?  (EC2's shouldn't have public ips, put them in a private subnet, shouldn't use port 80, aws creds in vars file, )
- What credentials are used when running this terraform?
- What role are the instances assuming in this, and what policy does that map to?
- Do the EC2's have public ips? or are they just private?
- This terraform has been run before.. can you tell me what ended up being the VPC route table id for that run?
- What's the cidr of the VPC created?
- What's the max size of the autoscaling group that was created?
- What improvements would you make to this terraform?
- What's one thing that would need to change if we were to upgrade this terraform to 1.x?
- What are the outputs of this terraform, and why do you think they were set up as outputs?


------------

# Helm-Docker-Python questions
- What are these files trying to do ?
- What is the yaml file for?
- How could the Dockerfile be improved/hardened
- What is sendmetrics.py doing?


------------

# Bash/Sh script questions
- Tell me what each of these scripts are doing