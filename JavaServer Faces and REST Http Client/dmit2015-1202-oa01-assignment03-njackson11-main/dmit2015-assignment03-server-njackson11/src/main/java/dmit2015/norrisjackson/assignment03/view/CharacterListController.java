package dmit2015.norrisjackson.assignment03.view;

import dmit2015.norrisjackson.assignment03.entity.Character;
import dmit2015.norrisjackson.assignment03.repository.CharacterRepository;
import org.omnifaces.util.Messages;
import lombok.Getter;

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
    private CharacterRepository _characterRepository;

    @Getter
    private List<Character> characterList;

    @PostConstruct  // After @Inject is complete
    public void init() {
        try {
            characterList = _characterRepository.findAll();
        } catch (RuntimeException ex) {
            Messages.addGlobalError(ex.getMessage());
        }
    }
}

