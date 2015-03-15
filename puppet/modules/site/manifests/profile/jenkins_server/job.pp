define site::profile::jenkins_server::job (
  $scm_url,
  $scm_type = 'git',
  $jobname  = $title,
  $ensure   = 'present',
){
  if $scm_type == 'git' {
    $template = template("site/jenkins_server_config_watcher_job_git.xml.erb")
  } elsif $scm_type == 'svn' {
    $template = template("site/jenkins_server_config_watcher_job_svn.xml.erb")
  } else {
    fail("Unsupported SCM type: $scm_type")
  }

  jenkins::job { $title:
    config   => $template,
    jobname  => $jobname,
    enabled  => 1,
    ensure   => $ensure,
  }
}
