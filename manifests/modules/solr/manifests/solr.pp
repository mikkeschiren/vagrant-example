class solr(
  $solr_home = "/opt/solr",
  $webapps_dir = "/usr/share/jetty/webapps",
  $server = "jetty",
  $cores = [ "core0" ],
  $user = "jetty",
  ){

  # WHY????: This is actually a 'good' idea, since we know which version we
  # utilize etc, sadly this require us to bundle it like this.
  file { "${webapps_dir}/solr.war":
    ensure => present,
    owner => $user,
    source => 'puppet:///modules/solr/solr-3.6.2.war',
    require => Class["${server}"],
  }

  file { "${solr_home}/solr.xml":
    ensure  => present,
    owner => $user,
    content => template("solr/solr.xml.erb"),
    require => File["${solr_home}"],
    notify  => Service["${server}"],
  }

  file { "${solr_home}":
    owner => $user,
    ensure => directory,
  }
}
