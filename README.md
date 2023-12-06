# NTUC Web Pages

## Environement files
Make sure you have .env.local file with correct values.

## Running in Local 
Run yarn to install the packages
```
yarn
```

Run yarn start and access the demo page from http://localhost:3001
```
yarn start:dev
```

## Building for distribution

Change the version of the web components in the `package.json` file.

Run the build command
```
yarn build
```

The output folder with the right version number appended will be generated in the `./build` folder.

## Local SonarQube

A SonarQube `docker-compose` file is provided to easily run anlysis locally.

Simply run the command `yarn sonar-docker` to run a SonarQube container. You must have Docker installed.

> Remark: the container doesn't run in the background.

Then access SonarQube from http://localhost:9000 and login:
- Username: `admin`
- Password: `admin`

Setup a new project for NTUC Web Page if not done yet then keep the `projectKey` value. If you haven't done it yet, setup a token from **My Account -> Security** section of SonarQube instance. 

Copy-paste the `sonar-project.properties.example` file at the root of the project to `sonar-project.properties` and put there the `projectKey`, `url` (instance url, should be http://localhost:9000 if you haven't changed it) and `login` (the token you've generated just before) values.

Make sure `sonar-scanner` command is in your terminal path (you can download sonar-scanner from [here](https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/)). From the root of the project, run `yarn sonar` to run an analysis. You get view the results on the project's pages on SonarQube.

## Set up JSON server
To install json-server run following command.
```
npm install -g json-server
yarn api
```
To add endpoint response update `db.json`.
Update `routes.json` in order to point the response to correct route.

## Linkpass authentication

Linkpass authentication is integrated for local execution to allow testing the components for a logged in user.

Copy the `.env.local.example` file to `.env.local` and replace the parameters with those you have been given. Login and Logout buttons are available on the demo page.

## MyInfo
How to set up and test connexion with myInfo to retrieve data.

When testing in local environment, the callback URL *has to be set to http://localhost:3001/callback*. it's the only local URL allow by MyInfo services. Hence, App *has to run on port 3001*


## HTTP Calls and external services
### Structure
Everything is under `src/services/<serviceName>`

For now, we interact with two services: NTUC Backend application (*/ntuc*) and MyInfo (*/myInfo*)

Each NTUC micro-service has its own folder
 * `/memberService`
 * `/userService`
 * `/paymentService`
 * ...

 In every folder, we have one file per API group. Example: for the User Service, endpoints `/company/search` and `/company/ucem-upsert` will be in the same `company.ts` file.

## Form Validation

- Below is an example of validation for a form field named `BankAccountNumberField`.
### `Validator.ts`

One Validator interface defined for the whole app.

```typescript
interface FieldValidator<EntryType, ReturnType> {
    validate(entry: EntryType): ReturnType | null
}

export default FieldValidator
```

### `BankAccountNumberValidator.ts`

- One error enum per field. Enums hold the localization string.
- One validator per field. Here's a simple example, but it can be more complex, notably with API calls (don't forget to run side effects in useEffect functions)
- 
```typescript
import FieldValidator from './FieldValidator'

const MIN_LENGTH = 10

enum BankAccountNumberError {
    WrongLength = `bank-account-number-wrong-length`,
    NumbersOnly = `bank-account-number-only-numbers`,
}


class BankAccountNumberValidator implements FieldValidator<string, BankAccountNumberError>  {

    validate(entry: string): BankAccountNumberError | null {
        if (entry.length < MIN_LENGTH) {
            return BankAccountNumberError.WrongLength
        } else if (!entry.match(/^[0-9]*$/g)) {
            return BankAccountNumberError.NumbersOnly
        }
        return null
    }

}

export { BankAccountNumberError, BankAccountNumberValidator }
export default BankAccountNumberValidator
```

### `BankAccountNumberField.tsx`

```typescript
import { useState, ChangeEvent } from 'react'
import { useTranslation } from 'react-i18next'

import BankAccountNumberValidator from './BankAccountNumberValidator'

/**
 * Then declare the component and use the validator
 */
const BankAccountNumberField = () => {

    const { t } = useTranslation(`signup`)
    const [errorMesage, setErrorMessage] = useState(`No error`)

    const validator = new BankAccountNumberValidator()

    const handleBlur = (event: ChangeEvent<HTMLInputElement>) => {
        setErrorMessage(t(validator.validate(event.target.value) ?? ``))
    }

    return (
        <div>
            <input type="text" onBlur={handleBlur} />
            <p>{errorMesage}</p>
        </div>
    )
}

export { BankAccountNumberField }
```