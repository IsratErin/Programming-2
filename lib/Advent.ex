defmodule Advent do
  def test do
   input= read_input("lib/Day1.txt")
   #find_calorie_and_elf(input)
   #find_max_calories(input)
   #find_max_calories_list(input)

  #find_top_three_elves(input)
   top_three(input)
  #top_three_sum(i)
   #{find_max_calories(input),find_max_calories_elf(input), find_elf(input)}
  end
  def read_input(input) do
    File.read!(input)
    |> String.trim()
    |> String.split("\r\n\r\n")
    |> Enum.map(&String.split( &1,"\r\n"))
  end

  def calculate_calories(elf) do
    elf
    |> Enum.map(&String.to_integer(&1))
    |> Enum.sum()
  end

  def find_max_calories(elves) do
    elves
    |> Enum.map(&calculate_calories/1)
    |> Enum.max()
  end

  def find_max_calories_list(elves) do
    max_calories = find_max_calories(elves)
    Enum.find(elves, &calculate_calories(&1) == max_calories)
  end
  def find_calorie_and_elf(elves) do
    elves
    |> Enum.map(&calculate_calories/1)
    |> Enum.with_index(1)
    # Finds the tuple with the highest total calories and elf number
    |> Enum.max_by(&elem(&1, 0))
  end
  def top_three(elves) do
    elves
    |> Enum.map(&calculate_calories/1)
    |> Enum.with_index(1)
    |> Enum.sort(&>=/2)
    |>Enum.take(3)
    # |>Enum.sum()
  end
  def top_three_sum(input) do
    Enum.sum(input)
  end


end
