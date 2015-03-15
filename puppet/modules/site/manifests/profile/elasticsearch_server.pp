class site::profile::elasticsearch_server {
  include elasticsearch

  elasticsearch::instance { 'es-01': }

  elasticsearch::plugin{'lmenezes/elasticsearch-kopf':
    module_dir => 'kopf',
    instances  => 'es-01'
  }

  include logstash

  logstash::configfile { 'input':
    content => 'input { collectd {} }'
  }

  logstash::configfile { 'output':
    content => 'output { elasticsearch { host => localhost }}'
  }
}