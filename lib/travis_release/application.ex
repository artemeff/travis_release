defmodule TravisRelease.Application do
  use Application

  def start(_type, _args) do
    IO.puts "I'm started at http://0.0.0.0:#{port()}"

    children = [
      Plug.Cowboy.child_spec(
        scheme: :http, plug: TravisRelease.Endpoint,
        options: [ip: {0, 0, 0, 0}, port: port()])
    ]

    opts = [strategy: :one_for_one, name: TravisRelease.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp port do
    case System.get_env("PORT") do
      val when is_binary(val) -> String.to_integer(val)
      _or -> 4000
    end
  end
end
