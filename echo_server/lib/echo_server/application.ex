defmodule EchoServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  alias EchoServer.Server.EchoServer

  use Application

  @impl true
  def start(_type, _args) do
    children = [%{id: EchoServer, start: {EchoServer, :start_link, [8080]}}]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EchoServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
