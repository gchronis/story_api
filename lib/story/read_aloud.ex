defmodule Story.ReadAloud do
  alias Story.SMS
  alias Story.Repo
  require Ecto.Query

  def back_and_forth do
    q = Ecto.Query.from t in Story.SMS,
      select: {t.sender, t.content}
      texts = Story.Repo.all(q)
            |> Enum.each(fn {name, content} -> read_one(name, content) end)
  end

  def read_one("gabriella" = name, content) do
    IO.puts name
    IO.puts content
    :os.cmd(~c(say -v Amelie -rate=120 "#{name}"))
    :os.cmd(~c(say -v Vicki -rate=120 "#{content}"))
  end

  def read_one("lou" = name, content) do
    IO.puts name
    IO.puts content
    :os.cmd(~c(say -v Ralph -rate=120 "#{name}"))
    :os.cmd(~c(say -v Alex -rate=120 "#{content}"))
 end


end
