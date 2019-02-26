IEx.configure(colors: [enabled: true])
# IEx.configure colors: [ eval_result: [ :cyan, :bright ] ]
Application.put_env(:elixir, :ansi_enabled, true)

IEx.configure(
  colors: [
    eval_result: [:green, :bright],
    eval_error: [[:red, :bright]],
    eval_info: [:yellow, :bright]
  ],
  default_prompt:
    [
      # ANSI CHA, move cursor to column 1
      "\e[G",
      # plain string
      :magenta,
      "%prefix",
      "|",
      "%counter",
      "|",
      "•",
      :reset
    ]
    |> IO.ANSI.format()
    |> IO.chardata_to_string()
)
