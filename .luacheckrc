globals = {
  -- Factorio data stage
  "data",
  "settings",
  "mods",
  -- Factorio control stage
  "script",
  "game",
  "defines",
  "remote",
  "commands",
  "storage",
  -- Factorio libraries
  "serpent",
  "log",
  "table_size",
  "localised_print",
  "rendering",
}

read_globals = {
  "table",
  "math",
  "string",
  "pairs",
  "ipairs",
  "next",
  "type",
  "tostring",
  "tonumber",
  "pcall",
  "error",
  "assert",
  "require",
  "setmetatable",
  "getmetatable",
  "rawget",
  "rawset",
  "unpack",
  "select",
}

ignore = {
  "211", -- unused variable
  "212", -- unused argument
}

max_line_length = 120
