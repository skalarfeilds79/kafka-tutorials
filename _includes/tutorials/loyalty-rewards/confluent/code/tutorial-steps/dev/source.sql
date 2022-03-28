CREATE SOURCE CONNECTOR IF NOT EXISTS loyalty_rewards WITH (
  'connector.class'          = 'PostgresSource',
  'name'                     = 'recipe-postgres-loyalty-rewards',
  'kafka.api.key'            = '<my-kafka-api-key>',
  'kafka.api.secret'         = '<my-kafka-api-secret>',
  'connection.host'          = '<database-host>',
  'connection.port'          = '<database-port>',
  'connection.user'          = '<database-user>',
  'connection.password'      = '<database-password>',
  'db.name'                  = '<db-name>',
  'table.whitelist'          = 'users, products, purchases',
  'timestamp.column.name'    = 'created_at',
  'output.data.format'       = 'JSON',
  'db.timezone'              = 'UTC',
  'tasks.max'                = '1'
);
