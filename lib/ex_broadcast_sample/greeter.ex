defmodule ExBroadcastSample.Greeter do
  use GenServer

  def start_link(opts) do
    registry = opts[:registry]
    key = opts[:key]
    number = opts[:number]

    GenServer.start_link(__MODULE__, %{registry: registry, key: key, number: number})
  end

  def hi(pid, receiver) do
    GenServer.cast(pid, {:hi, receiver})
  end

  def hello(pid, receiver) do
    GenServer.cast(pid, {:hello, receiver})
  end

  def init(%{registry: registry, key: key} = state) do
    Registry.register(registry, key, __MODULE__)
    {:ok, state}
  end

  def handle_cast({:hi, receiver}, state) do
    send(receiver, {:hi, self(), state.number})
    {:noreply, state}
  end

  def handle_cast({:hello, receiver}, state) do
    send(receiver, {:hello, self(), state.number})
    {:noreply, state}
  end
end
