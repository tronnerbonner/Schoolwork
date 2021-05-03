package dmit2015.security;

import org.omnifaces.util.Faces;

import javax.enterprise.context.RequestScoped;
import javax.inject.Named;
import javax.servlet.ServletException;

@Named
@RequestScoped
public class Logout {

    public void submit() throws ServletException {
        Faces.invalidateSession();
        Faces.redirect( Faces.getRequestContextPath() + "/login.xhtml?faces-redirect=true");
    }

}


