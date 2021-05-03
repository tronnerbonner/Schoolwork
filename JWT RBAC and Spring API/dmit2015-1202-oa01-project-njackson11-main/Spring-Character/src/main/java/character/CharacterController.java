package character;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
/*
  This class is a controller class that controls the methods for springboot REST API characters.
  Curl commands:
  List all: curl -v localhost:8080/characters
  List 1: curl -v localhost:8080/characters/1
  Create: curl -v -X POST localhost:8080/characters -H 'Content-type:application/json' -d '{"name": "Vatista", "health": "1800", "fate": "Uni", "versionAdded": "1.3"}'
  Find created character: curl -v localhost:8080/characters/3
  Update character: curl -v -X PUT localhost:8080/characters/3 -H 'Content-type:application/json' -d '{"name": "Yosuke", "health": "1700", "fate": "P4A", "versionAdded": "1.0"}'
  Find updated character: curl -v localhost:8080/characters/3
  Delete character: curl -v -X DELETE localhost:8080/characters/3
  Fail to find deleted character: curl -v localhost:8080/characters/3
 */
@RestController
public class CharacterController {

    private final CharacterRepository repository;

    CharacterController(CharacterRepository repository) {
        this.repository = repository;
    }

    // Aggregate root
    // tag::get-aggregate-root[]
    @GetMapping("/characters")
    List<Character> all() {
        return repository.findAll();
    }
    // end::get-aggregate-root[]

    @PostMapping("/characters")
    Character newCharacter(@RequestBody Character newCharacter) {
        return repository.save(newCharacter);
    }

    // Single item

    @GetMapping("/characters/{id}")
    Character one(@PathVariable Long id) {

        return repository.findById(id)
                .orElseThrow(() -> new CharacterNotFoundException(id));
    }

    @PutMapping("/characters/{id}")
    Character replaceEmployee(@RequestBody Character newCharacter, @PathVariable Long id) {

        return repository.findById(id)
                .map(character -> {
                    character.setName(newCharacter.getName());
                    character.setHealth(newCharacter.getHealth());
                    character.setFate(newCharacter.getFate());
                    character.setVersionAdded(newCharacter.getVersionAdded());
                    character.setLastModifiedDateTime();
                    return repository.save(character);
                })
                .orElseGet(() -> {
                    newCharacter.setId(id);
                    return repository.save(newCharacter);
                });
    }

    @DeleteMapping("/characters/{id}")
    void deleteCharacter(@PathVariable Long id) {
        repository.deleteById(id);
    }
}
