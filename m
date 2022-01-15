Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F7C48F80B
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 17:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiAOQyi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 11:54:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49698 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiAOQyh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 11:54:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C00C60DE1
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 16:54:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2615C36AE3;
        Sat, 15 Jan 2022 16:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642265676;
        bh=cKKd+/G45mlcR00d0Sz/Sopz190ouTXN6ZkV8hfv6Cg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ss8E29PCWHl8zfsli1MA33wdkdyGu/vI8E98TOL++fXMLTPPYzMrXvNQ8036hYYL/
         5V5HWTB8j6C0MrsBAwXz7EYCIQFUiVcbtrCvqQcvWC3OXfrB3xLAOEJzFhTmswhQmT
         AMI+HTNrG4G3t1rr5GM+ZEQKOmXFrVWMSTj4NBxYkn33eYTsVObuHLFqiGLSL3QEAx
         o2CquCB5b9F1gg+UEt6Rjw1XedgbXSGYpzltgvbYgaj6PESiQlkStlf8BCgniEjfhh
         rAe8C3nVlGLlaUDED0HA9k5fXxASUpsoeWPXjXzau9uDKPadx+jG2whcWejC+GyjZO
         Z71mmzj3p0nnQ==
Date:   Sat, 15 Jan 2022 17:00:36 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 08/10] iio: core: Move iio_dev->currentmode to the
 opaque structure
Message-ID: <20220115170036.18f7ceed@jic23-huawei>
In-Reply-To: <20211216093848.7b2f10af@xps13>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-9-miquel.raynal@bootlin.com>
        <CA+U=DsoMLD1EpK7yDXaQ_HwTQgm_TeZvM_eykE6jWYgg6P3Y7w@mail.gmail.com>
        <20211216093848.7b2f10af@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Dec 2021 09:38:48 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Alexandru,
>=20
> ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 09:48:36 +0200:
>=20
> > On Wed, Dec 15, 2021 at 10:03 PM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote: =20
> > >
> > > This entry should, under no situation, be modified by device
> > > drivers. Now that we have limited its read access to device drivers
> > > really needing it, and handled modifications through another dedicated
> > > helper within the core, we can easily move this variable to the opaque
> > > structure as well as the write helper in order to prevent device driv=
er
> > > from playing with it.
> > >   =20
> >=20
> > Ah, the set-helper becomes inline.
> >=20
> > The helpers make more sense now.

Ah.  I didn't read ahead either.   I'm still unconvinced that it serves
any useful purpose though.

I'm entirely in favour of moving the variable but direct access is
fine form the core code.  We have similar cases for iio_dev_opaque->id
for example where we provide a read only accessor for drivers and directly
use it in the core.

> >=20
> > [ regardless of the naming of the helpers]
> > Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com> =20
>=20
> Great! Thanks for the entire review and feedback!
>=20
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  drivers/iio/industrialio-core.c | 15 +++------------
> > >  include/linux/iio/iio-opaque.h  | 16 ++++++++++++++++
> > >  include/linux/iio/iio.h         |  5 -----
> > >  3 files changed, 19 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrial=
io-core.c
> > > index 5c7e0c9e1f59..9836a57ff151 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -2064,21 +2064,12 @@ EXPORT_SYMBOL_GPL(iio_device_release_direct_m=
ode);
> > >   **/
> > >  int iio_get_internal_mode(struct iio_dev *indio_dev)
> > >  {
> > > -       return indio_dev->currentmode;
> > > +       struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(i=
ndio_dev);
> > > +
> > > +       return iio_dev_opaque->currentmode;
> > >  }
> > >  EXPORT_SYMBOL_GPL(iio_get_internal_mode);
> > >
> > > -/**
> > > - * iio_set_internal_mode() - helper function providing write-only ac=
cess to the
> > > - *                          internal @currentmode variable
> > > - * @indio_dev:         IIO device structure for device
> > > - **/
> > > -void iio_set_internal_mode(struct iio_dev *indio_dev, int mode)
> > > -{
> > > -       indio_dev->currentmode =3D mode;
> > > -}
> > > -EXPORT_SYMBOL_GPL(iio_set_internal_mode);
> > > -
> > >  subsys_initcall(iio_init);
> > >  module_exit(iio_exit);
> > >
> > > diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-o=
paque.h
> > > index 2be12b7b5dc5..72f35270a387 100644
> > > --- a/include/linux/iio/iio-opaque.h
> > > +++ b/include/linux/iio/iio-opaque.h
> > > @@ -7,6 +7,9 @@
> > >   * struct iio_dev_opaque - industrial I/O device opaque information
> > >   * @indio_dev:                 public industrial I/O device informat=
ion
> > >   * @id:                        used to identify device internally
> > > + * @currentmode:               operating mode currently in use, may =
be eventually
> > > + *                             checked by device drivers but should =
be considered
> > > + *                             read-only as this is a core internal =
bit
> > >   * @driver_module:             used to make it harder to undercut us=
ers
> > >   * @info_exist_lock:           lock to prevent use during removal
> > >   * @trig_readonly:             mark the current trigger immutable
> > > @@ -36,6 +39,7 @@
> > >   */
> > >  struct iio_dev_opaque {
> > >         struct iio_dev                  indio_dev;
> > > +       int                             currentmode;
> > >         int                             id;
> > >         struct module                   *driver_module;
> > >         struct mutex                    info_exist_lock;
> > > @@ -71,4 +75,16 @@ struct iio_dev_opaque {
> > >  #define to_iio_dev_opaque(_indio_dev)          \
> > >         container_of((_indio_dev), struct iio_dev_opaque, indio_dev)
> > >
> > > +/**
> > > + * iio_set_internal_mode() - helper function providing write-only ac=
cess to the
> > > + *                          internal @currentmode variable
> > > + * @indio_dev:         IIO device structure for device
> > > + **/
> > > +static inline void iio_set_internal_mode(struct iio_dev *indio_dev, =
int mode)
> > > +{
> > > +       struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(i=
ndio_dev);
> > > +
> > > +       iio_dev_opaque->currentmode =3D mode;
> > > +}
> > > +
> > >  #endif
> > > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > > index 27551d251904..d04ab89fa0c2 100644
> > > --- a/include/linux/iio/iio.h
> > > +++ b/include/linux/iio/iio.h
> > > @@ -492,9 +492,6 @@ struct iio_buffer_setup_ops {
> > >   *                     registering the IIO device and can be filed u=
p by the
> > >   *                     IIO core depending on the features advertised=
 by the
> > >   *                     driver during other steps of the registration
> > > - * @currentmode:       [INTERN] operating mode currently in use, may=
 be
> > > - *                     eventually checked by device drivers but shou=
ld be
> > > - *                     considered read-only as this is a core intern=
al bit
> > >   * @dev:               [DRIVER] device structure, should be assigned=
 a parent
> > >   *                     and owner
> > >   * @buffer:            [DRIVER] any buffer present
> > > @@ -521,7 +518,6 @@ struct iio_buffer_setup_ops {
> > >   */
> > >  struct iio_dev {
> > >         int                             modes;
> > > -       int                             currentmode;
> > >         struct device                   dev;
> > >
> > >         struct iio_buffer               *buffer;
> > > @@ -679,7 +675,6 @@ struct iio_trigger *devm_iio_trigger_alloc(struct=
 device *parent,
> > >                                            const char *fmt, ...);
> > >
> > >  int iio_get_internal_mode(struct iio_dev *indio_dev);
> > > -void iio_set_internal_mode(struct iio_dev *indio_dev, int mode);
> > >
> > >  /**
> > >   * iio_buffer_enabled() - helper function to test if the buffer is e=
nabled
> > > --
> > > 2.27.0
> > >   =20
>=20
> Thanks,
> Miqu=C3=A8l

