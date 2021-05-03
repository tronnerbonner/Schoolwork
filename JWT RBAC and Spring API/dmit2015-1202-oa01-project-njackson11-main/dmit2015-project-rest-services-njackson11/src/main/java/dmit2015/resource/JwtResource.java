package dmit2015.resource;


import dmit2015.entity.CallerUser;
import dmit2015.repository.CallerUserRepository;
import dmit2015.security.TokenUtil;
import org.eclipse.microprofile.jwt.JsonWebToken;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonObject;
import javax.security.enterprise.identitystore.Pbkdf2PasswordHash;
import javax.servlet.ServletContext;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.Status;
import java.util.Optional;

/**
 * Microprofile JWT Authentication Steps
 *
 * Step 1: Generate the public/private key pair for signing and verification.
 * Generate a private key file named jwt-private.pem using the openssl command from a Terminal:
 *
 mkdir -p ~/keys
 openssl genpkey -algorithm RSA -out ~/keys/jwt-private.pem -pkeyopt rsa_keygen_bits:2048
 *
 * Export the public key that will be included in the deployment using the openssl command from a Terminal:
 *
 openssl rsa -in ~/keys/jwt-private.pem -pubout -out src/main/resources/META-INF/jwt-public.pem
 *
 * Step 2: Add the TokenUtil.java class that is used to generate JWT tokens.
 *
 * Step 3: Activate Microprofile JWT by adding the @LoginConfig annotation as follows:
 *
 @ApplicationPath("webapi")
 @LoginConfig(authMethod="MP-JWT", realmName="MP JWT Realm")
 @DeclareRoles({"ROLE1","ROLE2","ROLE3"})
 public class JAXRSConfiguration extends Application { }
  *
  * Step 4: Open the Microprofile Config properties file 'src/main/resources/META-INF/microprofile-config.properties'
  * and add the following key/value pairs:
  *
 mp.jwt.verify.publickey.location=META-INF/jwt-public.pem
 mp.jwt.verify.issuer=quickstart-jwt-issuer
  *
  * Step 5: Open the web descriptor file 'src/main/webapp/WEB-INF/web.xml' and add a context parameter
  * named jwt.privatekey.filepath with the location of your JWT private key file.
  *
 <context-param>
 <param-name>jwt.privatekey.filepath</param-name>
 <param-value>/home/user/user2015/keys/jwt-private.pem</param-value>
 </context-param>
  *
  * Run your application on the server and use the curl command to verify that a JWT token is returned when a valid username and password is posted to the server.
  * You can POST JSON data to the server as follows:
  *
 curl -k -i -X POST http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/jwt/jsonLogin \
 -d '{"username":"user01@dmit2015.ca","password":"Password2015"}' \
 -H 'Content-Type:application/json'

 curl -k -i -X POST http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/jwt/jsonLogin \
 -d '{"username":"user01@dmit2015.ca","password":"Password201"}' \
 -H 'Content-Type:application/json'

 curl -k -i -X POST http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/jwt/jsonLogin \
 -d '{"username":"admin01@dmit2015.ca","password":"Password2015"}' \
 -H 'Content-Type:application/json'

  *
  * You can also POST FORM data to the server as follows:
 curl -k -i -X POST http://localhost:8080/dmit2015-project-rest-services-njackson11/webapi/jwt/formLogin/ \
 -d 'j_username=user01@dmit2015.ca&j_password=Password2015' \
 -H 'Content-Type:application/x-www-form-urlencoded'
  *
  * @author https://github.com/wildfly/quickstart/tree/master/microprofile-jwt
 * @version 2021.03.17
 *
 */

@RequestScoped
@Path("jwt")
public class JwtResource {

    @Inject
    private CallerUserRepository callerUserRepository;	// for accessing our database of users

    @Inject
    private Pbkdf2PasswordHash passwordHash;	// for hashing the plain text password to cipher text

    @Inject
    private JsonWebToken callerPrincipal;		// CDI managed bean must be @RequestScoped to inject JWT token

    /**
     * Generate and return a JWT bearer token where the username and password are posted as FORM fields named j_username and j_password, respectively.
     *
     * @param username The j_username form field value
     * @param password The j_password form field value
     * @param servletContext Injected by the container to allow use to read context parameters from web.xml
     * @return
     */
    @Path("formLogin")
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    @Produces(MediaType.TEXT_PLAIN)
    @POST
    public Response formLogin(
            @FormParam("j_username") String username,
            @FormParam("j_password") String password,
            @Context ServletContext servletContext) {
        JsonObject credential = Json.createObjectBuilder()
                .add("username", username)
                .add("password", password)
                .build();
        return jsonLogin(credential, servletContext);
    }

    /**
     * Generate and return a JWT bearer token for the given username and password.
     *
     * @param credential A JSON object with the username and password used for authentication
     * @param servletContext Injected by the container to allow use to read context parameters from web.xml
     * @return A JWT beear token
     */
    @POST
    @Path("jsonLogin")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.TEXT_PLAIN)
    public Response jsonLogin(JsonObject credential, @Context ServletContext servletContext) {
        String username = credential.getString("username");
        String password = credential.getString("password");
        String privateKeyPath = servletContext.getInitParameter("jwt.privatekey.filepath");

        Optional<CallerUser> optionalCallerUser = callerUserRepository.findById(username);
        if (optionalCallerUser.isPresent()) {
            CallerUser existingCallerUser = optionalCallerUser.get();
            if (passwordHash.verify(password.toCharArray(), existingCallerUser.getPassword())) {
                String[] groups = existingCallerUser.getGroups().toArray(String[]::new);
                try {
                    String token = TokenUtil.generateJWT(privateKeyPath, username, groups);
                    return Response.ok(token).build();
                } catch (Exception e) {
                    e.printStackTrace();
                    return Response.serverError().entity(e.getMessage()).build();
                }
            }
        }

        String message = "Incorrect username and/or password.";
        return Response.status(Status.BAD_REQUEST).entity(message).build();
    }
}


