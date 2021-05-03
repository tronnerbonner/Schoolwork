package dmit2015.resource;

import dmit2015.entity.Character;
import dmit2015.repository.CallerUserRepository;
import dmit2015.repository.CharacterRepository;
import org.eclipse.microprofile.jwt.JsonWebToken;

import javax.annotation.security.RolesAllowed;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriInfo;
import java.net.URI;
import java.util.List;
import java.util.Optional;
/**
 * *Web API with CRUD methods for managing Character entity.
 * URI						Http Method     Request Body		                        Description
 * 	----------------------  -----------		------------------------------------------- ------------------------------------------
 * /Characters				POST			{"name":"Mika",                             Create a new Character
 *                                           "fate": "UNIST",
 *                                           "health": 1800,
 *                                           "versionAdded":1.3}
 * /Characters/{id}			GET			                                                Find a character with an ID
 * /Characters		        GET			                                                Find all characters
 * /Characters/{id}         PUT             {"id":2,
 * 	                                        "name":"Ruby",                             Update the character
 * 	                                        "fate": "RWBY",
 * 	                                        "health": 1800,
 * 	                                        "versionAdded": 1.0}
 *
 * /Characters/{id}			DELETE			                                            Remove the character
 *
 curl -i -X GET http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/Characters

 curl -i -X GET http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/Characters/1

 curl -i -X POST http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/Characters  -d '{"name":"Mika","fate":"UNIST","health":1800,"versionAdded":1.3}' -H 'Authorization: Bearer tokenForUser01' -H 'Content-Type:application/json'

 curl -i -X GET http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/Characters/4

 curl -i -X PUT http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/Characters/2 -d '{"id":2,"name":"Ruby","fate":"RWBY","health":1800,"versionAdded":1.0}' -H 'Authorization: Bearer tokenForUser01' -H 'Content-Type:application/json'

 curl -i -X GET http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/Characters/2

 curl -i -X GET http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/Characters/3

 curl -i -X DELETE http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/Characters/3 -H 'Authorization: Bearer tokenForUser01'

 curl -i -X GET http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/Characters/3

 curl -i -X GET http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/Characters/username -H 'Authorization: Bearer tokenForUser01'
 */

/**
 * @author Norris Jackson
 * @version 2021/04/20
 * This resource class contains both the CURL commands for testing the methods below
 * But it also executes the methods in character repository as a web api
 */
@ApplicationScoped
@Path("Characters")
@Consumes(MediaType.APPLICATION_JSON)
@Produces(MediaType.APPLICATION_JSON)
public class CharacterResource {
    @Context private UriInfo uriInfo;

    @Inject
    private CharacterRepository characterRepository;


    @Inject
    private JsonWebToken _callerPrincipal;

    @GET
    public Response findAllCharacters() {
        List<Character> characters = characterRepository.findAll();
        return Response.ok(characters).build();
    }

    @RolesAllowed({"ADMIN", "USER"})
    @GET
    @Path("/username/")
    public Response findAllByUsername() {
        String username = _callerPrincipal.getName();
        List<Character> characters = characterRepository.findByUsername(username);
        return Response.ok(characters).build();
    }

    @GET
    @Path("{id : \\d+}")
    public Response findOneById(@PathParam("id") Long characterId) {
        if (characterId == null) {
            throw new BadRequestException();
        }

        Optional<Character> optionalCharacter = characterRepository.findOneById(characterId);
        if (optionalCharacter.isEmpty()) {
            throw new NotFoundException();
        }
        Character existingCharacter = optionalCharacter.get();
        return Response.ok(existingCharacter).build();
    }

    @RolesAllowed({"ADMIN", "USER"})
    @POST
    public Response postCharacterItem(@Valid Character newCharacter){
        if (newCharacter == null){
            throw new BadRequestException();
        }
        String username = _callerPrincipal.getName();
        newCharacter.setUsername(username);
        characterRepository.create(newCharacter);
        URI charactersUri = uriInfo.getAbsolutePathBuilder().path(newCharacter.getId().toString()).build();
        return Response.created(charactersUri).build();
    }

    @RolesAllowed({"ADMIN", "USER"})
    @PUT
    @Path("{id : \\d+}")
    public Response updateCharacter(@PathParam("id") Long characterId, @Valid Character updatedCharacter) {
        if (characterId == null || updatedCharacter.getId() == null || !updatedCharacter.getId().equals(characterId)) {
            throw new BadRequestException();
        }

        Optional<Character> optionalCharacter = characterRepository.findOneById(characterId);
        if (optionalCharacter.isEmpty()) {
            throw new NotFoundException();
        }
        characterRepository.update(updatedCharacter);

        return Response.noContent().build();
    }

    @RolesAllowed({"ADMIN"})
    @DELETE
    @Path("{id : \\d+}")
    public Response deleteCharacter(@PathParam("id") Long characterId) {
        if (characterId == null) {
            throw new BadRequestException();
        }
        Optional<Character> existingCharacter = characterRepository.findOneById(characterId);
        if (existingCharacter.isEmpty()) {
            throw new NotFoundException();
        }
        characterRepository.delete(characterId);
        return Response.noContent().build();

    }
}
