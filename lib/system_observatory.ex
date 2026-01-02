# SPDX-License-Identifier: AGPL-3.0-or-later

defmodule SystemObservatory do
  @moduledoc """
  JuSys - Systems Observatory

  Observability layer for AmbientOps.

  ## Philosophy

  JuSys **observes and recommends**. It never applies changes.

  - Observes (never acts)
  - Correlates (never executes)
  - Forecasts (never applies)
  - Recommends (never modifies)
  - NEVER source of truth

  ## Core Capabilities

  * **Metrics Store** — time series data from system scans
  * **Dashboard** — visualization of system health
  * **Change Timeline** — correlate anomalies with changes
  * **Forecasting** — predict resource exhaustion
  """

  @version "1.0.0"
  @schema_version "1.0"

  @doc """
  Returns the current version of JuSys.
  """
  @spec version() :: String.t()
  def version, do: @version

  @doc """
  Returns the schema version for JuSys data formats.
  """
  @spec schema_version() :: String.t()
  def schema_version, do: @schema_version

  @doc """
  Check if JuSys is in observation-only mode (always true).

  JuSys never modifies system state - it only observes.
  """
  @spec observation_only?() :: true
  def observation_only?, do: true
end
