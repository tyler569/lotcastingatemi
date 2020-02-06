import { useSelector } from 'react-redux'
import { useParams } from 'react-router'

import { State } from 'ducks'
import { Character } from 'types'

/** Hook to retrieve a character from the Redux store based on page URI.
 */
const useCharacterFromURI = (): [Character, string] => {
  const { characterId } = useParams()
  const character = useSelector(
    (state: State) => state.entities.current.characters[characterId]
  )

  return [character, characterId]
}

export const useCharacterTraitFromURI = <T extends keyof Character>(
  trait: T
): Character[T] => {
  const { characterId } = useParams()
  return useSelector(
    (state: State) => state.entities.current.characters[characterId]?.[trait]
  )
}

export default useCharacterFromURI
