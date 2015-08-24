defmodule Constable.Api.UserViewTest do
  use Constable.ViewCase, async: false
  alias Constable.Api.UserView

  test "show.json returns correct fields" do
    user_interest = Forge.user_interest
    subscription = Forge.subscription
    user = Forge.saved_user(Repo)
      |> Map.put(:user_interests, [user_interest])
      |> Map.put(:subscriptions, [subscription])

    rendered_user = render_one(user, UserView, "show.json")

    assert rendered_user == %{
      data: %{
        id: user.id,
        name: user.name,
        gravatar_url: Exgravatar.generate(user.email),
        user_interests: [user_interest.id],
        subscriptions: [subscription.id]
      }
    }
  end
end
