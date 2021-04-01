defmodule StoneChallengeHandlerTest do
  use ExUnit.Case, async: true

  test "handle the request and correctly divide the total amount of products to emails" do
    result = StoneChallengeHandler.handle(
      "maca_12_5_banana_2_4_pera_5_10",
      "email1_email2_email3"
    )

    assert result == "{\"email3\":39,\"email2\":39,\"email1\":40}"
  end
end
