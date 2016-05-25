defmodule Story.SMSController do
  use Story.Web, :controller

  alias Story.SMS

  plug :scrub_params, "sms" when action in [:create, :update]

  def index(conn, _params) do
    texts = Repo.all(SMS)
    timeline_json = Story.Timeline.texts_to_json(Enum.take(texts, 200))
    vis_json = Story.Timeline.texts_to_vis_json(Enum.take(texts, 200))
    render(conn, "index.html", texts: texts, timeline_json: timeline_json, vis_json: vis_json)
  end

  def new(conn, _params) do
    changeset = SMS.changeset(%SMS{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sms" => sms_params}) do
    changeset = SMS.changeset(%SMS{}, sms_params)

    case Repo.insert(changeset) do
      {:ok, _sms} ->
        conn
        |> put_flash(:info, "Sms created successfully.")
        |> redirect(to: sms_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sms = Repo.get!(SMS, id)
    render(conn, "show.html", sms: sms)
  end

  def edit(conn, %{"id" => id}) do
    sms = Repo.get!(SMS, id)
    changeset = SMS.changeset(sms)
    render(conn, "edit.html", sms: sms, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sms" => sms_params}) do
    sms = Repo.get!(SMS, id)
    changeset = SMS.changeset(sms, sms_params)

    case Repo.update(changeset) do
      {:ok, sms} ->
        conn
        |> put_flash(:info, "Sms updated successfully.")
        |> redirect(to: sms_path(conn, :show, sms))
      {:error, changeset} ->
        render(conn, "edit.html", sms: sms, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sms = Repo.get!(SMS, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sms)

    conn
    |> put_flash(:info, "Sms deleted successfully.")
    |> redirect(to: sms_path(conn, :index))
  end
end
