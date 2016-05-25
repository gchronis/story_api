# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#

Story.TextParser.process_sms_csv("../../data/lou_sms.txt")
|> Enum.map(fn text -> Story.SMS.changeset(%Story.SMS{}, text) end)
|> Enum.map(fn changeset -> Story.Repo.insert!(changeset) end)
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
