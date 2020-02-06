import {
  Battlegroup,
  Character,
  Charm,
  Merit,
  Poison,
  QC,
  Spell,
  Weapon,
} from 'types'
import { Player } from './player'

export interface EntityState {
  currentPlayer: string
  players: { [id: string]: Player }
  chronicles: { [id: string]: any }
  characters: { [id: string]: Character }
  weapons: { [id: string]: Weapon }
  merits: { [id: string]: Merit }
  charms: { [id: string]: Charm }
  spells: { [id: string]: Spell }
  qcs: { [id: string]: QC }
  qc_merits: { [id: string]: any }
  qc_charms: { [id: string]: any }
  qc_attacks: { [id: string]: any }
  battlegroups: { [id: string]: Battlegroup }
  combat_actors: { [id: string]: any }
  poisons: { [id: string]: Poison }
}

export interface WrappedEntityState {
  entities: {
    current: EntityState
  }
  session: {
    id: number
  }
}
