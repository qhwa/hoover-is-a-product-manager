defmodule Product do
  @moduledoc """
  This struct represents the product model.
  """

  @type t :: %__MODULE__{
          part_number: binary,
          branch_id: binary,
          part_price: number,
          short_desc: String.t()
        }

  @enforce_keys [:part_number, :branch_id, :part_price]
  defstruct [:part_number, :branch_id, :part_price, :short_desc]
end
