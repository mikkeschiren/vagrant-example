class systools (
  $packages = [
    'emacs23-nox',
    'puppet-el',
    'htop',
    'git-core',
    'curl',
    'aptitude',
    'python-software-properties'
  ]
) {
  package { $packages:
    ensure => latest,
  }
  exec { 'apt-get update':
    command => "/usr/bin/apt-get update"
  }
  Package { require => Exec['apt-get update'] }
}
