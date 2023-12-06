# Changelog
## Version 1.1.12
- Fix the race is empty when sign up by apply myinfo
## Version 1.1.11
- Fix apply with myinfo callback
- Fix not post/update Membership OA Data
- Remove non-license font
- Limit street input length into 35 characters
## Version 1.1.10
- Change survey link type from text to button
- Enlarge the "Start Application"
- Include the campaign code after MyInfo retrieval

## Version 1.1.9
- Fix redirected to Campaign Code Sign Up

## Version 1.1.8
- Enlarge the "Start Application"
- Add Survey Link on the Congratulations/ Thank You Page

## Version 1.1.7
- Fix redirected to Campaign Code Sign Up

## Version 1.1.6 
- Change number of month for upfront payment from 6 to 3 months

## Version 1.1.5 
- Fix keep rolling to top of signup membership page

## Version 1.1.4 
- Fix Additional +65 when pulling data from myinfo

## Version 1.1.3:
- Fix missing letter "were"
- Display email when signup membership while login 
- Show alert when failed to setup recurring for Renewal flow

## Version 1.1.2:

- Fix duplicate letter "We" when show payment result for recurring payment 
- Fix wrong payment result page of Sign up flow 
- Disable ePayment in payment service

## Version 1.1.1:

- Fix email text field when cursor was going to the end when user changes in the middle of the string
- Fix tab color after loading a draft
- Fix date of birth field on draft page showing error on page load
- Update the phone number in an alert box

## Version 1.1.0:
  
- Updated the message when setting recurring payment mode fails  
- Handle a successful signup with successful recurring payment and unsuccessful upfront payment
- Handle a successful signup with unsuccessful recurring payment and successful upfront payment
- Allows user to retry upfront payment for a successful signup with successful recurring payment and unsuccessful upfront payment
- Add the referral code tab in signup form
- Fix non-working "Try again" button after unsuccessful signup payment
- Fix some text in the bank details tab

## Version 1.0.1:

- Fix blank screen after "Try Again" is clicked is Signup payment flow
- Fix Support phone number in error popups
- Fix "Select gender" string in the signup summary page

## Version 0.2.4:

- Consider an empty `authToken` as undefined in draft retrieval page

## Version 0.2.3:

- Add 2 parameters to setup URL to be used for the back to home button after payment
  - 1 for the Signup flow
  - 1 for the Membership Payment flow
- Remove all asterisks to align with mobile application design
- Display a generic error message when the membership ID provided in `myNtucConfig` does not match any membership for the current user
- Display an explicit console error message when the membership ID provided in `myNtucConfig` does not match any membership for the current user
- Add logs to determine if components are loading correctly