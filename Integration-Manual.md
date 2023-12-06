# Integration Manual

## Configuration

Provided components are developed using React.js and should be agnostic of the technology used in the hosting page. For that reason, passing configuration to the components is done through a single `window.myNtucConfig` global structure.

Below table lists all parameters and indicates if they are mandatory for each component.

| Parameter                      | Description                                                                          |  Signup   |  Payment  |
| ------------------------------ | ------------------------------------------------------------------------------------ | :-------: | :-------: |
| `authToken`                    | Authentication token retrieved from Linkpass authentication endpoint                 | Optional  | Mandatory |
| `mpBaseUrl`                    | Base URL of Membership Platform (see below for possible values)                      | Optional  | Mandatory |
| `assetsBaseUrl`                | Base URL for accessing Membership Platform resources (see below for possible values) | Optional  | Mandatory |
| `myInfoBaseUrl`                | Base URL for for MyInfo                                                              | Madatory  |     -     |
| `myInfoCallbackUrl`            | Callback URL from MyInfo                                                             | Madatory  |     -     |
| `myInfoClientId`               | Client ID for MyInfo                                                                 | Madatory  |     -     |
| `signupPaymentCallbackUrl`     | Callback URL from the payment gateway after Signup                                   | Madatory  |     -     |
| `recurringPaymentCallbackUrl`  | Callback URL from the payment gateway after recurring payment is set                 |     -     | Mandatory |
| `membershipPaymentCallbackUrl` | Callback URL from the payment gateway after an arrear payment has been made          |     -     | Mandatory |
| `signupBackToHomeHomeUrl`      | The where the user is redirected when clicking "back to home" after Signup flow      | Mandatory |     -     |
| `paymentBackToHomeHomeUrl`     | The where the user is redirected when clicking "back to home" after Payment flow     |     -     | Mandatory |
| `linkPassBaseUrl`              | Base URL of Linkpass API                                                             | Mandatory |     -     |
| `campaignCode`                 | Campaign code to be used for the signup                                              |           |           |
| `membershipId`                 | ID of the membership for which payments options should be displayed.                 |     -     | Mandatory |
| `homeUrl`                      | URL to redirect users to when they click a `Return to home` button.                  | Mandatory |     -     |
| `loginUrl`                     | URL to redirect users to when they click a `Login` button.                           | Mandatory |     -     |
| `referralCode`                 | Referral code to pre-fill the Referral code's tab' fields.                           | Mandatory |     -     |
| `recruiterCode`                | Recruiter code to pre-fill the Referral code's tab' fields.                          | Mandatory |     -     |

```typescript
window.myNtucConfig = {
    authToken: string | undefined
    mpBaseUrl: string | undefined
    assetsBaseUrl: string | undefined
    myInfoBaseUrl: string | undefined
    myInfoCallbackUrl: string | undefined
    myInfoClientId: string | undefined
    signupPaymentCallbackUrl: string | undefined
    recurringPaymentCallbackUrl: string | undefined
    membershipPaymentCallbackUrl: string | undefined
    signupBackToHomeHomeUrl: string | undefined
    paymentBackToHomeHomeUrl: string | undefined
    linkPassBaseUrl: string | undefined
    campaignCode: string | undefined
    membershipId: string | undefined
    homeUrl: string | undefined
    loginUrl: string | undefined
    referralCode: string | undefined
    recruiterCode: string | undefined
}
```

### Member Platform base URLs
- DEV environment: https://apimdev.ntuc.org.sg/api
- UAT environment: https://apimuat.ntuc.org.sg/api
- PROD environment: https://apim.ntuc.org.sg/api
  
### Member Platform assets base URLs
- DEV environment: https://devma.ntuc.org.sg
- UAT environment: https://uatma.ntuc.org.sg
- PROD environment: https://ma.ntuc.org.sg

### MyInfo URLs
- UAT environment: https://test.api.myinfo.gov.sg/com/v3
- PROD environment: https://api.myinfo.gov.sg/com/v3

> ### __Linkpass auth token__
> 
> The linkpass auth token should be retrieved for:
> - audience `https://api.ntucmp.org.sg`
> - scope `openid profile scid:read:profile scid:update:profile scid:update:preferences scid:verify:myinfo scid:update:account_security offline_access`
> For any question related to Linkpas, please contact the NE Digital Team

> __IMPORTANT!__
> - `myInfoCallbackUrl` must redirect the user to a page containing the signup flow component and it should be added to authorized callback URLs from NTUC's MyInfo account (ITD team can help you with that).
> - `signupPaymentCallbackUrl` must redirect the user to a page containing the signup flow component and must be different from `recurringPaymentCallbackUrl` and `membershipPaymentCallbackUrl`.
> - `recurringPaymentCallbackUrl` must redirect the user to a page containing the payment flow component and must be different from `membershipPaymentCallbackUrl` and `signupPaymentCallbackUrl`.
> - `membershipPaymentCallbackUrl` must redirect the user to a page containing the payment flow component and must be different from `recurringPaymentCallbackUrl` and `signupPaymentCallbackUrl`.
> - `campaignCode` is being saved in a cookie by the component. This cookie contains the campaign code only. Please make sure cookies declaration is aligned with local regulations.

## Cookies

The components are using cookies. Please make sure cookies declaration is aligned with local regulations.

| Cookie       | Description                                                                          |
| ------------ | ------------------------------------------------------------------------------------ |
| campaignCode | The campaign code provided from myNtucConfig for using it after a MyInfo redirection |
| membershipId | User's membership ID for using it after a payment redirection                        |

## Available components

Both components are packaged at the same time but can be used independently. The `index.html` file in the distribution folder shows an exampled of integration of both components.

## Testing payments

When testing payments on UAT, you can use the following information:

**FAST**
UserID:DFPREL027
Password:264799
OTP: 111111
*Take note: this is only usable if your IP is whitelisted. Please request to ITD for whitelisting.*

**Credit Card**

Master
Card No : 2223-0000-0000-0007
Name : [Any text will do]
Month : 05 / Year : 23
CVV : 100

VISA
Card No : 4111-1111-1111-1111
Name : [Any text will do]
Month : 05 / Year : 23
CVV : 100

### Signup

The signup component contains all pages and flow for signing up to a membership. The component is available in the 2 distribution folders:
- `signup_uat`: using UAT environments
- `signup_pro`: using PROD environments

To integrate the component in an HTML page, you must first include the script and css files.

```html
<script defer="defer" src="/static/js/main.[HASH].js"></script>
<link href="/static/css/main.[HASH].css" rel="stylesheet">
```

Then insert a `div` element with the id `signup-flow` in your page.

```html
<div id="signup-flow"></div>
```

A complete example can be found in the `index.html` file located in the distribution folder.

### Payment

The payment component allows a member to either set a recurring payment for membership payments or pay for membership arrears. The component is available in the 2 distribution folders:
- `payment_uat`: using UAT environments
- `payment_pro`: using PROD environments

To integrate the component in an HTML page, you must first include the script and css files.

```html
<script defer="defer" src="/static/js/main.[HASH].js"></script>
<link href="/static/css/main.[HASH].css" rel="stylesheet">
```

Then insert a `div` element with the id `payment-flow` in your page.

```html
<div id="membership-payment"></div>
```

A complete example can be found in the `index.html` file located in the distribution folder.