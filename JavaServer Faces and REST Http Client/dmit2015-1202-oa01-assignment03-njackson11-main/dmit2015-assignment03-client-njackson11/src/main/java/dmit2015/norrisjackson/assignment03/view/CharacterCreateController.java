package dmit2015.norrisjackson.assignment03.view;

import dmit2015.norrisjackson.assignment03.client.Character;
import dmit2015.norrisjackson.assignment03.client.CharacterService;
import lombok.Getter;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.omnifaces.util.Messages;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.inject.Named;

/**
 * @author Norris Jackson
 * @version 2021/03/16
 * This controller class manages the create methods in the JSF interface
 */
@Named("currentCharacterCreateController")
@RequestScoped
public class CharacterCreateController {

    @Inject
    @RestClient
    private CharacterService _characterService;

    @Getter
    private Character newCharacter = new Character();

    public String onCreate() {
        String nextPage = "";
        try {
            _characterService.create(newCharacter);
            Messages.addFlashGlobalInfo("Create was successful.");
            nextPage = "index?faces-redirect=true";
        } catch (Exception e) {
            e.printStackTrace();
            Messages.addGlobalError("Create was not successful.");
        }
        return nextPage;
    }

}

