def buildAndPushImage(String imageName, String dockerBuildOptions) {
    docker.withRegistry('https://harbor.cloud.infn.it', HARBOR_CREDENTIALS) {
    def dockerImage = docker.build(imageName, dockerBuildOptions)
    dockerImage.push()
    }
}
 
def getReleaseVersion(String tagName) {
    if (tagName) {
        return tagName.replaceAll(/^v/, '')
    } else {
        return null
    }
}
 
pipeline {
 
    agent {
        node { label 'jenkinsworker00' }
    }
    
    environment {
        HARBOR_CREDENTIALS = 'harbor-paas-credentials'
        JHUB_IMAGE_NAME = 'datacloud-templates/snj-base-jhub'
        BASE_LAB_IMAGE_NAME = 'datacloud-templates/snj-base-lab'
        BASE_LAB_GPU_IMAGE_NAME = 'datacloud-templates/snj-base-lab-gpu'
        LAB_PERSISTENCE_IMAGE_NAME = 'datacloud-templates/snj-base-lab-persistence'
        LAB_COLLABORATIVE_IMAGE_NAME = 'datacloud-templates/snj-base-labc'
        LAB_COLLABORATIVE_GPU_IMAGE_NAME = 'datacloud-templates/snj-base-jlabc-gpu'
        COLLABORATIVE_PROXY_IMAGE_NAME = 'datacloud-templates/snj-base-jlabc-proxy'
        NOTEBOOK_IMAGE_NAME = 'datacloud-templates/snj-base-notebook'
        ML_INFN_BASE_LAB_IMAGE_NAME = 'datacloud-templates/ml-infn-lab'
        ML_INFN_LAB_COLLABORATIVE_IMAGE_NAME = 'datacloud-templates/ml-infn-jlabc'
        BASE_LAB_CC7_IMAGE_NAME = 'datacloud-templates/snj-base-lab-cc7'
        CYGNO_LAB_IMAGE_NAME = 'datacloud-templates/cygno-lab'
        CYGNO_LAB_WN_IMAGE_NAME = 'datacloud-templates/cygno-lab-wn'
        JUP_MATLAB_IMAGE_NAME = 'datacloud-templates/jupyter_matlab'
        COLL_MATLAB_IMAGE_NAME = 'datacloud-templates/collaborative_matlab'
        PARAL_MATLAB_IMAGE_NAME = 'datacloud-templates/jupyter_matlab_parallel'
        JAAS_USER_IMAGE_NAME = 'datacloud-templates/jaas_user_containers'
        NAAS_MATLAB_IMAGE_NAME = 'datacloud-templates/naas_matlab'
        NAAS_PARALLEL_IMAGE_NAME = 'datacloud-templates/naas_matlab_parallel'
        SPARK_IMAGE_NAME = 'datacloud-templates/spark'
        JHUB_SPARK_IMAGE_NAME = 'datacloud-templates/jhub-spark'
 
        RELEASE_VERSION = getReleaseVersion(TAG_NAME)
        SANITIZED_BRANCH_NAME = env.BRANCH_NAME.replace('/', '_')
    }
    
    stages {
        stage('Build and Push JaaS User Image') {
            environment {
                IMAGE_NAME = "${JAAS_USER_IMAGE_NAME}:${env.RELEASE_VERSION}"
                DOCKER_BUILD_OPTIONS = "--no-cache -f docker/naas-matlab/jaas-user-containers/jaas_user_containers.Dockerfile docker/naas-matlab/jaas-user-containers"
            }
            steps {
                script {
                    buildAndPushImage(IMAGE_NAME, DOCKER_BUILD_OPTIONS)
                }
            }
        }
    }
    
    post {
        success { echo 'Docker image build and push successful!' }
        failure { echo 'Docker image build and push failed!' }
    }
}
 