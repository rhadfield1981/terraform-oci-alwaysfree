# Project to create OCI Object Storage and S3 authentication for Terraform Remote State
---
### Run this prior to the main project if you wish to utilise a remote statefile.
---
  
* This project makes use of a secret key to emulate bucket access in the same manner as AWS S3 storage.  
* Note that providers.tf will need to reflect the values created within this project

This project has followed the information outlined [here](https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformUsingObjectStore.htm)

Please create a credentials file at **~/.oci/credentials** as per the above guide such that it looks similar to the following:  
`[default]    `<br />
`aws_access_key_id=ocid1.credential.oc1..exampleuniqueID`
`aws_secret_access_key=mSTdaWThisIsAnExampleDoNotCopyMe52xlImWjayJLJ6OH9A=`

### Why use a remote state file?   
The main advantage of a remote state file is that it allows collaboration with multiple developers able to work on the terraform code.  A secondary benefit is that the statefile persists seperately from the code and will survive any local catastrophies that might otherwise destroy the statefile.

Unfortunately Oracle Cloud does not support a means for remote state locking with bucket storage.  There is an Oracle product ***Resource Manager*** that supports remote state and locking however this is beyond the scope of this project, more information can be found [here](https://www.oracle.com/uk/devops/resource-manager/)

Terraform outlines the benefits of remote statefiles [here](https://www.terraform.io/language/state/remote)




