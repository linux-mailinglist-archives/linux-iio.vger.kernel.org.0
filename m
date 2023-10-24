Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258237D54EA
	for <lists+linux-iio@lfdr.de>; Tue, 24 Oct 2023 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjJXPMH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Oct 2023 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjJXPMF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Oct 2023 11:12:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E5A1BC1
        for <linux-iio@vger.kernel.org>; Tue, 24 Oct 2023 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=Eav3/Lmyl/Blol0vwu1eUA6K6U9k1odPp1lk+3dNkGo=; b=WlcX7zKWKlH48+pvJ4Bzu/FhGV
        3l7V2s0+DIdLx5vmGh7RU5G0B+QCp7NoC7swlffxaFJahircOijvBKcGyA1TxpGjxz6e/kxPModu2
        bZDIsCv1TDD1r9qhnkd991IdC70CHLAb6o9H5jwMWdAAMv7siRWTVGgOnNpOIbon01ymGiJ050gxS
        cJ/GCOoDvZv6Ha8Rl5A+PP7Jn99nyy5DMpLAO+8xLQCV3daQn9aTKxAt5wDpfhmyMk6f1BPpPd5si
        LkesVKTluqSnIp8AGpUlanCLvR1Ttg2vVurf57m2C6f7Gu3Csc4dTiXrgT3wV5DSjpS7bdl/kxd75
        VQhoUbuw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qvJ3z-003BcZ-GF; Tue, 24 Oct 2023 15:11:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DCA9300451; Tue, 24 Oct 2023 17:11:23 +0200 (CEST)
Date:   Tue, 24 Oct 2023 17:11:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     David Lechner <dlechner@baylibre.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based direct
 mode claiming infrastructure
Message-ID: <20231024151123.GB40044@noisy.programming.kicks-ass.net>
References: <20231022154710.402590-1-jic23@kernel.org>
 <20231022154710.402590-2-jic23@kernel.org>
 <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
 <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 23, 2023 at 10:55:56AM +0200, Nuno Sá wrote:

> > > +/*
> > > + * Auto cleanup version of iio_device_claim_direct_mode,
> > > + *
> > > + *     CLASS(iio_claim_direct, claimed_dev)(indio_dev);
> > > + *     if (IS_ERR(claimed_dev))
> > > + *             return PTR_ERR(claimed_dev);
> > > + *
> > > + *     st = iio_priv(claimed_dev);
> > > + *     ....
> > > + */
> > > +DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
> > > +            iio_device_release_direct_mode(_T),
> > > +            ({
> > > +                       struct iio_dev *dev;
> > > +                       int d = iio_device_claim_direct_mode(_T);
> > > +
> > > +                       if (d < 0)
> > > +                               dev = ERR_PTR(d);
> > > +                       else
> > > +                               dev = _T;
> > > +                       dev;
> > > +            }),
> > > +            struct iio_dev *_T);
> > > +

> I don't really have a very strong opinion on this but what I really don't like
> much is the pattern:
> 
> CLASS(type, ret), where the return value is an argument of the macro... It would
> be nice if we could just make it like:
> 
> ret = guard(type)(...); //or any other variation of the guard() macro
> if (ret) 
> 	return ret;
> 
> the above could also be an error pointer or even have one variation of each. but
> yeah, that likely means changing the cleanup.h file and that might be out of
> scope for Jonathan's patch series. 

So I have a version for trylocks that I've not managed to send out.. it
doesn't deal with arbitrary error codes, and as someone else down-thread
noted, the guard() thing is not really suited for tricks like this.

Notably I have a patch that converts ptrace_attach() to have a loop like:

	scoped_guard (mutex_intr, &task->signal->cred_guard_mutex) {

		goto success;
	}
	return -ERESTARTNOINTR;

success:
	...
	return 0;


And another patch that does something like:

	scoped_cond_guard (rwsem_read_intr, no_lock,
			   task ? &task->signal->exec_update_lock : NULL) {

		if (0) {
no_lock:
			if (task)
				return -EINTR;
		}
		
		...
	}


---
Subject: cleanup: Add conditional guard support
From: Peter Zijlstra <peterz@infradead.org>
Date: Sun Sep 17 13:22:17 CEST 2023

Adds:

 - DEFINE_GUARD_COND() / DEFINE_LOCK_GUARD_1_COND() to extend existing
   guards with conditional lock primitives, eg. mutex_trylock(),
   mutex_lock_interruptible().

   nb. both primitives allow NULL 'locks', which cause the lock to
       fail (obviously).

 - extends scoped_guard() to not take the body when the the
   conditional guard 'fails'. eg.

     scoped_guard (mutex_intr, &task->signal_cred_guard_mutex) {
	...
     }

   will only execute the body when the mutex is held.

 - provides scoped_cond_guard(name, label, args...); which extends
   scoped_guard() to jump to @label when the lock fails.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
Index: linux-2.6/include/linux/cleanup.h
===================================================================
--- linux-2.6.orig/include/linux/cleanup.h
+++ linux-2.6/include/linux/cleanup.h
@@ -136,14 +136,35 @@ static inline class_##_name##_t class_##
  */
 
 #define DEFINE_GUARD(_name, _type, _lock, _unlock) \
-	DEFINE_CLASS(_name, _type, _unlock, ({ _lock; _T; }), _type _T)
+	DEFINE_CLASS(_name, _type, if (_T) { _unlock; }, ({ _lock; _T; }), _type _T); \
+	static inline void * class_##_name##_lock_ptr(class_##_name##_t *_T) \
+	{ return *_T; }
+
+#define DEFINE_GUARD_COND(_name, _ext, _condlock) \
+	EXTEND_CLASS(_name, _ext, \
+		     ({ void *_t = _T; if (_T && !(_condlock)) _t = NULL; _t; }), \
+		     class_##_name##_t _T) \
+	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
+	{ return class_##_name##_lock_ptr(_T); }
+
+#define _guard(_name, var)						\
+	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
+		class_##_name##_constructor
 
 #define guard(_name) \
-	CLASS(_name, __UNIQUE_ID(guard))
+	_guard(_name, __UNIQUE_ID(guard))
+
+#define __guard_ptr(_name) class_##_name##_lock_ptr
 
 #define scoped_guard(_name, args...)					\
 	for (CLASS(_name, scope)(args),					\
-	     *done = NULL; !done; done = (void *)1)
+	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
+
+#define scoped_cond_guard(_name, _label, args...) \
+	for (CLASS(_name, scope)(args), \
+	     *done = NULL; !done; done = (void *)1) \
+		if (!__guard_ptr(_name)(&scope)) goto _label; \
+		else
 
 /*
  * Additional helper macros for generating lock guards with types, either for
@@ -173,6 +194,11 @@ typedef struct {							\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
 {									\
 	if (_T->lock) { _unlock; }					\
+}									\
+									\
+static inline void *class_##_name##_lock_ptr(class_##_name##_t *_T)	\
+{									\
+	return _T->lock;						\
 }
 
 
@@ -201,4 +227,14 @@ __DEFINE_LOCK_GUARD_1(_name, _type, _loc
 __DEFINE_UNLOCK_GUARD(_name, void, _unlock, __VA_ARGS__)		\
 __DEFINE_LOCK_GUARD_0(_name, _lock)
 
+#define DEFINE_LOCK_GUARD_1_COND(_name, _ext, _condlock)		\
+	EXTEND_CLASS(_name, _ext,					\
+		     ({ class_##_name##_t _t = { .lock = l }, *_T = &_t;\
+		        if (_T->lock && !(_condlock)) _T->lock = NULL;	\
+			_t; }),						\
+		     typeof_member(class_##_name##_t, lock) l)		\
+	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
+	{ return class_##_name##_lock_ptr(_T); }
+
+
 #endif /* __LINUX_GUARDS_H */
Index: linux-2.6/include/linux/mutex.h
===================================================================
--- linux-2.6.orig/include/linux/mutex.h
+++ linux-2.6/include/linux/mutex.h
@@ -221,6 +221,7 @@ extern void mutex_unlock(struct mutex *l
 extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
 
 DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
-DEFINE_FREE(mutex, struct mutex *, if (_T) mutex_unlock(_T))
+DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
+DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T) == 0)
 
 #endif /* __LINUX_MUTEX_H */
Index: linux-2.6/include/linux/spinlock.h
===================================================================
--- linux-2.6.orig/include/linux/spinlock.h
+++ linux-2.6/include/linux/spinlock.h
@@ -507,6 +507,8 @@ DEFINE_LOCK_GUARD_1(raw_spinlock, raw_sp
 		    raw_spin_lock(_T->lock),
 		    raw_spin_unlock(_T->lock))
 
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock, _try, raw_spin_trylock(_T->lock))
+
 DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
 		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
 		    raw_spin_unlock(_T->lock))
@@ -515,23 +517,36 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_irq, ra
 		    raw_spin_lock_irq(_T->lock),
 		    raw_spin_unlock_irq(_T->lock))
 
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lock))
+
 DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
 		    raw_spin_lock_irqsave(_T->lock, _T->flags),
 		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
 
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irqsave, _try,
+			 raw_spin_trylock_irqsave(_T->lock, _T->flags))
+
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),
 		    spin_unlock(_T->lock))
 
+DEFINE_LOCK_GUARD_1_COND(spinlock, _try, spin_trylock(_T->lock))
+
 DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
 		    spin_lock_irq(_T->lock),
 		    spin_unlock_irq(_T->lock))
 
+DEFINE_LOCK_GUARD_1_COND(spinlock_irq, _try,
+			 spin_trylock_irq(_T->lock))
+
 DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
 		    spin_lock_irqsave(_T->lock, _T->flags),
 		    spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
 
+DEFINE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
+			 spin_trylock_irqsave(_T->lock, _T->flags))
+
 #undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
Index: linux-2.6/include/linux/rwsem.h
===================================================================
--- linux-2.6.orig/include/linux/rwsem.h
+++ linux-2.6/include/linux/rwsem.h
@@ -203,11 +203,11 @@ extern void up_read(struct rw_semaphore
 extern void up_write(struct rw_semaphore *sem);
 
 DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
-DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
-
-DEFINE_FREE(up_read, struct rw_semaphore *, if (_T) up_read(_T))
-DEFINE_FREE(up_write, struct rw_semaphore *, if (_T) up_write(_T))
+DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
+DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T) == 0)
 
+DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
+DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
 
 /*
  * downgrade write lock to read lock
