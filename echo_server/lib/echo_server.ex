defmodule EchoServer do
  @moduledoc """
  Documentation for `EchoServer`.
  """

  def start_link(port \\ 8000) do
    port
    |> listen()
    |> accept()
  end

  def listen(port) do
    {:ok, listen_socket} = :gen_tcp.listen(port, [{:active, true}, :binary, reuseaddr: true])
    listen_socket
  end

  def accept(listen_socket) do
    {:ok, socket} = :gen_tcp.accept(listen_socket)

    {:ok, pid} = GenServer.start_link(EchoServer.EchoServerGenServer, socket)
    :gen_tcp.controlling_process(socket, pid)

    accept(listen_socket)
  end
end
