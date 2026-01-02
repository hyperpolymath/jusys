# SPDX-License-Identifier: AGPL-3.0-or-later

defmodule Jusys.Correlator do
  @moduledoc """
  Event correlator for change timeline.

  Correlates system events with recent changes to identify
  potential causes of anomalies.
  """

  use GenServer

  @type event :: %{
          id: String.t(),
          type: :change | :anomaly | :metric,
          timestamp: DateTime.t(),
          source: String.t(),
          data: map()
        }

  @type correlation :: %{
          anomaly: event(),
          related_changes: [event()],
          confidence: float()
        }

  @type state :: %{
          events: [event()],
          max_events: non_neg_integer(),
          correlation_window_seconds: non_neg_integer()
        }

  @default_max_events 1_000
  @default_window_seconds 3600

  # Client API

  @doc """
  Start the correlator.
  """
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @doc """
  Record an event (change or anomaly).
  """
  @spec record_event(atom(), String.t(), map()) :: :ok
  def record_event(type, source, data) when type in [:change, :anomaly, :metric] do
    GenServer.cast(__MODULE__, {:record, type, source, data})
  end

  @doc """
  Find correlations for recent anomalies.
  """
  @spec find_correlations() :: [correlation()]
  def find_correlations do
    GenServer.call(__MODULE__, :correlate)
  end

  @doc """
  Get all events.
  """
  @spec all_events() :: [event()]
  def all_events do
    GenServer.call(__MODULE__, :all)
  end

  @doc """
  Clear all events.
  """
  @spec clear() :: :ok
  def clear do
    GenServer.call(__MODULE__, :clear)
  end

  # Server Callbacks

  @impl true
  def init(opts) do
    {:ok,
     %{
       events: [],
       max_events: Keyword.get(opts, :max_events, @default_max_events),
       correlation_window_seconds: Keyword.get(opts, :window, @default_window_seconds)
     }}
  end

  @impl true
  def handle_cast({:record, type, source, data}, state) do
    event = %{
      id: generate_id(),
      type: type,
      timestamp: DateTime.utc_now(),
      source: source,
      data: data
    }

    events = [event | state.events] |> Enum.take(state.max_events)
    {:noreply, %{state | events: events}}
  end

  @impl true
  def handle_call(:correlate, _from, state) do
    correlations = build_correlations(state.events, state.correlation_window_seconds)
    {:reply, correlations, state}
  end

  @impl true
  def handle_call(:all, _from, state) do
    {:reply, Enum.reverse(state.events), state}
  end

  @impl true
  def handle_call(:clear, _from, state) do
    {:reply, :ok, %{state | events: []}}
  end

  # Private Functions

  defp generate_id do
    :crypto.strong_rand_bytes(8) |> Base.url_encode64(padding: false)
  end

  defp build_correlations(events, window_seconds) do
    anomalies = Enum.filter(events, fn e -> e.type == :anomaly end)
    changes = Enum.filter(events, fn e -> e.type == :change end)

    Enum.map(anomalies, fn anomaly ->
      related =
        Enum.filter(changes, fn change ->
          diff = DateTime.diff(anomaly.timestamp, change.timestamp, :second)
          diff >= 0 and diff <= window_seconds
        end)

      %{
        anomaly: anomaly,
        related_changes: related,
        confidence: calculate_confidence(related)
      }
    end)
  end

  defp calculate_confidence(related_changes) do
    case length(related_changes) do
      0 -> 0.0
      1 -> 0.8
      2 -> 0.6
      _ -> 0.4
    end
  end
end
