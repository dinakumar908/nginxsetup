# nginxsetup

Pre-requisites:

AWS Account

github account

Provison a server in AWS

1. Installing Java

 yum install -y java-1.8.0-openjdk

2. Installing jenkins (jenkins.io)
 sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
 sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
 service jenkins start

3. Installing Terraform (terraform.io)
 wget https://releases.hashicorp.com/terraform/1.0.0/terraform_1.0.0_linux_amd64.zip
 unzip terraform_1.0.0_linux_amd64.zip
 cp terraform /usr/bin
 
4. Install Git in same machine
  sudo yum install git -y
  
Once All installations completed

Login to Jenkins and provide key and let it configure with plugins

Required plugins:
Terraform

5. create a job with pipeline and add this pipe line and run the job:

provide your keypair details

pipeline{
    agent any
        tools {
  terraform 'Terraform_v1.0.0'
}
 
stages{
    stage('Git checkout'){
        steps{
         git branch: 'main', credentialsId: 'gitaccess', url: 'https://github.com/dinakumar908/nginxsetup.git'   
        }
    }
    stage('Terraform initialization'){
        steps{
           sh 'terraform init' 
        }
    }
	
	stage('Terraform plan'){
	  steps{
	  withCredentials([sshUserPrivateKey(credentialsId: 'keypair1', keyFileVariable: 'keypair', passphraseVariable: 'keypair.pem', usernameVariable: 'ec2-user')]) {
	  sh 'terraform plan'
	  }
	}
	stage('Terraform provisioning){
	  steps{
	  withCredentials([sshUserPrivateKey(credentialsId: 'keypair1', keyFileVariable: 'keypair', passphraseVariable: 'keypair.pem', usernameVariable: 'ec2-user')]) {
	  sh 'terraform apply --auto-approve'
	  }
	}
	}
	}


