defmodule ExBroadcastSample do
  require Logger

  alias ExBroadcastSample.Greeter

  def hi do
    Registry.dispatch(Registry.ExBroadcastSample, "greeter", fn entries ->
      entries
      |> Enum.each(fn {pid, Greeter} ->
        Greeter.hi(pid, self())
      end)
    end)
  end

  def hello do
    Registry.dispatch(Registry.ExBroadcastSample, "greeter", fn entries ->
      entries
      |> Enum.each(fn {pid, Greeter} ->
        Greeter.hello(pid, self())
      end)
    end)
  end

  def wait_greetings(0) do
    Logger.info("receiving finished")
  end

  def wait_greetings(count) do
    receive do
      {msg, sender, number} ->
        Logger.info("receive #{msg} from #{inspect(sender)} (No.#{number})")
        wait_greetings(count - 1)
    end
  end

  def broadcast do
    1..10
    |> Enum.map(fn i ->
      Greeter.start_link(registry: Registry.ExBroadcastSample, key: "greeter", number: i)
    end)

    hi()

    wait_greetings(10)

    hello()

    wait_greetings(10)
  end
end
