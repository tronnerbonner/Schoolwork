package dmit2015.client;

import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import javax.ws.rs.*;
import java.util.List;

/**
 * @author Norris Jackson
 * @version 2021/03/16
 * This service class uses REST methods to create the URI and
 * variables/data necessary for performing web api CRUD methods
 */
@RegisterRestClient(baseUri = "http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/")
@Path("Characters")
public interface CharacterService {

    @GET
    List<Character> findAll();

    @GET
    @Path("{id : \\d+}")
    Character findOneById(@PathParam("id") Long id);

    @GET
    @Path("/username/")
    List<Character> findAllByUsername(@HeaderParam("Authorization") String authorization);

    @POST
    String create(Character newCharacter, @HeaderParam("Authorization") String authorization);

    @PUT
    @Path("{id : \\d+}")
    void update(@PathParam("id") Long id, Character updatedCharacter, @HeaderParam("Authorization") String authorization);

    @DELETE
    @Path("{id : \\d+}")
    void delete(@PathParam("id") Long id, @HeaderParam("Authorization") String authorization);
}
