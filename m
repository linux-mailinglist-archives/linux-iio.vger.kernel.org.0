Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F155B48F7F5
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiAOQp5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 11:45:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48296 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiAOQpv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 11:45:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5333CB8092B
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 16:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C45CC36AE7;
        Sat, 15 Jan 2022 16:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642265147;
        bh=b71v2yPvNrGr6ImojCLFTpt1J+c0ei59t1DBW+xuANQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Tr1aXAtOaEvzKh3PbgEBdwZ9SZqS5LqABhmU2GFLJ0UfvNFHa0RXF1OkBbiN424gV
         3S4lf6ra8SElIXcVb/ILtNSygM36w9v/+qOLMkrIkulSgkxef5ejTKy3LEb8+WuJ79
         If6OWKPYpHImJ4nE02Jnfx67ICadj6q43qcy2A/gyX6cGqI/PxwCl8MkoHfARCk7xH
         m310r4kve6VtS2Aa9rdUXK2pwlfWTw+lAwo3FNDEzhCU4KcBik0M155XdHvYL4dNYn
         0oe96XIVV7Oa9ILiSoxXM0WrV2xH+wKGbats7r+0LoxXf5Pa9ZSEX+jOUoNlH8ml6W
         CJCdL8GEOjhKQ==
Date:   Sat, 15 Jan 2022 16:51:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 06/10] iio: core: Hide read accesses to
 iio_dev->currentmode
Message-ID: <20220115165148.50206e07@jic23-huawei>
In-Reply-To: <20211216093757.114f46cf@xps13>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-7-miquel.raynal@bootlin.com>
        <CA+U=DsrD6pqpYs=D_YtkwJntcUCjUJi8qS49Dg5nLTC9yqvWZA@mail.gmail.com>
        <20211216093757.114f46cf@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Dec 2021 09:37:57 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Alexandru,
>=20
> ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 09:38:17 +0200:
>=20
> > On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote: =20
> > >
> > > In order to later move this variable within the opaque structure, let=
's
> > > create a helper for accessing it in read-only mode. This helper will =
be
> > > exposed and kept accessible for the few drivers that could need it. T=
he
> > > write access to this variable however should be fully reserved to the
> > > core so in a second step we will add another helper, not exported to =
the
> > > device drivers.   =20
> >=20
> > The naming needs a bit of discussion.
> > I would have gone for iio_dev_get_current_mode() or something like that=
. =20
>=20
> I honestly tried both, but it appeared important to me to name it
> "internal" so that people are not too tempted to use it in the first
> place. Other advises are welcome, I an definitely switch to
> iio_dev_get/set_current_mode() if it is preferred.

There are valid reasons to use it (such as the cases you have below)
so I think the iio_device_get_current_mode() naming is probably best.
Note long form of dev as more consistent with existing functions.
They could all have been iio_dev_* but given they aren't let us
keep to full device for consistency.

>=20
> > And I would probably not use this helper inside the IIO core stuff
> > (i.e. drivers/iio/industrialio-*.c files)
> > Mostly because [if now used only in IIO core] it makes the
> > "indio_dev->currentmode" assignment and access easier to trace. =20
>=20
> I think you meant in a later review that this was fine given the fact
> that a setter helper was also introduced. The goal behind using a
> helper literally everywhere was to avoid introducing an indirect access
> to the opaque structure everywhere, and do this final change almost
> transparently for the users.
>=20
> > There's also the change that accessing "indio_dev->currentmode"
> > becomes a function-symbol which has rules at link-time and may add
> > some new jmp/ret instructions.
> > But It doesn't look like this is used in any fast-paths, so it's not
> > an issue as much. =20
>=20
> I was also tempted to do that in the first place but this does not work
> anymore as soon as the variable is moved to the opaque structure (only
> the setter, which is internal to the core, may end up in the
> iio-opaque.h header). Otherwise we would end up exporting the opaque
> header from iio.h which is truly not what we want.

My reading of Alex's comment was he was only referring to the core code
changes (which already have visibility of the opaque structure).

Also, the only case where I can see this being an issue is the

iio_buffer_enabled call.  Given you are adding a function call to that
anyway, might as well just move that implementation down into a non
inline function and export the symbol.  We pay the minor cost either way.


>=20
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/iio/accel/bmc150-accel-core.c |  4 ++--
> > >  drivers/iio/adc/at91-sama5d2_adc.c    |  4 ++--
> > >  drivers/iio/industrialio-buffer.c     |  6 +++---
> > >  drivers/iio/industrialio-core.c       | 11 +++++++++++
> > >  drivers/iio/industrialio-trigger.c    |  2 +-
> > >  include/linux/iio/iio.h               |  9 ++++++---
> > >  6 files changed, 25 insertions(+), 11 deletions(-)
> > >


> > > diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industri=
alio-buffer.c
> > > index e180728914c0..f4dbab7c44fa 100644
> > > --- a/drivers/iio/industrialio-buffer.c
> > > +++ b/drivers/iio/industrialio-buffer.c
> > > @@ -1101,7 +1101,7 @@ static int iio_enable_buffers(struct iio_dev *i=
ndio_dev,
> > >                         goto err_disable_buffers;
> > >         }
> > >
> > > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> > > +       if (iio_get_internal_mode(indio_dev) =3D=3D INDIO_BUFFER_TRIG=
GERED) {

This function can already see both iio_dev and iio_dev_opaque structures so
I think I'd prefer to keep the direct access.

> > >                 ret =3D iio_trigger_attach_poll_func(indio_dev->trig,
> > >                                                    indio_dev->pollfun=
c);
> > >                 if (ret)
> > > @@ -1120,7 +1120,7 @@ static int iio_enable_buffers(struct iio_dev *i=
ndio_dev,
> > >         return 0;
> > >
> > >  err_detach_pollfunc:
> > > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> > > +       if (iio_get_internal_mode(indio_dev) =3D=3D INDIO_BUFFER_TRIG=
GERED) {
> > >                 iio_trigger_detach_poll_func(indio_dev->trig,
> > >                                              indio_dev->pollfunc);
> > >         }
> > > @@ -1162,7 +1162,7 @@ static int iio_disable_buffers(struct iio_dev *=
indio_dev)
> > >                         ret =3D ret2;

Same for this function

> > >         }
> > >
> > > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> > > +       if (iio_get_internal_mode(indio_dev) =3D=3D INDIO_BUFFER_TRIG=
GERED) {
> > >                 iio_trigger_detach_poll_func(indio_dev->trig,
> > >                                              indio_dev->pollfunc);
> > >         }
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrial=
io-core.c
> > > index 463a63d5bf56..a1d6e30d034a 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -2057,6 +2057,17 @@ void iio_device_release_direct_mode(struct iio=
_dev *indio_dev)
> > >  }
> > >  EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
> > >
> > > +/**
> > > + * iio_get_internal_mode() - helper function providing read-only acc=
ess to the
> > > + *                          opaque @currentmode variable
> > > + * @indio_dev:         IIO device structure for device
> > > + **/

I was going to complain and say this should be */ but
then checked and see we have a random mixture in this file... Hohum. one fo=
r the
list of things to tidy up when someone is really bored...

> > > +int iio_get_internal_mode(struct iio_dev *indio_dev)
> > > +{
> > > +       return indio_dev->currentmode;
> > > +}
> > > +EXPORT_SYMBOL_GPL(iio_get_internal_mode);
> > > +
> > >  subsys_initcall(iio_init);
> > >  module_exit(iio_exit);
> > >
> > > diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industr=
ialio-trigger.c
> > > index b23caa2f2aa1..71b07d6111d6 100644
> > > --- a/drivers/iio/industrialio-trigger.c
> > > +++ b/drivers/iio/industrialio-trigger.c
> > > @@ -411,7 +411,7 @@ static ssize_t iio_trigger_write_current(struct d=
evice *dev,
> > >         int ret;
> > >
> > >         mutex_lock(&indio_dev->mlock);
> > > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
Also already has visibility of the opaque structure.

> > > +       if (iio_get_internal_mode(indio_dev) =3D=3D INDIO_BUFFER_TRIG=
GERED) {
> > >                 mutex_unlock(&indio_dev->mlock);
> > >                 return -EBUSY;
> > >         }
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index 0312da2e83f8..dcab17f44552 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -677,15 +677,18 @@ struct iio_dev *devm_iio_device_alloc(struct de=
vice *parent, int sizeof_priv);
> > >  __printf(2, 3)
> > >  struct iio_trigger *devm_iio_trigger_alloc(struct device *parent,
> > >                                            const char *fmt, ...);
> > > +
> > > +int iio_get_internal_mode(struct iio_dev *indio_dev);
> > > +
> > >  /**
> > >   * iio_buffer_enabled() - helper function to test if the buffer is e=
nabled
> > >   * @indio_dev:         IIO device structure for device
> > >   **/
> > >  static inline bool iio_buffer_enabled(struct iio_dev *indio_dev)
> > >  {
> > > -       return indio_dev->currentmode
> > > -               & (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
> > > -                  INDIO_BUFFER_SOFTWARE);
> > > +       return iio_get_internal_mode(indio_dev) &
So this is the one place we have to use it given the function is inline.

However, the fact we then end up with an function that can't be inlined any=
way
suggests we should move this implementation out of the header as there is
no benefit in having it here.  Hopefully no one will mind the perf impact
of this (seems unlikely but you never know...)

> > > +               (INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_HARDWARE |
> > > +                INDIO_BUFFER_SOFTWARE);
> > >  }
> > >
> > >  /**
> > > --
> > > 2.27.0
> > >   =20
>=20
>=20
> Thanks,
> Miqu=C3=A8l

