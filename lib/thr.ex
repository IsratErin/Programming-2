defmodule Thr do
  def test do
    solve("lib/Day1.txt")
  end
  def parse(puzzle_input) do
    puzzle_input
    # Remove leading/trailing white space
    |> String.trim()
    # Split by double line break into list of elves
    |> String.split("\r\n\r\n")
    |> Enum.map(fn elf ->
      elf
      # Split elf inventory by line into list of strings
      |> String.split("\r\n")
      # Convert string list to integer list
      |> Enum.map(&String.to_integer/1)
    end)
  end

  @doc """
  Solve the problem.
  Example output
  {{24000, [7000, 8000, 9000]}, 4}
  total calories 24000, calories per item in inventory, elf number 4
  """
  # def solve(path) do
  #   File.read!(path)                  # Read file contents
  #   |> parse()                        # Parse the inventory
  #   |> Enum.map(&{Enum.sum(&1), &1})  # Map each elf's inventory to a tuple of (total calories, inventory)
  #   |> Enum.with_index(1)             # Add 1 to the index of each tuple
  #   |> Enum.max_by(&elem(&1, 0))      # Find the tuple with the highest total calories, and return it
  # end

  # Example output
  # {[24000], 4}
  # Total calories and elf number
  def solve(path) do
    # Read file contents
    File.read!(path)
    # Parse the inventory
    |> parse()
    # Map each elf's inventory to a list of the total calories
    |> Enum.map(&[Enum.sum(&1)])
    # Add 1 to the index of each list
    |> Enum.with_index(1)
    # Find the list with the highest total calories, and return it
    |> Enum.max_by(&elem(&1, 0))
  end
end
