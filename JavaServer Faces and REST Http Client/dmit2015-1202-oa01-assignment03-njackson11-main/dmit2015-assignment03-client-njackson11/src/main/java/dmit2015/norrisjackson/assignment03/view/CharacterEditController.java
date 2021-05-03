package dmit2015.norrisjackson.assignment03.view;

import dmit2015.norrisjackson.assignment03.client.Character;
import dmit2015.norrisjackson.assignment03.client.CharacterService;
import lombok.Getter;
import lombok.Setter;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.omnifaces.util.Faces;
import org.omnifaces.util.Messages;

import javax.annotation.PostConstruct;
import javax.faces.annotation.ManagedProperty;
import javax.faces.view.ViewScoped;
import javax.inject.Inject;
import javax.inject.Named;
import javax.ws.rs.PathParam;
import java.io.Serializable;
import java.util.Optional;
/**
 * @author Norris Jackson
 * @version 2021/03/16
 * This controller class manages the edit methods in the JSF interface
 */
@Named("currentCharacterEditController")
@ViewScoped
public class CharacterEditController implements Serializable {

    @Inject
    @RestClient
    private CharacterService _characterService;

    @Inject
    @ManagedProperty("#{param.editId}")
    @Getter
    @Setter
    private Long editId;

    @Getter
    private Character existingCharacter;

    @PostConstruct
    public void init() {
        if (!Faces.isPostback()) {
            Optional<Character> optionalCharacter = Optional.ofNullable(_characterService.findOneById(editId));
            optionalCharacter.ifPresent(entity -> existingCharacter = entity);
        }
    }

    public String onUpdate() {
        String nextPage = "";
        try {
            _characterService.update(editId, existingCharacter);
            Messages.addFlashGlobalInfo("Update was successful.");
            nextPage = "index?faces-redirect=true";
        } catch (Exception e) {
            e.printStackTrace();
            Messages.addGlobalError("Update was not successful.");
        }
        return nextPage;
    }

    public String onDelete() {
        String nextPage = "";
        try {
            _characterService.delete(existingCharacter.getId());
            Messages.addFlashGlobalInfo("Delete was successful.");
            nextPage = "index?faces-redirect=true";
        } catch (Exception e) {
            e.printStackTrace();
            Messages.addGlobalError("Delete not successful.");
        }
        return nextPage;
    }
}

