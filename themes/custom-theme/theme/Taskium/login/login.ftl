<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=true displayInfo=true; section>
  <#if section == "form">
    <!-- LOGO SECTION -->
    <div class="login-header" style="text-align: center; margin-bottom: 32px;">
      <img src="${url.resourcesPath}/img/7T.png" alt="7T.ai Logo" class="logo" style="height: 60px; width: auto; max-width: 200px; margin-bottom: 16px;">
      <h1 class="login-title">Taskium Login</h1>
    </div>
    
    <div class="login-form-container">
      <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">

        <div class="form-group">
          <label for="username" class="form-label">Email</label>
          <input tabindex="1" id="username" class="form-control" name="username" type="text"
                 autofocus autocomplete="off" placeholder="Enter your email" value="${(login.username!'')}">
        </div>

        <div class="form-group">
          <label for="password" class="form-label">Password</label>
          <div class="password-wrapper">
            <input tabindex="2" id="password" class="form-control" name="password" type="password"
                   placeholder="Enter your password" autocomplete="off">
            <button type="button" class="password-toggle" onclick="togglePassword()">
              <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                   xmlns="http://www.w3.org/2000/svg">
                <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"
                      stroke="currentColor" stroke-width="2" stroke-linecap="round"
                      stroke-linejoin="round"/>
                <circle cx="12" cy="12" r="3" stroke="currentColor" stroke-width="2"
                        stroke-linecap="round" stroke-linejoin="round"/>
              </svg>
            </button>
          </div>
        </div>

        <div class="form-actions">
          <input tabindex="4" class="login-button" name="login" id="kc-login" type="submit" value="Login"/>
        </div>
      </form>

      <div class="forgot-password-link">
        <a href="${url.loginResetCredentialsUrl!'#'}" class="forgot-password">Forgot Password?</a>
      </div>

      <#if social.providers??>
        <div id="kc-social-providers" class="kc-social-section">
          <h4>Or continue with</h4>
          <ul class="kc-social-providers">
            <#list social.providers as p>
              <li>
                <a id="social-${p.alias}" class="social-provider-button" type="button" href="${p.loginUrl}">
                  <#if p.iconClasses??>
                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">
                      <#if p.displayName?? && p.displayName != "">
                        ${p.displayName}
                      <#elseif p.alias == "google">
                        Sign in with Google
                      <#elseif p.alias == "facebook">
                        Sign in with Facebook
                      <#elseif p.alias == "github">
                        Sign in with GitHub
                      <#else>
                        Sign in with ${p.alias?capitalize}
                      </#if>
                    </span>
                  <#else>
                    <span class="${properties.kcFormSocialAccountNameClass!}">
                      <#if p.displayName?? && p.displayName != "">
                        ${p.displayName}
                      <#elseif p.alias == "google">
                        Sign in with Google
                      <#elseif p.alias == "facebook">
                        Sign in with Facebook
                      <#elseif p.alias == "github">
                        Sign in with GitHub
                      <#else>
                        Sign in with ${p.alias?capitalize}
                      </#if>
                    </span>
                  </#if>
                </a>
              </li>
            </#list>
          </ul>
        </div>
      </#if>

      <div class="powered-by">
        Powered by <span class="brand-name">7T.ai</span>
      </div>
    </div>
  </#if>
  
  <#if section == "info">
    <!-- Info section content if needed -->
  </#if>
</@layout.registrationLayout>

<script>
function togglePassword() {
  const input = document.getElementById('password');
  input.type = input.type === 'password' ? 'text' : 'password';
}
</script>
