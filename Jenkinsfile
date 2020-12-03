pipeline {
  agent any

  stages {
    stage('Create project') {
      steps {
        deleteDir() // clean up workspace
        checkout([$class: 'GitSCM', branches: [[name: '*/master']],
          doGenerateSubmoduleConfigurations: false,
          extensions: [[$class: 'SubmoduleOption',
            disableSubmodules: false,
            parentCredentials: false,
            recursiveSubmodules: true,
            reference: '',
            trackingSubmodules: true]],
          submoduleCfg: [],
          userRemoteConfigs: [[
            url: 'https://github.com/mseker94/project_1']]])
      sh 'source /tools/Xilinx/Vivado/2019.2/settings64.sh && cd vivado && vivado -mode batch -source create_vivado_proj.tcl'
      }
    }
    stage('Run simulation') {
      steps {
        sh 'source /tools/Xilinx/Vivado/2019.2/settings64.sh && cd vivado && vivado -mode batch -source run_simulation.tcl'
      }
    }
    stage('Run synthesis') {
      steps {
        sh 'source /tools/Xilinx/Vivado/2019.2/settings64.sh && cd vivado && vivado -mode batch -source run_synthesis.tcl'
      }
    }
    stage('Run implementation') {
      steps {
        sh 'source /tools/Xilinx/Vivado/2019.2/settings64.sh && cd vivado && vivado -mode batch -source run_implementation.tcl'
      }
    }
    stage('Generate bitstream') {
      steps {
        sh 'source /tools/Xilinx/Vivado/2019.2/settings64.sh && cd vivado && vivado -mode batch -source generate_bitstream.tcl'
      }
    }
  }
  post {
    failure {
      emailext attachLog: true,
      body: '''Project name: $PROJECT_NAME
Build number: $BUILD_NUMBER
Build Status: $BUILD_STATUS
Build URL: $BUILD_URL''',
      recipientProviders: [culprits()],
      subject: 'Project \'$PROJECT_NAME\' is broken'
    }
  }
}
