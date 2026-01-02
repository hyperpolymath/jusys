# SPDX-License-Identifier: AGPL-3.0-or-later

defmodule Jusys.Application do
  @moduledoc """
  JuSys Application supervisor.

  Starts the observability system supervision tree.
  """

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the metrics store
      Jusys.Metrics.Store,
      # Start the event correlator
      Jusys.Correlator
    ]

    opts = [strategy: :one_for_one, name: Jusys.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
