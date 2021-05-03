package dmit2015.security;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.inject.Named;
import javax.json.Json;
import javax.json.JsonObject;
import javax.validation.constraints.NotBlank;

import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.omnifaces.util.Messages;

import lombok.Getter;
import lombok.Setter;

@Named
@RequestScoped
public class Login {

    @Inject
    @RestClient
    private LoginService _loginService;

    @NotBlank(message = "Username value is required.")
    @Getter
    @Setter
    private String username;

    @NotBlank(message = "Password value is required.")
    @Getter
    @Setter
    private String password;

    @Inject
    private LoginSession _loginSession;

    public String submit() {
        String nextPage = null;
        JsonObject credentials = Json.createObjectBuilder()
                .add("username", username)
                .add("password", password)
                .build();
        try {
            String token = _loginService.jsonLogin(credentials);
            _loginSession.setToken(token);
            _loginSession.setUsername(username);
            nextPage = "/index?faces-redirect=true";
        } catch (Exception e) {
            Messages.addGlobalError(e.getMessage());
        }

        return nextPage;
    }

}


