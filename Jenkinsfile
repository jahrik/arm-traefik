#!/usr/bin/env groovy

env.CF_ZONE = 'homelab.business'
env.CF_SUBDOMAIN = ''

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
        // Any cleanup operations needed, whether we hit an error or not
      }
    }
  }
}

parallel builders

node('manager') {

  try {
    stage('scm') {
      // Clean workspace
      deleteDir()
      // Checkout the app at the given commit sha from the webhook
      checkout scm
    }

    stage('deploy') {
      withCredentials([usernamePassword(credentialsId: 'cloudflare-api-key',
        usernameVariable: 'CF_API_EMAIL',
        passwordVariable: 'CF_API_KEY')]) {
        echo "Running ${env.BUILD_ID} on ${env.JENKINS_URL}"
        echo "CF_API_EMAIL = ${env.CF_API_EMAIL}"
        // Docker deploy
        sh "make deploy"
      }
    }

  } catch(error) {
    throw error

  } finally {
    // Any cleanup operations needed, whether we hit an error or not

  }
}

          
