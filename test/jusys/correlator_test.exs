# SPDX-License-Identifier: AGPL-3.0-or-later

defmodule Jusys.CorrelatorTest do
  use ExUnit.Case

  setup do
    start_supervised!(Jusys.Correlator)
    :ok
  end

  describe "record_event/3" do
    test "records a change event" do
      :ok = Jusys.Correlator.record_event(:change, "system", %{action: "update"})
      events = Jusys.Correlator.all_events()

      assert length(events) == 1
      [event] = events
      assert event.type == :change
      assert event.source == "system"
    end

    test "records an anomaly event" do
      :ok = Jusys.Correlator.record_event(:anomaly, "disk", %{error: "low space"})
      [event] = Jusys.Correlator.all_events()

      assert event.type == :anomaly
    end

    test "records a metric event" do
      :ok = Jusys.Correlator.record_event(:metric, "cpu", %{value: 95})
      [event] = Jusys.Correlator.all_events()

      assert event.type == :metric
    end

    test "generates unique id for each event" do
      :ok = Jusys.Correlator.record_event(:change, "a", %{})
      :ok = Jusys.Correlator.record_event(:change, "b", %{})
      events = Jusys.Correlator.all_events()

      [e1, e2] = events
      assert e1.id != e2.id
    end
  end

  describe "find_correlations/0" do
    test "returns empty list when no anomalies" do
      :ok = Jusys.Correlator.record_event(:change, "system", %{})
      correlations = Jusys.Correlator.find_correlations()

      assert correlations == []
    end

    test "correlates anomaly with recent changes" do
      # Record a change
      :ok = Jusys.Correlator.record_event(:change, "package", %{name: "openssl"})

      # Record an anomaly shortly after
      :ok = Jusys.Correlator.record_event(:anomaly, "ssl", %{error: "handshake failed"})

      correlations = Jusys.Correlator.find_correlations()

      assert length(correlations) == 1
      [corr] = correlations
      assert corr.anomaly.type == :anomaly
      assert length(corr.related_changes) == 1
      assert corr.confidence > 0
    end

    test "high confidence for single related change" do
      :ok = Jusys.Correlator.record_event(:change, "system", %{})
      :ok = Jusys.Correlator.record_event(:anomaly, "app", %{})

      [corr] = Jusys.Correlator.find_correlations()
      assert corr.confidence == 0.8
    end
  end

  describe "all_events/0" do
    test "returns events in chronological order" do
      :ok = Jusys.Correlator.record_event(:change, "a", %{})
      :ok = Jusys.Correlator.record_event(:change, "b", %{})
      :ok = Jusys.Correlator.record_event(:change, "c", %{})

      events = Jusys.Correlator.all_events()
      sources = Enum.map(events, & &1.source)
      assert sources == ["a", "b", "c"]
    end
  end

  describe "clear/0" do
    test "removes all events" do
      :ok = Jusys.Correlator.record_event(:change, "test", %{})
      assert length(Jusys.Correlator.all_events()) == 1

      :ok = Jusys.Correlator.clear()
      assert Jusys.Correlator.all_events() == []
    end
  end
end
