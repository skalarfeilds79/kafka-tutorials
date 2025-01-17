CREATE SOURCE CONNECTOR IF NOT EXISTS CLICKS WITH (
    'connector.class'             = 'io.mdrogalis.voluble.VolubleSourceConnector',
    'key.converter'               = 'org.apache.kafka.connect.storage.StringConverter',
    'genkp.clicks.with'           = '#{Number.randomDigit}',
    'attrkp.clicks.null.rate'     = 1,
    'genv.clicks.source_ip.with'  = '#{Internet.ipV4Address}',
    'genv.clicks.host.with'       = '#{Internet.url}',
    'genv.clicks.path.with'       = '#{File.fileName}',
    'genv.clicks.user_agent.with' = '#{Internet.userAgentAny}',
    'topic.clicks.throttle.ms'    = 1000 
);

CREATE SOURCE CONNECTOR IF NOT EXISTS NETWORK_TRAFFIC WITH (
    'connector.class'                     = 'io.mdrogalis.voluble.VolubleSourceConnector',
    'key.converter'                       = 'org.apache.kafka.connect.storage.StringConverter',
    'genkp.devices.with'                  = '#{Internet.macAddress}',
    'genv.devices.name.with'              = '#{GameOfThrones.dragon}',
    'genv.devices.location->city.with'    = '#{Address.city}',
    'genv.devices.location->country.with' = '#{Address.country}',
    'topic.devices.records.exactly'       = 10,
    'genkp.traffic.with'                  = '#{Number.randomDigit}',
    'attrkp.traffic.null.rate'            = 1,
    'genv.traffic.mac.matching'           = 'devices.key',
    'genv.traffic.bytes_sent.with'        = '#{Number.numberBetween ''64'',''4096''}',
    'topic.traffic.throttle.ms'           = 500
);
