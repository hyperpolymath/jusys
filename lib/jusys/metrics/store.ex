# SPDX-License-Identifier: AGPL-3.0-or-later

defmodule Jusys.Metrics.Store do
  @moduledoc """
  In-memory metrics store for time series data.

  Stores metrics from system scans in a ring buffer.
  Data is ephemeral - JuSys is not the source of truth.
  """

  use GenServer

  @type metric :: %{
          name: String.t(),
          value: number(),
          timestamp: DateTime.t(),
          tags: map()
        }

  @type state :: %{
          metrics: [metric()],
          max_size: non_neg_integer()
        }

  @default_max_size 10_000

  # Client API

  @doc """
  Start the metrics store.
  """
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @doc """
  Record a metric.
  """
  @spec record(String.t(), number(), map()) :: :ok
  def record(name, value, tags \\ %{}) do
    GenServer.cast(__MODULE__, {:record, name, value, tags})
  end

  @doc """
  Get all metrics.
  """
  @spec all() :: [metric()]
  def all do
    GenServer.call(__MODULE__, :all)
  end

  @doc """
  Get metrics by name.
  """
  @spec get(String.t()) :: [metric()]
  def get(name) do
    GenServer.call(__MODULE__, {:get, name})
  end

  @doc """
  Clear all metrics.
  """
  @spec clear() :: :ok
  def clear do
    GenServer.call(__MODULE__, :clear)
  end

  # Server Callbacks

  @impl true
  def init(opts) do
    max_size = Keyword.get(opts, :max_size, @default_max_size)
    {:ok, %{metrics: [], max_size: max_size}}
  end

  @impl true
  def handle_cast({:record, name, value, tags}, state) do
    metric = %{
      name: name,
      value: value,
      timestamp: DateTime.utc_now(),
      tags: tags
    }

    metrics = [metric | state.metrics] |> Enum.take(state.max_size)
    {:noreply, %{state | metrics: metrics}}
  end

  @impl true
  def handle_call(:all, _from, state) do
    {:reply, Enum.reverse(state.metrics), state}
  end

  @impl true
  def handle_call({:get, name}, _from, state) do
    filtered = Enum.filter(state.metrics, fn m -> m.name == name end)
    {:reply, Enum.reverse(filtered), state}
  end

  @impl true
  def handle_call(:clear, _from, state) do
    {:reply, :ok, %{state | metrics: []}}
  end
end
