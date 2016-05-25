defmodule Story.TextParser do
  

  def process_sms_csv(path) do
    {:ok, sms} = File.read("data/lou_sms.txt")
    texts = String.split(sms, "\r\n\r\n", trim: :true)
      |> Enum.map(&parse_text/1)
      
  end

  defp parse_text(text_string) do
    [meta | message] = String.split(text_string, "\r\n")
    name = extract_name(meta)
    date = extract_date(meta)
    %{sender: name, sent_at: date, content: List.first(message)}
  end

  defp extract_date(string) do
    Regex.run(~r/\d\d\d\d-\d\d-\d\d\s\d\d:\d\d:\d\d/, string)
    |> List.first
  end

  defp extract_name(string) do
    Regex.run(~r/(Lou|me)/, string, capture: :first)
    |> List.first
    |> String.downcase
    |> String.replace("me", "gabriella")
  end
end
