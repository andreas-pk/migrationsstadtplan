class site (
 $role = 'default'
) {
  info('What will be the role?')

  include "site::role::${role}"
}