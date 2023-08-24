pipeline {
    agent any 


    parameters {
        choice(
            choices: ['plan', 'apply', 'show', 'preview-destroy', 'destroy'],
            description: 'Terraform action to apply',
            name: 'action')

        string(defaultValue: "ap-south-1", description: 'aws region', name: 'AWS_REGION')
        
    }
    stages {
        stage('init') {
            steps {
                withAWS(credentials: 'awstflab', region: 'ap-south-1')
                 {
                    sh 'terraform init -no-color'
                }
            }
        }
        stage('validate') {
            steps {
                withAWS(credentials: 'awstflab', region: 'ap-south-1'){
                sh 'terraform validate -no-color'
                }
            }
        }
        stage('plan') {
            when {
                expression { params.action == 'plan' || params.action == 'apply' }
            }
            steps {
                 withAWS(credentials: 'awstflab', region: 'ap-south-1'){
                sh 'terraform plan -no-color -input=false -out=tfplan'
                 }
            }
        }
        stage('approval') {
            when {
                expression { params.action == 'apply'}
            }
            steps {
                 withAWS(credentials: 'awstflab', region: 'ap-south-1')
                 {
                sh 'terraform show -no-color tfplan > tfplan.txt'
                 }
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Apply the plan?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }
        stage('apply') {
            when {
                expression { params.action == 'apply' }
            }
            steps {
                 withAWS(credentials: 'awstflab', region: 'ap-south-1'){
                sh 'terraform apply -no-color -input=false tfplan'
                 }
            }
        }
        stage('show') {
            when {
                expression { params.action == 'show' }
            }
            steps {
                 withAWS(credentials: 'awstflab', region: 'ap-south-1'){
                sh 'terraform show -no-color'
                 }
            }
        }
        stage('preview-destroy') {
            when {
                expression { params.action == 'preview-destroy' || params.action == 'destroy'}
            }
            steps {
                 withAWS(credentials: 'awstflab', region: 'ap-south-1'){
                sh 'terraform plan -no-color -destroy -out=tfplan '
                sh 'terraform show -no-color tfplan > tfplan.txt'
                 }
            }
        }
        stage('destroy') {
            when {
                expression { params.action == 'destroy' }
            }
            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Delete the stack?",
                    parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
                 withAWS(credentials: 'awstflab', region: 'ap-south-1'){
                sh 'terraform destroy -no-color -force '
                 }
            }
        }
    }
}