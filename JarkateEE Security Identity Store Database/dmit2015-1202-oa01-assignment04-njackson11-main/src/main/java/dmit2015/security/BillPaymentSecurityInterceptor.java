package dmit2015.security;

import javax.inject.Inject;
import javax.interceptor.AroundInvoke;
import javax.interceptor.InvocationContext;
import javax.security.enterprise.SecurityContext;
import java.util.logging.Logger;

/**
 * @author Norris Jackson
 * @version 2021/03/30
 * This class manages the method level security for BillPayment methods
 */
public class BillPaymentSecurityInterceptor
{
    @Inject
    private Logger _logger;

    @Inject
    private SecurityContext _securityContext;

    @AroundInvoke
    public Object verifyAccess(InvocationContext ic) throws Exception
    {
        String methodName = ic.getMethod().getName();
        _logger.info("Entering method " + methodName);
        //Only authenticated users can access the methods.
        boolean havePermission = _securityContext.isCallerInRole("ADMIN") || _securityContext.isCallerInRole("REGISTER_USER");
        if (!havePermission)
        {
            throw new RuntimeException("Access denied! Only authenticated users have permission to execute this method");
        }
        return ic.proceed();
    }
}
