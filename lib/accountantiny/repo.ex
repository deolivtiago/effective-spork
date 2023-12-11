defmodule Accountantiny.Repo do
  use Ecto.Repo,
    otp_app: :accountantiny,
    adapter: Ecto.Adapters.Postgres
end
