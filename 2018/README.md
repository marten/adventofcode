Advent of Code 2018
===================

There's also a simple binary to fetch today's input and place it in the right
directory. It requires a file called `.session_cookie` containing the value of
the `session` cookie from a valid AoC login session. Then it can be run with:

    cargo run --bin fetch_input

The solution to each day's puzzle can be run with:

    cargo run --bin XX

where `XX` is the zero-padded day number.
