class site::profile::infrastructure::jenkins::plugins {

  jenkins::plugin {
    "ansicolor" : # https://wiki.jenkins-ci.org/display/JENKINS/AnsiColor+Plugin
      version => "0.4.1";
    "antisamy-markup-formatter" :
      version => "1.3";
    "build-pipeline-plugin" : # https://wiki.jenkins-ci.org/display/JENKINS/Build+Pipeline+Plugin
      version => "1.4.5";
    "categorized-view" : # https://wiki.jenkins-ci.org/display/JENKINS/Categorized+Jobs+View
      version => "1.8";
    "chucknorris" :
      version => "0.5";
    "credentials" :
      version => "1.22";
    "cvs" : # https://wiki.jenkins-ci.org/display/JENKINS/CVS+Plugin
      version => "2.12";
    "dashboard-view" : # https://wiki.jenkins-ci.org/display/JENKINS/Dashboard+View
      version => "2.9.4";
    "git" :
      version => "2.3.4";
    "git-client" :
      version => "1.15.0";
    "git-parameter" :
      version => "0.4.0";
    "greenballs" :
      version => "1.14";
    "javadoc" : # https://wiki.jenkins-ci.org/display/JENKINS/Javadoc+Plugin
      version => "1.3";
    "jira" : #https://wiki.jenkins-ci.org/display/JENKINS/JIRA+Plugin
      version => "1.39";
    "job-dsl" : # https://wiki.jenkins-ci.org/display/JENKINS/Job+DSL+Plugin
      version => "1.28";
    "jquery" : #https://wiki.jenkins-ci.org/display/JENKINS/jQuery+Plugin
      version => "1.7.2-1";
    "junit" : # https://wiki.jenkins-ci.org/display/JENKINS/JUnit+Plugin
      version => "1.3";
    "ldap" : # https://wiki.jenkins-ci.org/display/JENKINS/LDAP+Plugin
      version => "1.11";
    "mailer" :
      version => "1.13";
    "matrix-auth" :
      version => "1.2";
    "matrix-project" :
      version => "1.4";
    "maven-plugin" :
      version => "2.8";
    "nested-view" :
      version => "1.14";
    "pam-auth" :
      version => "1.2";
    "parameterized-trigger" :
      version => "2.25";
    "publish-over-ssh" :
      version => "1.12";
    "scm-api" :
      version => "0.2";
    "sonar" : # https://wiki.jenkins-ci.org/display/JENKINS/Sonar+plugin
      version => "2.1";
    "subversion" : # https://wiki.jenkins-ci.org/display/JENKINS/Subversion+Plugin
      version => "2.5";
    "ssh-credentials" :
      version => "1.10";
    "translation" : # https://wiki.jenkins-ci.org/display/JENKINS/Translation+Assistance+Plugin
      version => "1.12";
  }

  file { "/var/lib/jenkins/hudson.plugins.sonar.SonarPublisher.xml":
    content => template("site/hudson.plugins.sonar.SonarPublisher.xml.erb"),
    require => Package['jenkins'],
    notify  => Service['jenkins'],
  }
  file { "/var/lib/jenkins/hudson.plugins.sonar.SonarRunnerInstallation.xml":
    content => template("site/hudson.plugins.sonar.SonarRunnerInstallation.xml.erb"),
    require => Package['jenkins'],
    notify  => Service['jenkins'],
  }
}