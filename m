Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B597B48F7D7
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jan 2022 17:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiAOQcg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Jan 2022 11:32:36 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41210 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiAOQcg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Jan 2022 11:32:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C72B60E1F
        for <linux-iio@vger.kernel.org>; Sat, 15 Jan 2022 16:32:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A74FC36AE7;
        Sat, 15 Jan 2022 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642264355;
        bh=0n7mkktvL4gdjJgJ43XSoYJl3IdO/f0EUSM4IP/JSNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JvaqWAn/H2xkPAZcs1GEtDjQC0hPP4Hn/WabIDk4EhlvAhPUv8kjEqm/9kjh5VVig
         DNoS+hwEwr2lrq+QHvYdP2dBAnPsFQUl8Y7UMwfqcismZRu3es5iUtS1HfI2MbMDJ0
         +wHVcpkfWLHwCPBnGTh2oLkQboNjbyJLXE+z2eS+yCr4C8dDRD9TIjYGNbPxsIU/qS
         HXNfO3DPjn8H8JUA/4nHiISbgYdruV8t67Z/AlYd1pMcMdy87Z6e63AoqtC9F/1nIQ
         M0C5vvS6Z/BJWJdre5SRfkNE4B02fJ+EHZvENOyx6J3ZvEhRMfIcQszQCU8Cjsx4oI
         qs1zUxEbGcZEA==
Date:   Sat, 15 Jan 2022 16:38:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH 05/10] iio: st_sensors: Use
 iio_device_claim/release_direct_mode() when relevant
Message-ID: <20220115163834.1d9ac991@jic23-huawei>
In-Reply-To: <20211216093243.42fd0c88@xps13>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
        <20211215151344.163036-6-miquel.raynal@bootlin.com>
        <CA+U=DsoVieRnfm6K-Oeva7poGBU+GbxfnS6uoRpc9=qihq6+Rw@mail.gmail.com>
        <20211216093243.42fd0c88@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Dec 2021 09:32:43 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hello Alexandru,
>=20
> ardeleanalex@gmail.com wrote on Thu, 16 Dec 2021 09:16:34 +0200:
>=20
> > On Wed, Dec 15, 2021 at 10:04 PM Miquel Raynal
> > <miquel.raynal@bootlin.com> wrote: =20
> > >
> > > The st_sensors_core driver hardcodes the content of the
> > > iio_device_claim_direct_mode() and iio_device_release_direct_mode()
> > > helpers. Let's get rid of this handcrafted implementation and use the
> > > proper core helpers instead. Additionally, this lowers the tab level
> > > (which is always good) and prevents the use of the ->currentmode
> > > variable which is not supposed to be used like this anyway.
> > >
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > ---
> > >  .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++++++--------=
--
> > >  1 file changed, 13 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/driver=
s/iio/common/st_sensors/st_sensors_core.c
> > > index 1de395bda03e..e57e85c06f4b 100644
> > > --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> > > +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> > > @@ -549,26 +549,24 @@ int st_sensors_read_info_raw(struct iio_dev *in=
dio_dev,
> > >         int err;
> > >         struct st_sensor_data *sdata =3D iio_priv(indio_dev);
> > >
> > > -       mutex_lock(&indio_dev->mlock);
> > > -       if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> > > -               err =3D -EBUSY;
> > > +       err =3D iio_device_claim_direct_mode(indio_dev);   =20
> >=20
> > I'm afraid, for this driver, we would first need a cleanup of
> > indio_dev->mlock usage.
> > Or at least that's how I would start it.
> > i.e. remove the indio_dev->mlock and replace it with it's own
> > mutex/lock in all places (except this one).
> >=20
> > The whole story about mlock is a bit old.
> > As I was told, it was initially defined in the iio_dev object, but not
> > very strictly controlled during review [of drivers].
> > Drivers kept using it (as a convenience lock).
> > It was later defined to be an IIO framework lock. =20
>=20
> I see, thanks for the explanation!

That's accurate.  Historical mistakes and all :)
We've been unwinding this for at least 5 years now so most of the simple
cases are now gone, though it seems not all of them!

>=20
> > Now, there's a (slow) ongoing work to move mlock inside the
> > iio_dev_opaque struct, and make each driver use it's own lock, OR use
> > iio_device_{claim,release}_direct_mode() where appropriate.
> >=20
> > FWIW: this change could go in as-is. =20
>=20
> /me breathes :-)
>=20
> > But there's still the point of implementing another lock on the
> > st_sensor_data type.
> > I would try to split this work into another [parallel] series, because
> > otherwise [if fitted into this series] it would just grow and be
> > slow-to-review series.
> > But =C2=AF\_(=E3=83=84)_/=C2=AF =20
>=20
> To be honest, my first goal was to document the modes enumeration.
> Then, I realized currentmodes was also needing a bit of explanations as
> well. Jonathan added that there were misuses with this variable. I then
> tried to reduce it's overall use (when not particularly needed) and I
> ended up doing this much bigger series, because every commit prepares
> the field for the next one.
>=20
> The situation in this driver is (as you truly report):
> - the mlock is correctly used in the read_raw hook but everything is
>   hardcoded
> - the mlock is abused everywhere else
>=20
> I am very sorry but I am not willing to entirely rework this driver
> because it's not the point of my series, I don't have the hardware and
> I know this would led to yet another series of changes, which I will
> have no time to handle >.<
>=20
> My goal here is to reduce the usage count of currentmodes across all
> the device driver. This addresses the former point and I think it's
> completely valid because a series doing exactly what you request would
> definitely do this in two distinct steps as well O:-)

+CC some folks who are active on this driver (there are lots of them
as it covers some very common devices). For now I've +cc Denis but there
are others you should add to a v2.

Hmm. Question is whether doing this change in isolation from the more
general cleanup of mlock is a good move. It won't be obvious what
can race if someone comes along later trying to remove mlock usage...

One perhaps non obvious thing is at that a driver should not rely in
any way on the implementation of iio_device_claim/release_direct_mode().
It's only documented characteristics is it will fail to claim if we
are in buffered mode and that it prevents races with a transition to
buffered modes.

This particular read_raw path doesn't seem to use any shared
state (buffer is allocated in st_sensors_read_axis_data) but it
is turning the power on and off which is potentially fairly nasty
(and interestingly does rely on shared state - see later).

So it should use a local lock as well as mlock to prevent multiple
calls of st_sensors_read_info_raw racing with each other.
(claim_direct doesn't guarantee that because it's an implementation
detail that a driver should rely on - right now as it's open coded
we can know it is safe).

I took a quick look at what other mlock usage we do have...

The other cases in st_sensors_core.c should at most have been
iio_device_claim_direct_mode() etc.  Right now they'll block indefinitely
on a read of relevant _avail which is not good!

However, not clear why they even need to do that as they are simply
listing sdata->sensor_settings->odr.odr_avl etc which is const
data for a give device type.  So I'm fairly sure we could just drop those
two cases.

The mlock use in st_accel_core.c is again dubious as it will block
indefinitely if the buffer is enabled...=20

So why is it here?  Probably
1) Avoid changing sampling frequency whilst buffer is running which
should be an iio_device_claim_direct_mode()
2) There is some state that might potentially want keeping in sync - which
would benefit from a local lock.  In particular sdata->odr which is
a local cache of the output data rate is used in st_sensors_set_enable()
which it could race with (if we can't rely on claim_direct())...

This last one is why I don't think we can do this function in isolation.

Sorry :(

On the plus side it's not that hard to fix as:
1) Drop the protection on _avail functions - it seems to be pointless.
2) Add a new lock that actually only ensures device setting for ODR is
   atomic wrt to the cached value.

Plenty of folks to test.   I'm happy to roll the patch if you want me
to, but as it's a precursor to your series perhaps better that you do.

I'm sure one of the people who have made changes to this driver recently
will help with testing.

Jonathan

>=20
> Thanks,
> Miqu=C3=A8l
>=20

