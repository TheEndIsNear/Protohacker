defmodule EchoServer.EchoServerGenServer do
  use GenServer

  def init(socket), do: {:ok, socket}

  def handle_info({:tcp, socket, :eof}, state) do
    :gen_tcp.close(socket)
    {:noreply, state}
  end

  def handle_info({:tcp, socket, data}, state) do
    :gen_tcp.send(socket, data)
    {:noreply, state}
  end

  def handle_info({:tcp_closed, _socket}, state) do
    {:stop, :normal, state}
  end

  def handle_info({:tcp_error, _socket, _reason}, state) do
    {:noreply, state}
  end
end
