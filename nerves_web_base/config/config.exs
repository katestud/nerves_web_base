# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Customize the firmware. Uncomment all or parts of the following
# to add files to the root filesystem or modify the firmware
# archive.

# config :nerves, :firmware,
#   rootfs_additions: "config/rootfs_additions",
#   fwup_conf: "config/fwup.conf"

config :nerves_ntp, :ntpd, "/usr/sbin/ntpd"

config :logger,
        backends: [ :console, LoggerMulticastBackend ],
        level: :debug,
        format: "$time $metadata[$level] $message\n"

config :nerves_web_base, interface: :wlan0

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"

config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("NERVES_NETWORK_SSID"),
    psk: System.get_env("NERVES_NETWORK_PSK"),
    key_mgmt: String.to_atom(key_mgmt)
  ]

port = System.get_env("PORT") || "8000"
config :nerves_web_base, http_port: String.to_integer(port)

config :nerves_firmware_http,
  json_provider: Poison,
  json_opts: []

config :shoehorn,
  init: [:nerves_runtime, :nerves_network, :nerves_firmware_http, :ui, :nerves_ntp],
  app: :nerves_web_base

config :ui, UiWeb.Endpoint,
  url: [host: "localhost", port: 80],
  http: [port: 80],
  secret_key_base: "",
  root: Path.dirname(__DIR__),
  server: true,
  render_errors: [view: UiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ui.PubSub, adapter: Phoenix.PubSub.PG2],
  code_reloader: false

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

# import_config "#{Mix.Project.config[:target]}.exs"
