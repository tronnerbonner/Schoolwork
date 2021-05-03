package dmit2015.view;

import dmit2015.client.Character;
import dmit2015.client.CharacterService;
import dmit2015.security.LoginSession;
import lombok.Getter;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.omnifaces.util.Messages;

import javax.annotation.PostConstruct;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import java.io.Serializable;
import java.util.List;

/**
 * @author Norris Jackson
 * @version 2021/03/16
 * This controller class manages the listview in the JSF interface
 */
@Named("currentCharacterListController")
@ViewScoped
public class CharacterListController implements Serializable {

    @Inject
    @RestClient
    private CharacterService _characterService;

    @Inject
    private LoginSession _loginSession;

    @Getter
    private List<Character> characterList;

    @PostConstruct  // After @Inject is complete
    public void init() {
        String authorization = _loginSession.getAuthorization();
        try {
            characterList = _characterService.findAllByUsername(authorization);
        } catch (RuntimeException ex) {
            Messages.addGlobalError(ex.getMessage());
        }
    }
}

