# How to gernereate Azure VM with Template
1. Open Azure cloud
2. Go to the Marketplace
3. Search Template Deployment
4. Click on "Create"
5. Select the option "Build your own template in editor"
6. Load the files "template.json" and save
7. update the parameter with the file "parameters.json"
8. Define the resource group and password
9. Define the DSN name after creating of the VM (you need this for ssh conn)
10. SSH to Connect to a VM Server
11. Install k8s,java,maven and another tools in vm `bash ./install.sh`