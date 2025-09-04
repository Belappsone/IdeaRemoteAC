
#ifndef _NETINET_IF_ETHER_H_
#define _NETINET_IF_ETHER_H_
#include <sys/appleapiopts.h>


#include <netinet/in.h>
#include "if_arp.h"
#define ea_byte	ether_addr_octet

/*
 * Macro to map an IP multicast address to an Ethernet multicast address.
 * The high-order 25 bits of the Ethernet address are statically assigned,
 * and the low-order 23 bits are taken from the low end of the IP address.
 */
#define ETHER_MAP_IP_MULTICAST(ipaddr, enaddr) \
/* struct in_addr *ipaddr; */ \
/* u_char enaddr[ETHER_ADDR_LEN];	   */ \
{ \
(enaddr)[0] = 0x01; \
(enaddr)[1] = 0x00; \
(enaddr)[2] = 0x5e; \
(enaddr)[3] = ((const u_char *)ipaddr)[1] & 0x7f; \
(enaddr)[4] = ((const u_char *)ipaddr)[2]; \
(enaddr)[5] = ((const u_char *)ipaddr)[3]; \
}
/*
 * Macro to map an IP6 multicast address to an Ethernet multicast address.
 * The high-order 16 bits of the Ethernet address are statically assigned,
 * and the low-order 32 bits are taken from the low end of the IP6 address.
 */
#define ETHER_MAP_IPV6_MULTICAST(ip6addr, enaddr)			\
/* struct	in6_addr *ip6addr; */					\
/* u_char	enaddr[ETHER_ADDR_LEN]; */				\
{                                                                       \
(enaddr)[0] = 0x33;						\
(enaddr)[1] = 0x33;						\
(enaddr)[2] = ((const u_char *)ip6addr)[12];				\
(enaddr)[3] = ((const u_char *)ip6addr)[13];				\
(enaddr)[4] = ((const u_char *)ip6addr)[14];				\
(enaddr)[5] = ((const u_char *)ip6addr)[15];				\
}

/*
 * Ethernet Address Resolution Protocol.
 *
 * See RFC 826 for protocol description.  Structure below is adapted
 * to resolving internet addresses.  Field names used correspond to
 * RFC 826.
 */

#define	arp_hrd	ea_hdr.ar_hrd
#define	arp_pro	ea_hdr.ar_pro
#define	arp_hln	ea_hdr.ar_hln
#define	arp_pln	ea_hdr.ar_pln
#define	arp_op	ea_hdr.ar_op

struct sockaddr_inarp {
    u_char	sin_len;
    u_char	sin_family;
    u_short sin_port;
    struct	in_addr sin_addr;
    struct	in_addr sin_srcaddr;
    u_short	sin_tos;
    u_short	sin_other;
#define	SIN_PROXY	0x1
#define	SIN_ROUTER	0x2
};
/*
 * IP and ethernet specific routing flags
 */
#define	RTF_USETRAILERS	RTF_PROTO1	/* use trailers */
#define RTF_ANNOUNCE	RTF_PROTO2	/* announce new arp entry */


#endif /* _NETINET_IF_ETHER_H_ */
