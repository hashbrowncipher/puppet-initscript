class initscript::params {
  if $::operatingsystem == 'Ubuntu' {
    if versioncmp($::lsbdistrelease, '8.04') < 1 {
      $init_style = 'sysv_debian'
    } elsif versioncmp($::lsbdistrelease, '14.10') < 1 {
      $init_style = 'upstart'
    } else {
      $init_style = 'systemd'
    }
  } elsif $::operatingsystem =~ /Scientific|CentOS|RedHat|OracleLinux/ {
    if versioncmp($::operatingsystemrelease, '6.0') < 0 {
      $init_style = 'sysv_redhat'
    } elsif versioncmp($operatingsystemrelease, '7.0') < 0 {
      $init_style = 'upstart'
      $is_centos_upstart = true
    } else {
      $init_style = 'systemd'
    }
  } elsif $::operatingsystem == 'Fedora' {
    if versioncmp($::operatingsystemrelease, '12') < 0 {
      $init_style = 'sysv_redhat'
    } else {
      $init_style = 'systemd'
    }
  } elsif $::operatingsystem == 'Debian' {
    $init_style = 'sysv_debian'
  } elsif $::operatingsystem == 'SLES' {
    $init_style = 'sysv_sles'
  } elsif $::operatingsystem == 'Darwin' {
    $init_style = 'launchd'
  } elsif $::operatingsystem == 'Amazon' {
    $init_style = 'sysv_redhat'
  } else {
    $init_style = undef
  }

  if getvar('is_centos_upstart') {
    $start = "initctl start '%s'"
    $stop = "initctl stop '%s'"
    $status = "initctl status '%s' | grep -q '/running'"
  } else {
    $start = undef
    $stop = undef
    $status = undef
  }

  $ulimit_switches = {
    'as'         => 'v',
    'core'       => 'c',
    'cpu'        => 't',
    'data'       => 'd',
    'fsize'      => 'f',
    'locks'      => 'x',
    'memlock'    => 'l',
    'msgqueue'   => 'q',
    'nproc'      => 'u',
    'nofile'     => 'n',
    'nice'       => 'e',
    'rtprio'     => 'r',
    'rss'        => 'm',
    'sigpending' => 'i',
    'stack'      => 's',
  }
}
