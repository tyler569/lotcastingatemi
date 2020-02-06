import { useDispatch } from 'react-redux'
import { useParams } from 'react-router'

import { updateCharacter } from 'ducks/actions'

/** Hook returning an updateCharacter action to update a character based on the current page URI */
const useUpdateCharacterFromURI = () => {
  const { characterId } = useParams()
  const dispatch = useDispatch()

  return (trait: any) => dispatch(updateCharacter(characterId, trait))
}

export default useUpdateCharacterFromURI
