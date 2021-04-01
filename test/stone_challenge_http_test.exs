defmodule StoneChallengeHttpTest do
  use ExUnit.Case
  doctest StoneChallengeHttp

  test "greets the world" do
    assert StoneChallengeHttp.hello() == :world
  end
end
