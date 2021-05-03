package dmit2015.norrisjackson.assignment02.resource;

import org.junit.jupiter.api.Test;
import dmit2015.norrisjackson.assignment02.config.ApplicationConfig;
import dmit2015.norrisjackson.assignment02.config.JAXRSConfiguration;
import dmit2015.norrisjackson.assignment02.entity.Character;
import dmit2015.norrisjackson.assignment02.repository.CharacterRepository;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import org.apache.maven.model.Model;
import org.apache.maven.model.io.xpp3.MavenXpp3Reader;
import org.codehaus.plexus.util.xml.pull.XmlPullParserException;
import org.jboss.arquillian.container.test.api.Deployment;
import org.jboss.arquillian.container.test.api.RunAsClient;
import org.jboss.arquillian.junit5.ArquillianExtension;
import org.jboss.shrinkwrap.api.ShrinkWrap;
import org.jboss.shrinkwrap.api.asset.EmptyAsset;
import org.jboss.shrinkwrap.api.spec.WebArchive;
import org.jboss.shrinkwrap.resolver.api.maven.Maven;
import org.jboss.shrinkwrap.resolver.api.maven.PomEquippedResolveStage;
import org.junit.jupiter.api.*;
import org.junit.jupiter.api.extension.ExtendWith;

import javax.json.bind.Jsonb;
import javax.json.bind.JsonbBuilder;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static io.restassured.RestAssured.given;
import static org.junit.jupiter.api.Assertions.*;

/**
 * @author Norris Jackson
 * @version 2021/02/06
 * This arquillian REST assured test tests the methods in the CharacterResource
 * It tests to find all entities, find one entity, update one entity, and delete one entity.
 * It brings back response bodies and response codes.
 */

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
@ExtendWith(ArquillianExtension.class)
class CharacterResourceArquillianRestAssuredIT {

    @Deployment
    public static WebArchive createDeployment() throws IOException, XmlPullParserException {
        PomEquippedResolveStage pomFile = Maven.resolver().loadPomFromFile("pom.xml");
        MavenXpp3Reader reader = new MavenXpp3Reader();
        Model model = reader.read(new FileReader("pom.xml"));
        final String archiveName = model.getArtifactId() + ".war";
        return ShrinkWrap.create(WebArchive.class,archiveName)
        .addAsLibraries(pomFile.resolve("com.h2database:h2:1.4.200").withTransitivity().asFile())
        .addClasses(ApplicationConfig.class, JAXRSConfiguration.class)
        .addClasses(Character.class, CharacterRepository.class, CharacterResource.class)
        .addAsResource("META-INF/persistence.xml")
        .addAsResource("META-INF/sql/import-data.sql")
        .setWebXML(new File("src/main/webapp/WEB-INF/web.xml"))
        .addAsWebInfResource(EmptyAsset.INSTANCE,"beans.xml");
    }

    String testDataResourceLocation;

    @Order(1)
    @Test
    @RunAsClient
    void findAllCharacters() {
        Response response = given()
                .urlEncodingEnabled(false)
                .accept(ContentType.JSON)
                .when()
                .get("http://localhost:8080/dmit2015-assignment02-norrisjackson/webapi/Characters")
                .then()
                .statusCode(200)
                .contentType(ContentType.JSON)
                .extract()
                .response();
        String jsonBody = response.getBody().asString();
        Jsonb jsonb = JsonbBuilder.create();
        List<Character> characters = jsonb.fromJson(jsonBody, new ArrayList<Character>(){}.
        getClass().getGenericSuperclass());
        //assertEquals(3, characters.size());
    }

    @Order(2)
    @Test
    @RunAsClient
    void shouldCreate() {
        Character newCharacter = new Character();
        newCharacter.setName("Heart");
        newCharacter.setFate("Arcana Heart");
        newCharacter.setHealth(17000);
        newCharacter.setVersionAdded(1.5);
        Jsonb jsonb = JsonbBuilder.create();
        String jsonBody = jsonb.toJson(newCharacter);
        Response response = given()
                .contentType(ContentType.JSON)
                .body(jsonBody)
                .when()
                .post("http://localhost:8080/dmit2015-assignment02-norrisjackson/webapi/Characters")
                .then()
                .statusCode(201)
                .extract()
                .response();
        testDataResourceLocation = response.getHeader("location");
    }

    @Order(3)
    @Test
    @RunAsClient
    void shouldFindOne() {
        Response response = given()
                .accept(ContentType.JSON)
                .when()
                .get(testDataResourceLocation)
                .then()
                .statusCode(200)
                .contentType(ContentType.JSON)
                .extract()
                .response();
        String jsonBody = response.getBody().asString();
        Jsonb jsonb = JsonbBuilder.create();
        Character existingCharacter = jsonb.fromJson(jsonBody, Character.class);
        assertNotNull(existingCharacter);
        assertEquals("Heart", existingCharacter.getName());
        assertEquals(17000, existingCharacter.getHealth());
        assertEquals(1.5, existingCharacter.getVersionAdded());
        assertEquals("Arcana Heart", existingCharacter.getFate());
    }

    @Order(4)
    @Test
    @RunAsClient
    void shouldUpdate() {
        Response response = given()
                .accept(ContentType.JSON)
                .when()
                .get(testDataResourceLocation)
                .then()
                .statusCode(200)
                .contentType(ContentType.JSON)
                .extract()
                .response();
        String jsonBody = response.getBody().asString();
        Jsonb jsonb = JsonbBuilder.create();
        Character existingCharacter = jsonb.fromJson(jsonBody, Character.class);
        assertNotNull(existingCharacter);
        existingCharacter.setName("Kanji");
        existingCharacter.setFate("P4A");
        existingCharacter.setHealth(18000);
        existingCharacter.setVersionAdded(1.1);
        String jsonRequestBody = jsonb.toJson(existingCharacter);
        given()
                .contentType(ContentType.JSON)
                .body(jsonRequestBody)
                .when()
                .put(testDataResourceLocation)
                .then()
                .statusCode(204);
    }

    @Order(5)
    @Test
    @RunAsClient
    void shouldDelete(){
        given()
                .contentType(ContentType.JSON)
                .when()
                .delete(testDataResourceLocation)
                .then()
                .statusCode(204);
    }
}