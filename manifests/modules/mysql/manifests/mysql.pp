class mysql (
  $module_root = 'puppet:///modules/mysql/',
  $packages = [
    'mysql-common',
    'mysql-server'
  ],
  $conf_files = [
    'conf.d/char.cnf',
    'conf.d/innodb.cnf',
  ],
  $password = 'password',
  $hostname = 'test.nod',
  $local_only = true,
) {
  package { $packages:
    ensure => installed,
    # We need to have innodb settings in place before installation.
    require => File['/etc/mysql/conf.d/innodb.cnf']
  }

  service { mysql:
    enable    => true,
    ensure    => running,
    subscribe => Package['mysql-server'],
  }

  exec { 'mysqladmin password':
    unless => "mysqladmin -uroot -p${password} status",
    path => ['/bin', '/usr/bin'],
    command => "mysqladmin -uroot password ${password}",
    require => Service['mysql'],
  }

  file { "/etc/mysql":
    ensure => directory
  }

  file { "/etc/mysql/conf.d":
    ensure => directory
  }
  
  define conf_file() {
    file { "/etc/mysql/${name}":
      owner => root,
      group => root,
      mode => 0444,
      source => "puppet:///modules/mysql/${name}",
      require => [File["/etc/mysql"],File["/etc/mysql/conf.d"]]
    }
  }

  conf_file { $conf_files:
  }

  if ! $local_only {
    file { '/etc/mysql/dbnode-my.cnf':
      owner  => root,
      group  => root,
      mode   => '0444',
      source => 'puppet:///modules/mysql/dbnode-my.cnf',
      path   => '/etc/mysql/my.cnf',
      notify => Service['mysql']
    }
  }
}
