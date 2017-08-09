#!/bin/bash
# Example Dovecot checkpassword script that may be used as both passdb or userdb.
# FakeAuth, will allow any user/pass combination.# Implementation guidelines at http://wiki2.dovecot.org/AuthDatabase/CheckPassword# The first and only argument is path to checkpassword-reply binary.
# It should be executed at the end if authentication succeeds.
CHECKPASSWORD_REPLY_BINARY="$1"

# Messages to stderr will end up in mail log (prefixed with "dovecot: auth: Error:")
LOG=/dev/stderr

# User and password will be supplied on file descriptor 3.
INPUT_FD=3

# Error return codes.
ERR_PERMFAIL=1
ERR_NOUSER=3
ERR_TEMPFAIL=111

# Make testing this script easy. To check it just run:
#   printf '%s\x0%s\x0' <user> <password> | ./checkpassword.sh test; echo "$?"
if [ "$CHECKPASSWORD_REPLY_BINARY" = "test" ]; then
CHECKPASSWORD_REPLY_BINARY=/bin/true
INPUT_FD=0
fi

# Read input data. Password may be empty if not available (i.e. if doing credentials lookup).
read -d $'\x0' -r -u $INPUT_FD USER
read -d $'\x0' -r -u $INPUT_FD PASS

# Both mailbox and domain directories should be in lowercase on file system.
# So let's convert login user name to lowercase and tell Dovecot 'user' and 'home' (which overrides
# 'mail_home' global parameter) values should be updated.
# Of course, conversion to lowercase may be done in Dovecot configuration as well.
export USER="`echo \"$USER\" | tr 'A-Z' 'a-z'`"
mail_name="`echo \"$USER\" | awk -F '@' '{ print $1 }'`"
domain_name="`echo \"$USER\" | awk -F '@' '{ print $2 }'`"
export HOME="/var/vmail/$domain_name/$mail_name/"


# Dovecot calls the script with AUTHORIZED=1 environment set when performing a userdb lookup.
# The script must acknowledge this by changing the environment to AUTHORIZED=2,
# otherwise the lookup fails.
[ "$AUTHORIZED" != 1 ] || export AUTHORIZED=2

# Always return OK ;)
exec $CHECKPASSWORD_REPLY_BINARY

