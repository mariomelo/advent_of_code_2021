defmodule Star2 do
  def get_inputs do
    ordered_inputs =
      "input.txt"
      |> File.read!()
      |> String.split("\n")
      |> List.delete("")
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index(fn element, index -> {index, element} end)

    indexed_inputs =
      ordered_inputs
      |> Map.new()

    Enum.map(ordered_inputs, fn {index, element} ->
      case Map.fetch(indexed_inputs, index + 2) do
        {:ok, third_value} -> element + third_value + Map.fetch!(indexed_inputs, index + 1)
        :error -> element
      end
    end)
  end

  def check_next_input(accumulated_results, _, []), do: accumulated_results

  def check_next_input(accumulated_results, current_depth, [next_depth | list])
      when next_depth > current_depth do
    check_next_input(accumulated_results + 1, next_depth, list)
  end

  def check_next_input(accumulated_results, current_depth, [next_depth | list])
      when next_depth <= current_depth do
    check_next_input(accumulated_results, next_depth, list)
  end

  def start_sonar do
    [first_depth | list_of_depths] = get_inputs()
    check_next_input(0, first_depth, list_of_depths)
  end
end
