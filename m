Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF25B7DA829
	for <lists+linux-iio@lfdr.de>; Sat, 28 Oct 2023 19:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjJ1RAI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Oct 2023 13:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1RAH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Oct 2023 13:00:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A7BB0
        for <linux-iio@vger.kernel.org>; Sat, 28 Oct 2023 10:00:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76990C433C8;
        Sat, 28 Oct 2023 16:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698512404;
        bh=Kxyf/xSaOyfniDlo1vxtcnzkSFWPTxWFAZPWHS31MII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=plhxaCXBvCjVlA6W47Llz599dR+APQgi2RMh9hGMtHdr+A56rP0NjXnHoqu/HtDKT
         kmVeHUmrWRO0z2cBuQYPiydoRutQhXVou541df5AYs6f200LiyBhT5WWL5IBTHZO4B
         hMLDKmGPuMP9VWE5wCYxj6zCm0WyGQG3paya/yrmribyu7ZoxRgLoDlHfwBUjtnfTi
         WLv7fEdmSqQ644k+PSkfhpCjg71oEitEIFYlPxXko3WIqrDWLUAi6MHfVvX/DXJuDp
         3u8nDBA64Z9xMSqu5dy4z7Vo2cpvx4WGZXRFmlrZWxZ1G4J1AN5+QHKAyUJofztd61
         FdFnRUYjCeMMg==
Date:   Sat, 28 Oct 2023 17:59:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        David Lechner <dlechner@baylibre.com>,
        linux-iio@vger.kernel.org, Cosmin Tanislav <demonsingur@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Daniel Campello <campello@chromium.org>,
        gregkh@linuxfoundation.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 1/8] iio: locking: introduce __cleanup() based
 direct mode claiming infrastructure
Message-ID: <20231028175928.09047193@jic23-huawei>
In-Reply-To: <20231024152800.GA13938@noisy.programming.kicks-ass.net>
References: <20231022154710.402590-1-jic23@kernel.org>
        <20231022154710.402590-2-jic23@kernel.org>
        <CAMknhBEEPC-JArFJvpHw0YAmdA+BrAQzkxU5vNvCwxf5OdHKrw@mail.gmail.com>
        <462c181eab1c0b70c0350099b7f70aaf736aabe1.camel@gmail.com>
        <20231024151123.GB40044@noisy.programming.kicks-ass.net>
        <20231024152800.GA13938@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Oct 2023 17:28:00 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Oct 24, 2023 at 05:11:23PM +0200, Peter Zijlstra wrote:
> > On Mon, Oct 23, 2023 at 10:55:56AM +0200, Nuno S=C3=A1 wrote:
> >  =20
> > > > > +/*
> > > > > + * Auto cleanup version of iio_device_claim_direct_mode,
> > > > > + *
> > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 CLASS(iio_claim_direct, claimed_dev)(=
indio_dev);
> > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 if (IS_ERR(claimed_dev))
> > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return PTR_ERR(claimed_dev);
> > > > > + *
> > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 st =3D iio_priv(claimed_dev);
> > > > > + *=C2=A0=C2=A0=C2=A0=C2=A0 ....
> > > > > + */
> > > > > +DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 iio_device_release_direct_mode(_T),
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ({
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t iio_dev *dev;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int d=
 =3D iio_device_claim_direct_mode(_T);
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (d=
 < 0)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D ERR_PTR(d);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D _T;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 }),
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 struct iio_dev *_T);
> > > > > + =20
> >  =20
> > > I don't really have a very strong opinion on this but what I really d=
on't like
> > > much is the pattern:
> > >=20
> > > CLASS(type, ret), where the return value is an argument of the macro.=
.. It would
> > > be nice if we could just make it like:
> > >=20
> > > ret =3D guard(type)(...); //or any other variation of the guard() mac=
ro
> > > if (ret)=20
> > > 	return ret;
> > >=20
> > > the above could also be an error pointer or even have one variation o=
f each. but
> > > yeah, that likely means changing the cleanup.h file and that might be=
 out of
> > > scope for Jonathan's patch series.  =20
> >=20
> > So I have a version for trylocks that I've not managed to send out.. it
> > doesn't deal with arbitrary error codes, and as someone else down-thread
> > noted, the guard() thing is not really suited for tricks like this.
> >=20
> > Notably I have a patch that converts ptrace_attach() to have a loop lik=
e:
> >=20
> > 	scoped_guard (mutex_intr, &task->signal->cred_guard_mutex) {
> >=20
> > 		goto success;
> > 	}
> > 	return -ERESTARTNOINTR;
> >=20
> > success:
> > 	...
> > 	return 0;
> >=20
> >=20
> > And another patch that does something like:
> >=20
> > 	scoped_cond_guard (rwsem_read_intr, no_lock,
> > 			   task ? &task->signal->exec_update_lock : NULL) {
> >=20
> > 		if (0) {
> > no_lock:
> > 			if (task)
> > 				return -EINTR;
> > 		}
> > 	=09
> > 		...
> > 	}
> >  =20
>=20
> Hmm, looking at:
>=20
> +       case IIO_CHAN_INFO_RAW: { /* magic value - channel value read */
> +               CLASS(iio_claim_direct, claimed_dev)(indio_dev);
> +               if (IS_ERR(claimed_dev))
> +                       return PTR_ERR(claimed_dev);
> +               guard(mutex)(&st->lock);
> +
>                 switch (chan->type) {
>                 case IIO_VOLTAGE:
>                         if (chan->output) {
>                                 /* Set integer part to cached value */
>                                 *val =3D st->dac_val;
> +                               return IIO_VAL_INT;
>                         } else if (chan->differential) {
>                                 if (chan->channel =3D=3D 1)
>                                         *val =3D st->differential_adc_val=
[0];
>                                 else
>                                         *val =3D st->differential_adc_val=
[1];
> +                               return IIO_VAL_INT;
>                         } else {
>                                 *val =3D st->single_ended_adc_val;
> +                               return IIO_VAL_INT;
>                         }
> +
>                 case IIO_ACCEL:
>                         *val =3D st->accel_val;
> +                       return IIO_VAL_INT;
>                 default:
> +                       return -EINVAL;
>                 }
> +       }
>=20
>=20
> And your iio_device_claim_direct_mode(), that is basically a trylock,
> either it succeeds (and returns 0) or fails with -EBUSY.
>=20
> Which means you could write your thing above like:
>=20
> DEFINE_CLASS(iio_claim_direct, struct iio_dev *,
>             iio_device_release_direct_mode(_T),
>             ({
>                        struct iio_dev *dev;
>                        int d =3D iio_device_claim_direct_mode(_T);
>=20
>                        if (d < 0)
>                                dev =3D NULL;
>                        else
>                                dev =3D _T;
>                        dev;
>             }),
>             struct iio_dev *_T);
>=20
> static inline void *
> class_iio_claim_direct_lock_ptr(class_iio_claim_direct_t *_T)
> { return *_T; }
>=20
>=20
>=20
> 	case IIO_CHAN_INFO_RAW: /* magic value - channel value read */
> 		scoped_guard (iio_device_claim, indio_dev) {
> 			guard(mutex)(&st->lock);
> 			switch (chan->type) {
> 			case ..:
> 				return IIO_VAL_INT;
> 			default:
> 				return -EINVAL;
> 			}
> 		}
> 		return -EBUSY;
>=20
> and it would all just work, no?
With the scoped_guard change you mention in previous
email, this should work.

I'm not that keen on it from a readability point of view as it puts
the 'good' path inline and if we do have anything to do after the
scoped_guard() we need to engage in setting a condition variable to
indicate we'd been in the loop.

Maybe we can extend your other case though for cases where
an early exit fits or make it more general to incorporate this?

scoped_cond_guard_ret(mutex_intr, &mutex, -EINTR)?
or (naming needs work
scoped_cond_guard_call(mutex_intr, &mutex, ({ return -EINTR; }));

#define scoped_cond_guard_call(_name, _call, args...) \
+	for (CLASS(_name, scope)(args), \
+	     *done =3D NULL; !done; done =3D (void *)1) \
+		if (!__guard_ptr(_name)(&scope)) _call; \
+		else

Totally untested but hopefully conveys the idea (which is a tiny
extension of your scoped_cond_guard)

Jonathan
