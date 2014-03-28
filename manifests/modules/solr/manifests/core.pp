define solr::core(
  $solr_home = "/opt/solr",
  $schema_xml = "searchapi_schema.xml",
  $solrconfig_xml = "searchapi_solrconfig.xml",
  $user = 'jetty'
  ) {

  file { "${solr_home}/${name}":
    ensure  => directory,
    owner => $user,
    require => Class['solr'],
  }

  file { "${solr_home}/${name}/conf":
    ensure  => directory,
    owner => $user,
    require => File["${solr_home}/${name}"],
  }

  file { "${solr_home}/${name}/conf/schema.xml":
    ensure  => present,
    owner => $user,
    source  => "puppet:///modules/solr/cores/${schema_xml}",
    require => File["${solr_home}/${name}/conf"],
  }

  file { "${solr_home}/${name}/conf/solrconfig.xml":
    ensure  => present,
    owner => $user,
    source  => "puppet:///modules/solr/cores/${solrconfig_xml}",
    require => File["${solr_home}/${name}/conf"],
  }

  file { "${solr_home}/${name}/conf/protwords.txt":
    ensure  => present,
    owner => $user,
    source  => "puppet:///modules/solr/cores/protwords.txt",
    require => File["${solr_home}/${name}/conf"],
  }

  file { "${solr_home}/${name}/conf/solrcore.properties":
    ensure  => present,
    owner => $user,
    source  => "puppet:///modules/solr/cores/solrcore.properties",
    require => File["${solr_home}/${name}/conf"],
  }

  file { "${solr_home}/${name}/conf/elevate.xml":
    ensure  => present,
    owner => $user,
    source  => "puppet:///modules/solr/cores/elevate.xml",
    require => File["${solr_home}/${name}/conf"],
  }

  file { "${solr_home}/${name}/conf/mapping-ISOLatin1Accent.txt":
    ensure  => present,
    owner => $user,
    source  => "puppet:///modules/solr/cores/mapping-ISOLatin1Accent.txt",
    require => File["${solr_home}/${name}/conf"],
  }

  file { "${solr_home}/${name}/conf/stopwords.txt":
    ensure  => present,
    owner => $user,
    source  => "puppet:///modules/solr/cores/stopwords.txt",
    require => File["${solr_home}/${name}/conf"],
  }

  file { "${solr_home}/${name}/conf/synonyms.txt":
    ensure  => present,
    owner => $user,
    source  => "puppet:///modules/solr/cores/synonyms.txt",
    require => File["${solr_home}/${name}/conf"],
  }
}
