#!/usr/bin/env groovy

// labels for Jenkins node types we will build on
def labels = ['armv7l', 'aarch64']
def builders = [:]
for (x in labels) {
  def label = x // Need to bind the label variable before the closure - can't do 'for (label in labels)'

  // Create a map to pass in to the 'parallel' step so we can fire all the builds at once
  builders[label] = {
    node(label) {
      try {

        stage('build') {
          deleteDir()
          checkout scm
          sh "make"
        }

        stage('test') {
        }

        stage('push') {
          sh "make push"
        }

      } catch(error) {
        throw error

      } finally {
      }
    }
  }
}

parallel builders

node('manager') {

  try {
    stage('scm') {
      deleteDir()
      checkout scm
    }

    stage('deploy') {
      withCredentials([
        usernamePassword(credentialsId: 'cloudflare-api-key',
          usernameVariable: 'CF_API_EMAIL',
          passwordVariable: 'CF_API_KEY'),
        string(credentialsId: 'traefik-frontend-rule-traefik',
          variable: 'TRAEFIK_FRONTEND_RULE'),]) {
            echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
            sh "make deploy"
        }
    }

  } catch(error) {
    throw error

  } finally {

  }
}
