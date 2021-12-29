dockerRegistry = "https://registry.hub.docker.com/"
dockerRepo = "benbense/kandula-app"
dockerVer = "v1.0"
jenkinsCredID = "dockerhub-benbense"
githubRepo = "benbense/kandula-project-app.git"
githubCredID = "github-benbense"
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
}