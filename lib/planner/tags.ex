defmodule Planner.Tags do
  @behaviour Ecto.Type

  def type, do: {:array, :string}

  def cast(nil), do: {:ok, nil}
  def cast(arr) when is_list(arr) do
    if Enum.all?(arr, &String.valid?/1), do: {:ok, arr}, else: :error
  end
  def cast(str) when is_binary(str), do: {:ok, String.split(str, ",") |> Enum.map(&String.trim/1)}
  def cast(_), do: :error

  def dump(val) when is_list(val), do: {:ok, val}
  def dump(_), do: :error

  def load(val) when is_list(val), do: {:ok, val}
  def load(_), do: :error
end