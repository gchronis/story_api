defmodule Story.Timeline do
  alias Story.SMS

  def texts_to_json(texts) do
    events = texts
      |> Enum.map(&sms_to_timeline_hash/1)
    %{events: events}
      |> Poison.encode!
  end

  def sms_to_timeline_hash(%SMS{sender: sender, sent_at: sent_at, content: content}) do
    %{start_date: parse_date_time(sent_at),
      text: %{headline: content, text: sender}
    }
  end


  def parse_date_time(date_time) do
    {{year, month, day},{hour, minute, second}} = Ecto.DateTime.to_erl(date_time)
    date = %{year: year, month: month, day: day, hour: hour, minute: minute, second: second}
    date
  end
  
  def texts_to_vis_json(texts) do
    texts
    |> Enum.map(fn %SMS{sender: sender, sent_at: sent_at, content: content} -> 
    %{start: Ecto.DateTime.to_string(sent_at), content: (sender <> ": " <> content)}
      end)
  end
end
