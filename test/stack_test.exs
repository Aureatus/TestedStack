defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "default config" do
    assert {:ok, _} = Stack.start_link([])
  end

  test "default state" do
    {:ok, pid} = Stack.start_link([])
    assert [] = :sys.get_state(pid)
  end

  test "remove one element from stack" do
    {:ok, pid} = Stack.start_link([1])
    assert 1 = Stack.pop(pid)
  end

  test "remove multiple element from stack" do
    {:ok, pid} = Stack.start_link([1, 2])
    Stack.pop(pid)
    assert Stack.pop(pid) == 2
  end

  test "remove element from empty stack" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.pop(pid) == nil
  end

  test "add element to empty stack" do
    {:ok, pid} = Stack.start_link([])
    Stack.push(pid, 1)
    assert [1] = :sys.get_state(pid)
  end

  test "add element to stack with multiple elements" do
    {:ok, pid} = Stack.start_link([1, 2])
    Stack.push(pid, 3)
    assert [3, 1, 2] = :sys.get_state(pid)
  end
end
