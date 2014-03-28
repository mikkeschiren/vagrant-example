class phpmyadmin () {
  package { 'phpmyadmin':
    ensure => installed,
  }

  file { "/etc/phpmyadmin/apache.conf":
    owner => root,
    group => root,
    mode  => 0444,
    source => 'puppet:///modules/phpmyadmin/apache.conf',
  }
  file { '/etc/apache2/conf.d/phpmyadmin.conf':
    ensure => 'link',
    target => '/etc/phpmyadmin/apache.conf',
  }
}
