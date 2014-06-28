default['nginx']['worker_processes']   = cpu[:total]
default['nginx']['worker_connections'] = 2048
default['nginx']['keepalive_timeout']  = 65
default['nginx']['gzip_types'] = [
  "text/plain",
  "text/css",
  "application/x-javascript",
  "application/json",
  "text/xml",
  "application/xml",
  "application/xml+rss",
  "text/javascript",
  "image/png",
  "image/gif",
  "image/jpeg"
]

default['nginx']['server_name'] = 'app.dev'
