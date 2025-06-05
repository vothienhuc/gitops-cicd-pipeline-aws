pipeline{
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ECR_REGISTRY = '339007232055.dkr.ecr.us-east-1.amazonaws.com'
        ECR_REPOSITORY = 'my-ecr'
        IMAGE_TAG = "${env.BUILD_ID}"
        GIT_REPO = 'https://github.com/mahmoud254/jenkins_nodejs_example.git'
    }
    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning...'
                git url: "${GIT_REPO}", branch: 'master'
            }
        }
        stage('Install Docker') {
            steps {
                echo 'Installing docker...'
                sh '''
                apt-get update
                apt-get install -y docker.io
                systemctl start docker
                systemctl enable docker
                '''
            }
        }
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build("${ECR_REPOSITORY}:${IMAGE_TAG}", "--build-arg AWS_REGION=${AWS_REGION} .")
                }
            }
        }
        stage('Push to ECR') {
            steps {
                echo 'Pushing To ECR...'
                withAWSCredentials('aws-credentials') {
                    script {
                        sh "aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}"
                        sh "docker tag ${ECR_REPOSITORY}:${IMAGE_TAG} ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}"
                        sh "docker push ${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }
}