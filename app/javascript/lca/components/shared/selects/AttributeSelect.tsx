import React from 'react'

import { MenuItem, TextField } from '@material-ui/core'
import { SelectProps } from '@material-ui/core/Select'

import { Attribute } from 'types'
import { capitalize } from 'utils'
import { ATTRIBUTES } from 'utils/tsconstants'

interface IAttributeSelectProps {
  name: string
  value: Attribute | 'universal'
  includeUniversal?: boolean
  exclude?: Attribute | Attribute[]
  prepend?: React.ReactNode
  displayEmpty?: boolean
}

const AttributeSelect = (props: IAttributeSelectProps) => {
  const items = ATTRIBUTES.map(a =>
    a === props.exclude || props.exclude?.includes(a) ? null : (
      <MenuItem key={a} value={a}>
        {capitalize(a)}
      </MenuItem>
    )
  )

  return (
    <TextField
      select
      label="Attribute"
      name={props.name}
      value={props.value}
      SelectProps={
        props.displayEmpty ? { displayEmpty: true, autoWidth: true } : {}
      }
      InputLabelProps={
        props.displayEmpty && !props.value ? { shrink: true } : {}
      }
    >
      {props.prepend}
      {props.includeUniversal && (
        <MenuItem value="universal">Universal (No Attribute)</MenuItem>
      )}

      {items}
    </TextField>
  )
}

export default AttributeSelect
