Ansible is an automation tool for managing and configuring servers and applications.

Agentless: You don’t need to install any software on target machines, just SSH access.

Declarative: You write playbooks (YAML files) describing what you want your infrastructure or apps to look like.

Idempotent: Running the same playbook multiple times won't cause issues; it only makes changes if needed.

How Ansible Works — Basic Flow
Control Machine: You run Ansible from your laptop or a management server.

Inventory: A list of hosts (like your EC2 instances) that Ansible manages.

Modules: Ansible has modules to run commands, copy files, install packages, start services, deploy Docker containers, etc.

Playbook: YAML file that lists tasks to run on your target hosts.

Execution: Ansible connects via SSH, runs modules/tasks, and returns results.

Outcome: Servers are configured or apps deployed automatically.

 How Automation Works in Your Docker + EC2 Project
You have:

An EC2 instance running Ubuntu.

Docker installed.

Your app (PHP Yii2) deployed inside a Docker stack.

Networking and firewall settings adjusted (security groups for port 8000).

Troubleshooting for connectivity issues.

Why Automate This with Ansible?
Manually logging in, installing Docker, configuring firewall, deploying stack is error-prone and time-consuming.

Ansible can:

Provision EC2 (with extra tools or scripts)

Install Docker engine and Docker Compose

Deploy your Docker stack with commands (docker stack deploy ...)

Manage firewall rules (AWS security groups + local firewall)

Set up reverse proxy (nginx) for SSL termination

Monitor and troubleshoot

Step-by-Step Automation Flow with Ansible (Example)
Step 1: Define Inventory (list your hosts)
Step 2: Write Playbook to Install Docker
Step 3: Write Playbook to Deploy Your Docker Stack
Step 4: Write Playbook for Firewall and Nginx Setup
Step 5: Run Ansible Playbooks

Roles: lists the roles to execute in order:

docker → install Docker & Docker Compose, init swarm

nginx → install NGINX, configure reverse proxy

app → clone your GitHub repo and deploy the Docker Swarm stack

Why?
This playbook is the “recipe” that Ansible follows. Under the hood, each role has its own tasks.

Local Setup (WSL/Ubuntu)

Install Ansible & Git

Clone this repo

Ensure inventory.ini points to your EC2 IP & SSH key

Run Ansible

bash
Copy
Edit
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
→ Automatically:

Installs Docker & Compose on EC2

Initializes Swarm

Installs NGINX & deploys reverse proxy config

Clones the repo on EC2

Runs docker stack deploy to launch your Yii2 container

Manual Once-Off

Check in browser: http://<EC2_IP>/ → Should see Yii2 “Congratulations” page.

Future Code Changes → Push to GitHub

git add .
git commit -m "New change"
git push origin main

→ Triggers GitHub Actions →

Builds new Docker image → pushes to Docker Hub

SSH into EC2 → updates Swarm service → new container spins up
→ Visit http://<EC2_IP>/ to see updated app.
![image](https://github.com/user-attachments/assets/5df6b133-61d9-4c18-a7ad-16ae28a146df)

