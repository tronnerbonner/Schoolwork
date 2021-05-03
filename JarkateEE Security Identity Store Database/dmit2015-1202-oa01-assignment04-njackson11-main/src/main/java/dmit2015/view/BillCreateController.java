package dmit2015.view;

import dmit2015.entity.Bill;
import dmit2015.repository.BillRepository;
import lombok.Getter;
import org.omnifaces.util.Messages;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.inject.Named;

/**
 * @author Norris Jackson
 * @version 2021/03/30
 * This class manages the BillCreate jsf methods
 */

@Named("currentBillCreateController")
@RequestScoped
public class BillCreateController {

    @Inject
    private BillRepository _billRepository;

    @Getter
    private Bill newBill = new Bill();

    public String onCreate() {
        String nextPage = "";
        try {
            _billRepository.create(newBill);
            Messages.addFlashGlobalInfo("Create was successful.");
            nextPage = "index?faces-redirect=true";
        }
        catch (RuntimeException e)
        {
            Messages.addGlobalWarn(e.getMessage());
        }
        catch (Exception e) {
            e.printStackTrace();
            Messages.addGlobalError("Create was not successful. {0}", e.getMessage());
        }
        return nextPage;
    }

}