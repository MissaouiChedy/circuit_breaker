defmodule CircuitBreaker.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Starts a worker by calling: CircuitBreaker.Worker.start_link(arg)
      # {CircuitBreaker.Worker, arg},
    ]

    HTTPoison.start
    opts = [strategy: :one_for_one, name: CircuitBreaker.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
