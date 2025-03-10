defmodule PhxVue.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhxVueWeb.Telemetry,
      PhxVue.Repo,
      {DNSCluster, query: Application.get_env(:phx_vue, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhxVue.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhxVue.Finch},
      # Start a worker by calling: PhxVue.Worker.start_link(arg)
      # {PhxVue.Worker, arg},
      # Start to serve requests, typically the last entry
      PhxVueWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhxVue.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhxVueWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
