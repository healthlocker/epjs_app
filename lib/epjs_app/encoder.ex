defmodule EpjsApp.Encoder do
  def sanitize_map(list) when is_list(list) do
    Enum.map(list, &sanitize_map/1)
  end

  def sanitize_map(map) do
    map
    |> Map.from_struct
    |> Map.drop([:__meta__, :__struct__])
  end
end
