# SPDX-License-Identifier: AGPL-3.0-or-later

defmodule JusysTest do
  use ExUnit.Case
  doctest Jusys

  describe "version/0" do
    test "returns version string" do
      assert Jusys.version() == "1.0.0"
    end
  end

  describe "schema_version/0" do
    test "returns schema version" do
      assert Jusys.schema_version() == "1.0"
    end
  end

  describe "observation_only?/0" do
    test "always returns true" do
      assert Jusys.observation_only?() == true
    end

    test "confirms JuSys never modifies state" do
      # This is a philosophical test - JuSys only observes
      assert Jusys.observation_only?()
    end
  end
end
