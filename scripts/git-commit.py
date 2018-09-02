#!/bin/python
import argparse
import subprocess


def check_message_length(message, message_body=None):
    """ Check length of messages
    message_length > 50: Show WARNING (Valid but not recommend)
    message_length > 68: Invalid
    """
    if len(message) > 68:
        print('\nCommit messages too long ({} > 68).'.format(len(message)))
        return
    if len(message) > 50:
        print('\nWARNING: Your message is longer than 50 characters.')
        verify = input('Commit anyway? (y/n) ')
        if verify.lower() not in ['yes', 'y']:
            return
    if message_body:
        long_message_body = ['{0} ({1} > 78)\n'.format(mes, len(mes))
                             for mes in message_body if len(mes) > 78]
        if long_message_body:
            print('\nMessage body is too long')
            print(''.join(long_message_body))
            return
    return True


def run_git_commit(message, commit_all=False):
    if commit_all:
        command = ['git', 'commit', '-am', message]
    else:
        command = ['git', 'commit', '-m', message]
    execute_command = subprocess.run(command)
    if execute_command.returncode == 0:
        return
    print('Something went wrong')


def main():
    parser = argparse.ArgumentParser(
        description='Git commit with validate commit messages length.'
        )
    parser.add_argument('message', help='Message of commit')
    parser.add_argument('-a', "--all", help='Same as git commit -am',
                        action='store_true')
    args = parser.parse_args()

    commit_all = True if args.all else False

    message = args.message.strip().split('\n')

    # Commit message with no message body
    if len(message) == 1:
        if check_message_length(message[0]):
            run_git_commit(message[0], commit_all)
        return

    # Commit message is seperated with its body by a blankline,
    # so we need to find the first blankline, which became empty when we
    # use split('\n'). And just in case user put space into blankline,
    # we need to strip all of it
    message = [mes.strip() if mes.isspace() else mes for mes in message]
    blankline_index = message.index('') if '' in message else 0
    if not blankline_index:
        # Commit message doesn't have commit body but in multiple lines
        commit_message = ' '.join(message)
        if check_message_length(commit_message):
            run_git_commit(commit_message, commit_all)
    else:
        commit_message = ' '.join(message[:blankline_index])
        commit_body = message[blankline_index+1:]
        if check_message_length(commit_message, commit_body):
            commit_body = ''.join(commit_body)
            message = commit_message + '\n\n' + commit_body
            run_git_commit(message, commit_all)


if __name__ == '__main__':
    main()
