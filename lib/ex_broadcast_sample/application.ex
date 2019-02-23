defmodule ExBroadcastSample.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Registry, [keys: :duplicate, name: Registry.ExBroadcastSample, partitions: System.schedulers_online()]}
    ]

    opts = [strategy: :one_for_one, name: ExBroadcastSample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
