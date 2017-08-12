// signal.h
#ifndef __SIGNAL__
#define __SIGNAL__


#define	SIGINT		2	/* Interactive attention */
#define	SIGILL		4	/* Illegal instruction */
#define	SIGFPE		8	/* Floating point error */
#define	SIGSEGV		11	/* Segmentation violation */
#define	SIGTERM		15	/* Termination request */
#define SIGBREAK	21	/* Control-break */
#define	SIGABRT		22	/* Abnormal termination (abort) */
#define NSIG 23			/* maximum signal number + 1 */

#ifndef _SIG_ATOMIC_T_DEFINED
typedef int sig_atomic_t;
#define _SIG_ATOMIC_T_DEFINED
#endif

typedef	void(*__p_sig_fn_t)(int);

#define	SIG_DFL	((__p_sig_fn_t) 0)
#define	SIG_IGN	((__p_sig_fn_t) 1)
#define	SIG_ERR ((__p_sig_fn_t) -1)
#define SIG_SGE ((__p_sig_fn_t) 3)
#define SIG_ACK ((__p_sig_fn_t) 4)

#ifdef __cplusplus
extern "C" {
#endif

__p_sig_fn_t signal(int, __p_sig_fn_t);
//int raise(int);// Raise the signal indicated by sig. Returns non-zero on success.

#ifdef __cplusplus
}
#endif

#endif // __SIGNAL__