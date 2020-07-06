# Belowing is the configurations for git hooks
# Used for do the basic code quality check on
# developer's side

use Mix.Config

if Mix.env() != :prod do
  config :git_hooks,
    auto_install: true,
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          "mix format --check-formatted",
          "mix credo"
        ]
      ],
      pre_push: [
        verbose: false,
        tasks: [
          "mix dialyzer",
          "mix test --exclude pending"
        ]
      ]
    ]
end
