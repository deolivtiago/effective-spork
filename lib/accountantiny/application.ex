defmodule Accountantiny.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AccountantinyWeb.Telemetry,
      Accountantiny.Repo,
      {DNSCluster, query: Application.get_env(:accountantiny, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Accountantiny.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Accountantiny.Finch},
      # Start a worker by calling: Accountantiny.Worker.start_link(arg)
      # {Accountantiny.Worker, arg},
      # Start to serve requests, typically the last entry
      AccountantinyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Accountantiny.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AccountantinyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
