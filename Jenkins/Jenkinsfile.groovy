properties([parameters([choice(choices: ['disabled','enabled'], name: 'deploy', description: 'Should Deploy the Knadula🐘 app?')])])
dockerRegistry = "https://registry.hub.docker.com/"
dockerRepo = "benbense/kandula-app"
dockerVer = "v1.0"
jenkinsCredID = "dockerhub-benbense"
githubRepo = "benbense/kandula-project-app.git"
githubCredID = "github-benbense"

echo "Deploy is: ${params.deploy}"

node(label: "docker"){
    stage('Clone Kandula App Repo to Worker Node') {
        script {
            git credentialsId: "${githubCredID}", url: "git@github.com:${githubRepo}"
        }
    }
    stage("Build Dockerfile") {
        dockerImage = docker.build("${dockerRepo}:${dockerVer}")
    }
    stage("Docker Push") {
        docker.withRegistry("${dockerRegistry}", "${jenkinsCredID}") {
            dockerImage.push()
        }
    }

    if (deploy.equals("enabled")) {
        stage ("Create K8s Deployment file"){
        dep = sh """
                tee dep.yaml <<-'EOF'
                apiVersion: apps/v1
                kind: Deployment
                metadata:
                  name: kanduka-app-deployment
                  annotations:
                    kubernetes.io/change-cause: "First deploy of Kandula app"
                spec:
                  replicas: 1
                  selector:
                    matchLabels:
                      app: kandula-app
                  template:
                    metadata:
                      labels:
                        app: kandula-app
                    spec:
                      containers:
                        - name: kuard
                          image: benbense/kandula-app:v1.0
                          env:
                            - name: FLASK_ENV
                              value: "development"
                            - name: AWS_ACCESS_KEY_ID
                              value: ""
                            - name: AWS_SECRET_ACCESS_KEY
                              value: ""
                            - name: AWS_DEFAULT_REGION
                              value: ""
                          ports:
                            - containerPort: 8080
                              name: http
                              protocol: TCP
            """
    }
    stage ('K8S Deploy') {
                kubernetesDeploy(
                    configs: 'dep.yaml',
                    kubeconfigId: 'k8s-tfe',
                    enableConfigSubstitution: true
                    )               
        }
    }
}

