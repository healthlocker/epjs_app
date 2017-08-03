defmodule EpjsApp.Encoder do
  def sanitize_map(list) when is_list(list) do
    Enum.map(list, &sanitize_map/1)
  end

  def sanitize_map(nil) do
    nil
  end

  def sanitize_map(map) do
    if Map.has_key?(map, :__struct__) do
      map
      |> Map.from_struct
      |> Map.drop([:__meta__, :__struct__])
    else
      map
    end
  end
end
