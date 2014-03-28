class jetty (
  $host = "0.0.0.0",
  $port = 8080,
  $jetty_args = "",
  $jetty_memory = 256,
  $jetty_user = "jetty",
  $jetty_verbose = "yes",
  $java_opts = "",
  ){

  # Might move this to it's own class later..
  package { 'openjdk-6-jdk':
    ensure => installed,
  }

  package { 'jetty':
    ensure  => latest,
    require => Package['openjdk-6-jdk'],
  }

  package { 'libjetty-extra':
    ensure  => installed,
    require => Package['jetty'],
  }

  service { 'jetty':
    ensure  => running,
    enable  => true,
    require => Package['jetty'],
  }

  file { '/etc/default/jetty':
    mode    => 0444,
    content => template('jetty/default.erb'),
    notify  => Service['jetty'],
  }

  Package { require => Exec['apt-get update'] }
}
