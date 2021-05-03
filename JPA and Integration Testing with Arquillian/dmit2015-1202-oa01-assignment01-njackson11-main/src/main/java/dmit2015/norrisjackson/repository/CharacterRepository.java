package dmit2015.norrisjackson.repository;


import dmit2015.norrisjackson.entity.Character;

import javax.ejb.Local;
import javax.enterprise.context.ApplicationScoped;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

/**
 * @author Norris Jackson
 * @version 2021/01/29
 * This class is a class to manage CRUD for the character table
 * create creates a Character entity into the database
 * update updates a Character entity in the database
 * delete deletes a Character entity in the database
 * findOneById finds a character by it's unique identifier
 * findAll finds all characters in the Character table
 */

@ApplicationScoped
@Transactional
public class CharacterRepository {

    @PersistenceContext(unitName = "h2database-jpa-pu")
    private EntityManager entityManager;

    public void create(Character newCharacter) {
        entityManager.persist(newCharacter);
    }

    public Optional<Character> findOneById(Long id){
        Optional<Character> optionalCharacter = Optional.empty();
        try{
            Character querySingleResult = entityManager.find(Character.class, id);
            if(querySingleResult != null){
                optionalCharacter = Optional.of(querySingleResult);
            }
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return optionalCharacter;
    }

    public List<Character> findAll() {
        return entityManager.createQuery("FROM Character", Character.class).getResultList();
    }

    public void update(Character updatedCharacter) {
        Optional<Character> optionalCharacter = findOneById(updatedCharacter.getId());
        if(optionalCharacter.isPresent()) {
            Character existingCharacter = optionalCharacter.get();
            existingCharacter.setName((updatedCharacter.getName()));
            existingCharacter.setFate((updatedCharacter.getFate()));
            existingCharacter.setVersionAdded((updatedCharacter.getVersionAdded()));
            existingCharacter.setHealth((updatedCharacter.getHealth()));
            existingCharacter.setLastModifiedDateTime(LocalDateTime.now()); //Sets the last modified date to the date and time this method executes
        }
    }

    public void delete(Long id){
        Optional<Character> optionalCharacter = findOneById(id);
        if(optionalCharacter.isPresent()){
            Character existingCharacter = optionalCharacter.get();
            entityManager.remove(existingCharacter);
        }

    }

}
