package dmit2015.norrisjackson.repository;

import dmit2015.norrisjackson.config.ApplicationConfig;
import dmit2015.norrisjackson.entity.Character;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.junit5.ArquillianExtension;
import org.jboss.arquillian.transaction.api.annotation.TransactionMode;
import org.jboss.arquillian.transaction.api.annotation.Transactional;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.shrinkwrap.api.asset.EmptyAsset;
import org.jboss.shrinkwrap.api.spec.WebArchive;
import org.jboss.shrinkwrap.resolver.api.maven.Maven;
import org.jboss.shrinkwrap.resolver.api.maven.PomEquippedResolveStage;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;

import javax.inject.Inject;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

/**
 * @author Norris Jackson
 * @version 2021/02/06
 * This Arquillian Integration test is used to test the CRUD methods of the CharacterRepository class using an h2 console database
 * shouldCreate tests the add functionality
 * shouldFindOne tests the findOneById method
 * shouldFindAll tests the findAll method
 * shouldUpdate tests the update method
 * shouldDelete tests the delete method
 */
@ExtendWith(ArquillianExtension.class)
class CharacterRepositoryIT {
    @Inject
    private CharacterRepository _characterRepository;

    @Deployment
    public static WebArchive createDeployment() {
        PomEquippedResolveStage pomFile = Maven.resolver().loadPomFromFile("pom.xml");

        return ShrinkWrap.create(WebArchive.class, "test.war")
                .addAsLibraries(pomFile.resolve("com.h2database:h2:1.4.200").withTransitivity().asFile())
                .addAsLibraries(pomFile.resolve("org.hamcrest:hamcrest:2.2").withTransitivity().asFile())
                .addAsLibraries(pomFile.resolve("org.hibernate:hibernate-core:5.3.20.Final").withTransitivity().asFile())
                .addClass(ApplicationConfig.class)
                .addClasses(Character.class, CharacterRepository.class)
                .addAsResource("META-INF/persistence.xml")
                .addAsResource("META-INF/sql/import-data.sql")
                .addAsWebInfResource(EmptyAsset.INSTANCE, "beans.xml");
    }

    @Test
    public void shouldFail() {
        fail("This test method should fail otherwise Arquillian is not running the code in any test method");
    }

    @Transactional(TransactionMode.ROLLBACK)
    @Test
    void shouldCreate() {
        Character newCharacter = new Character();
        newCharacter.setName("Jin");
        newCharacter.setFate("Blazblue");
        newCharacter.setVersionAdded(1.0);
        newCharacter.setHealth(18000);
        _characterRepository.create(newCharacter);
        Optional<Character> optionalCharacter = _characterRepository.findOneById(newCharacter.getId());
        assertTrue(optionalCharacter.isPresent());
        Character existingCharacter = optionalCharacter.get();
        assertNotNull(existingCharacter);
        assertEquals("Jin", existingCharacter.getName());
        assertEquals(18000, existingCharacter.getHealth());
        assertEquals("Blazblue", existingCharacter.getFate());
        assertEquals(1.0, existingCharacter.getVersionAdded());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-M-dd H:m");
        assertEquals(formatter.format(LocalDateTime.now()), formatter.format(existingCharacter.getCreatedDateTime()));
        assertEquals(formatter.format(LocalDateTime.now()), formatter.format(existingCharacter.getLastModifiedDateTime()));
    } //Creates a new Character entity 'Jin'

    @Test
    void shouldFindOne(){
        final Long characterId=  2L;
        Optional<Character> optionalCharacter = _characterRepository.findOneById(characterId);
        assertTrue(optionalCharacter.isPresent());
        Character existingCharacter = optionalCharacter.get();
        assertNotNull(existingCharacter);
        assertEquals("Tager", existingCharacter.getName());
        assertEquals(20000, existingCharacter.getHealth());
        assertEquals("Blazblue", existingCharacter.getFate());
        assertEquals(1.0, existingCharacter.getVersionAdded());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-M-dd H:m");
        assertEquals(LocalDateTime.parse("2021-02-04 6:12", formatter).toString(), existingCharacter.getCreatedDateTime().toString());
        assertEquals(LocalDateTime.parse("2021-02-04 6:12", formatter).toString(), existingCharacter.getLastModifiedDateTime().toString());
    } //This test should find the character 'Tager'

    @Test
    void shouldFindAll() {
        List<Character> list = _characterRepository.findAll();
        assertEquals(3, list.size());
    } //This will find all characters

    @Transactional(TransactionMode.ROLLBACK)
    @Test
    void shouldUpdate(){
        final Long characterID = 3L;
        Optional<Character> optionalCharacter = _characterRepository.findOneById(characterID);
        assertTrue(optionalCharacter.isPresent());
        Character existingCharacter = optionalCharacter.get();
        assertNotNull(existingCharacter);
        existingCharacter.setName("Mika");
        existingCharacter.setHealth(18000);
        existingCharacter.setFate("UNIST");
        existingCharacter.setVersionAdded(1.3);
        _characterRepository.update(existingCharacter);

        Optional<Character> optionalUpdatedCharacter = _characterRepository.findOneById(characterID);
        assertTrue(optionalUpdatedCharacter.isPresent());
        Character updatedCharacter = optionalUpdatedCharacter.get();
        assertNotNull(updatedCharacter);
        assertEquals(existingCharacter.getName(), updatedCharacter.getName());
        assertEquals(existingCharacter.getHealth(), updatedCharacter.getHealth());
        assertEquals(existingCharacter.getFate(), updatedCharacter.getFate());
        assertEquals(existingCharacter.getVersionAdded(), updatedCharacter.getVersionAdded());
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-M-dd H:m");
        assertEquals(formatter.format(LocalDateTime.now()), formatter.format(existingCharacter.getLastModifiedDateTime()));
    } //This test updates the 'Jin' entity and makes it the 'Mika' entity. Updates Name, Health, Fate, VersionAdded, and lastModifiedDateTime

    @Transactional(TransactionMode.ROLLBACK)
    @Test
    void shouldDelete() {
        final long characterId = 3L;
        Optional<Character> optionalCharacter = _characterRepository.findOneById(characterId);
        assertTrue(optionalCharacter.isPresent());
        Character existingCharacter = optionalCharacter.get();
        assertNotNull(existingCharacter);
        _characterRepository.delete(existingCharacter.getId());
        optionalCharacter = _characterRepository.findOneById(characterId);
        assertTrue(optionalCharacter.isEmpty());
    } //Will delete the entity 'Yuzuriha'
}