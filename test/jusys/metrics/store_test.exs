# SPDX-License-Identifier: AGPL-3.0-or-later

defmodule Jusys.Metrics.StoreTest do
  use ExUnit.Case

  setup do
    start_supervised!(Jusys.Metrics.Store)
    :ok
  end

  describe "record/3" do
    test "records a metric with name and value" do
      :ok = Jusys.Metrics.Store.record("cpu_usage", 45.5)
      metrics = Jusys.Metrics.Store.all()

      assert length(metrics) == 1
      [metric] = metrics
      assert metric.name == "cpu_usage"
      assert metric.value == 45.5
    end

    test "records metric with tags" do
      :ok = Jusys.Metrics.Store.record("disk_free", 1024, %{drive: "C:"})
      [metric] = Jusys.Metrics.Store.all()

      assert metric.tags == %{drive: "C:"}
    end

    test "records timestamp automatically" do
      :ok = Jusys.Metrics.Store.record("test", 1)
      [metric] = Jusys.Metrics.Store.all()

      assert %DateTime{} = metric.timestamp
    end
  end

  describe "get/1" do
    test "filters metrics by name" do
      :ok = Jusys.Metrics.Store.record("cpu", 10)
      :ok = Jusys.Metrics.Store.record("memory", 20)
      :ok = Jusys.Metrics.Store.record("cpu", 15)

      cpu_metrics = Jusys.Metrics.Store.get("cpu")
      assert length(cpu_metrics) == 2
      assert Enum.all?(cpu_metrics, fn m -> m.name == "cpu" end)
    end

    test "returns empty list when no matches" do
      :ok = Jusys.Metrics.Store.record("cpu", 10)
      assert Jusys.Metrics.Store.get("disk") == []
    end
  end

  describe "all/0" do
    test "returns all metrics in chronological order" do
      :ok = Jusys.Metrics.Store.record("a", 1)
      :ok = Jusys.Metrics.Store.record("b", 2)
      :ok = Jusys.Metrics.Store.record("c", 3)

      metrics = Jusys.Metrics.Store.all()
      assert length(metrics) == 3
      assert Enum.map(metrics, & &1.name) == ["a", "b", "c"]
    end
  end

  describe "clear/0" do
    test "removes all metrics" do
      :ok = Jusys.Metrics.Store.record("test", 1)
      assert length(Jusys.Metrics.Store.all()) == 1

      :ok = Jusys.Metrics.Store.clear()
      assert Jusys.Metrics.Store.all() == []
    end
  end
end
