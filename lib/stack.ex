defmodule Stack do
  @moduledoc """
  iex> {:ok, pid} = Stack.start_link([])
  iex> :ok = Stack.push(pid, 1)
  iex> Stack.pop(pid)
  1
  iex> Stack.pop(pid)
  nil
  """
  use GenServer

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg)
  end

  @doc """
  Pushes provided element to top of stack.

  iex> {:ok, pid} = Stack.start_link([])
  iex> :ok = Stack.push(pid, 1)
  iex> :sys.get_state(pid)
  [1]
  """
  def push(stack_pid, element) do
    GenServer.cast(stack_pid, {:push, element})
  end

  @doc """
  Pops element from top of stack.

  iex> {:ok, pid} = Stack.start_link([1])
  iex> Stack.pop(pid)
  1
  iex> :sys.get_state(pid)
  []
  iex> Stack.pop(pid)
  nil
  """
  def pop(stack_pid) do
    GenServer.call(stack_pid, :pop)
  end

  # Define the necessary Server callback functions:

  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl true
  def handle_cast({:push, element}, state) do
    IO.inspect([element | state])
    {:noreply, [element | state]}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    case state do
      [head | new_state] -> {:reply, head, new_state}
      [] -> {:reply, nil, state}
    end
  end
end
