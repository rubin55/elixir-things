defmodule MFSC do
  def call do
    [directory] = System.argv()

    with true <- File.dir?(directory),
         {:ok, files} <- list_files(directory) do
      Enum.reduce(files, 0, fn file, size -> size + calculate_file_size(file) end)
      |> Kernel.div(length(files))
      |> IO.puts()
    end
  end

  defp list_files(directory) do
    case File.ls(directory) do
      {:ok, files} ->
	    files =
          files
          |> Enum.map(&Path.join(directory, &1))
          |> Enum.reject(&File.dir?/1)

		{:ok, files}

      error ->
        error
    end
  end

  defp calculate_file_size(file) do
    file
    |> File.stat!()
    |> Map.get(:size)
  end
end

MFSC.call()
