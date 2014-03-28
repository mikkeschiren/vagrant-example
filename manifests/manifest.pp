# Our used Puppet modules and settings
class { 'systools': }
class { 'apache':
    port => 8081
}
class { 'php':
  development => true
}
class { 'drush': }
class { 'varnish': }
class { 'phpmyadmin': }
class { 'postfix': }
class { 'memcached':
  max_memory => '30%',
}

class { 'mysql':
  local_only     => true,
  hostname => $fqdn
}

apache::vhost { "drupal":
  document_root => $drupal_root
}
