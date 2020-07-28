import base64
import xml.etree.ElementTree as ET
import re
from bs4 import BeautifulSoup
import argparse
import os
import requests
import getpass
import boto3
import json


outputformat = 'json'
sslverification = True
idpentryurl = 'https://sts.lseg.com/adfs/ls/idpinitiatedsignon.aspx?loginToRp=urn:amazon:webservices'

os.environ['no_proxy'] = 'sts.lseg.com,{},{}'.format(
    os.getenv("no_proxy"), os.getenv("NO_PROXY"))


def getAccountId():
    """Gets the ID of an AWS Account
    Returns:
        [string] -- [Boto3 client grabs the current account id]
    """
    return boto3.client('sts').get_caller_identity().get('Account')

def listRoles(username, password, printRoles=True):
    """Lists roles available to a user

    Arguments:
        username {[String]} -- [AD User]
        password {[String]} -- [AD Password]

    Keyword Arguments:
        printRoles {bool} -- [Print role list to screen] (default: {True})

    Raises:
        Exception: [On invalid SAML response from IDP]

    Returns:
        [List, Object] -- [List of AWS roles, SAML Assertion object]
    """
    if not username:
        username = getpass.getuser()

    if "lseg\\" not in username and "@lseg" not in username:
        username = "lseg\\{}".format(username)

    session = requests.Session()
    formresponse = session.get(idpentryurl, verify=sslverification)
    idpauthformsubmiturl = formresponse.url

    # Parse the response and extract all the necessary values
    # in order to build a dictionary of all of the form values the IdP expects
    formsoup = BeautifulSoup(formresponse.text, "html.parser")
    payload = {}

    for inputtag in formsoup.find_all(re.compile('(INPUT|input)')):
        name = inputtag.get('name', '')
        value = inputtag.get('value', '')
        if "user" in name.lower():
            # Make an educated guess that this is the right field for the username
            payload[name] = username
            print("u: {}".format(payload[name]))

        elif "email" in name.lower():
            # Some IdPs also label the username field as 'email'
            payload[name] = username
            print("e: {}".format(payload[name]))

        elif "pass" in name.lower():
            # Make an educated guess that this is the right field for the password
            payload[name] = password
            print("p: {}".format(payload[name]))

        else:
            # Simply populate the parameter with the existing value (picks up hidden fields in the login form)
            payload[name] = value
            print("??: {}".format(payload[name]))

    #  Performs the submission of the IdP login form with the above post data
    response = session.post(
        idpauthformsubmiturl, data=payload, verify=sslverification)

    # Overwrite and delete the credential variables, just for safety
    username = '##############################################'
    password = '##############################################'
    del username
    del password

    # print(response.text)

    # Decode the response and extract the SAML assertion
    soup = BeautifulSoup(response.text, "html.parser")
    assertion = ''


    # Look for the SAMLResponse attribute of the input tag (determined by
    # analyzing the debug print lines above)
    for inputtag in soup.find_all('input'):
        if(inputtag.get('name') == 'SAMLResponse'):
            assertion = inputtag.get('value')

    # Better error handling is required for production use.
    if (assertion == ''):
        # TODO: Insert valid error checking/handling
        raise Exception(
            "-------- \n Response did not contain a valid SAML assertion, check username and password entered correctly")

    # Parse the returned assertion and extract the authorized roles
    awsroles = []
    root = ET.fromstring(base64.b64decode(assertion))
    for saml2attribute in root.iter('{urn:oasis:names:tc:SAML:2.0:assertion}Attribute'):
        if (saml2attribute.get('Name') == 'https://aws.amazon.com/SAML/Attributes/Role'):
            for saml2attributevalue in saml2attribute.iter('{urn:oasis:names:tc:SAML:2.0:assertion}AttributeValue'):
                awsroles.append(saml2attributevalue.text)

    if printRoles:
        roleno = 0
        for awsrole in awsroles:
            aws_role = awsrole.split(",")[1]
            #print(roleno, aws_role, flush=True)
            roleno += 1

    return awsroles, assertion


def getToken(username, password, roleName, printTokens=False, region="eu-west-2", DurationSeconds=3600):
    """[Gets an AWS STS token for a role]

    Arguments:
        username {String} -- [AD user]
        password {string} -- [AD password]
        roleName {String} -- [AWS role to assume]

    Keyword Arguments:
        printTokens {bool} -- [Print to screen?] (default: {False})
        writeConfigFile {bool} -- [Write to file?] (default: {False})
        region {str} -- [AWS region] (default: {"eu-west-2"})
        DurationSeconds {int} -- [Length of token validity] (default: {3600})

    Raises:
        Exception: [If role is not unique]
        Exception: [If role does not exist or permissions lacking]

    Returns:
        [Object] -- [Boto3 AWS STS Token]
    """

    awsroles, assertion = listRoles(username, password, False)
    r = re.compile(".*" + roleName)
    roles = list(filter(r.match, awsroles))

    if (len(roles)) > 1:
        raise Exception(
            "roles exists in multiple accounts, please contact CPS team for further help")

    elif (len(roles)) < 1:
        raise Exception(
            'Role name %s does not exists or you do not have permission' % roleName)
            
    else:
        role_arn = roles[0].split(',')[1]
        principal_arn = roles[0].split(',')[0]
        client = boto3.client('sts')
        token = client.assume_role_with_saml(
            RoleArn=role_arn, PrincipalArn=principal_arn, SAMLAssertion=assertion, DurationSeconds=DurationSeconds)

    if printTokens:
        print(token)

    return token

print ("getting token")

parser = argparse.ArgumentParser()
parser.add_argument('-u', '--username', dest="username", help="enter the window login id for which aws token to be issued")
parser.add_argument('-p', '--password', dest="password", help="enter the password for username", default="")
parser.add_argument('-r', '--role', dest="role", help="enter the password for username", default="bsl-cetdev-dev3-fulladmin-adfs-role")
args = parser.parse_args()

token = getToken(username=args.username, password=args.password, roleName=args.role)


with open("variables.json", "r+") as file:
    data=json.load(file)
    data["aws_access_key"]=token['Credentials']['AccessKeyId']
    data["aws_secret_key"]=token['Credentials']['SecretAccessKey']
    data["aws_token"]=token['Credentials']['SessionToken']
    file.seek(0)
    json.dump(data, file)
