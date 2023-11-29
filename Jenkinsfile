pipeline {
    agent any
    
    environment {
        MONGODB_URI_CREDENTIAL = credentials('mongo')
        BACKUP_DATE = new Date().format('dd-MM-yyyy')
        BACKUP_PATH = "/bitnami/jenkins/home/MongoDB/"
        BACKUP_DIRECTORY = "backup_${BACKUP_DATE}"
        REMOTE_DIRECTORY = "/home/user/Backup/"
        REMOTE_SERVER = "${ServerIP}"
        REMOTE_USERNAME = "${ServerUserName}"
    }

    stages {
        stage('MongoDB Backup') {
            steps {
              withCredentials([usernamePassword(credentialsId: 'Mongo_Backup', passwordVariable: 'MONGODB_PASSWORD', usernameVariable: 'MONGODB_USERNAME')]) {
                  script {
                    // def backupDirectory = "backup_${BACKUP_DATE}"
                    sh "cd /bitnami/jenkins/home/MongoDB/ && mongodump --uri=mongodb+srv://${MONGODB_USERNAME}:${MONGODB_PASSWORD}@mongo.D5skb.mongodb.net/mongo --ssl --db=mongo  --out=${BACKUP_DIRECTORY}"
                    // sh "tar -czf ${BACKUP_PATH}.tar.gz -C ${BACKUP_PATH} ."
                    // sh "rm -rf ${BACKUP_PATH}"
                    sh "tar -czf ${BACKUP_PATH}/${BACKUP_DIRECTORY}.tar.gz -C ${BACKUP_PATH} ${BACKUP_DIRECTORY}"
                    sh "rm -rf ${BACKUP_PATH}/${BACKUP_DIRECTORY}"
                }
            }
          }
        }
        stage('SCP Transfer') {
            steps {
                script {
                    sh """
                        scp -o StrictHostKeyChecking=yes -o UserKnownHostsFile=~/.ssh/known_hosts \${BACKUP_PATH}/${BACKUP_DIRECTORY}.tar.gz \${REMOTE_USERNAME}@\${REMOTE_SERVER}:\${REMOTE_DIRECTORY}
                    """
                }
            }
        }
        stage('Delete Local Backup') {
            when {
                expression { currentBuild.resultIsBetterOrEqualTo('SUCCESS') }
            }
             steps {
                script {
                    sh "rm -f ${BACKUP_PATH}/${BACKUP_DIRECTORY}.tar.gz"
                }
            }
        }
    }
    post {
        success {
            echo 'MongoDB backup successful!'
        }
        failure {
            echo 'MongoDB backup failed!'
        }
    }
}
