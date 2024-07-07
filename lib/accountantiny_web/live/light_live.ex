defmodule AccountantinyWeb.LightLive do
  use AccountantinyWeb, :live_view

  def mount(_params, _session, socket),
    do: {:ok, assign(socket, brightness: 10, page_title: "Light")}

  def render(assigns) do
    ~H"""
    <div class="flex space-x-2 w-full max-w-screen-xl">
      <button class="bg-zinc-300 rounded-md px-4 font-medium text-2xl" phx-click="down">-</button>
      <div class="flex items-center justify-start bg-zinc-200 w-full p-1 rounded-md">
        <span
          class="font-medium bg-yellow-500 rounded-md transition-all"
          style={"width: #{@brightness}%"}
        >
          <%= @brightness %>
        </span>
      </div>
      <button class="bg-zinc-300 rounded-md px-4 font-medium text-2xl" phx-click="up">+</button>
      <button class="bg-zinc-300 rounded-md px-4 text-2xl" phx-click="toggle">
        on/off
      </button>
    </div>
    """
  end

  def handle_event("down", _params, socket),
    do: {:noreply, update(socket, :brightness, &down/1)}

  def handle_event("up", _params, socket),
    do: {:noreply, update(socket, :brightness, &up/1)}

  def handle_event("toggle", _params, %{assigns: %{brightness: 0}} = socket),
    do: {:noreply, assign(socket, brightness: 100)}

  def handle_event("toggle", _params, socket),
    do: {:noreply, assign(socket, brightness: 0)}

  defp down(0), do: 0
  defp down(brightness), do: brightness - 10

  defp up(100), do: 100
  defp up(brightness), do: brightness + 10
end
