package dmit2015.security;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.inject.Named;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;

/**
 * @author Norris Jackson
 * @version 2021/03/30
 * This class manages logging out
 */

@Named
@RequestScoped
public class Logout {

    @Inject
    private HttpServletRequest request;

    public String submit() throws ServletException {
        request.logout();
        request.getSession().invalidate();
        return "/index?faces-redirect=true";
    }
}

