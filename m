Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8570C2F0DE2
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jan 2021 09:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbhAKIWV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 03:22:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:36788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbhAKIWV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 11 Jan 2021 03:22:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F98522A85;
        Mon, 11 Jan 2021 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610353299;
        bh=b2gKs+fbvA77wwsnwkBjJyUyrntO++bOnVuV57RnkBU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7F0TPJrUq0uMZR6CjKjsiUEiSWvf9DuuyF1OTal0aZAdYq638sXwMABR4BYgrS6O
         488OLIGgPd2OouANibfkuxetIMQ/eiCTXsU+UqI3fnh2zMHirm9q3Kp5BY2NpviHLN
         O8GQQFOBdJ6i+bEDl96CPiLaIklVjUolRqKA3OoPv6r66jFOlX+zUtKBKjhbCuZiVQ
         sYCRKWudwHZCyFWRPd0lWNcKifSziQ9fwRckaqHAkfPfd2nYqIICwdd38TZlPUL89F
         VQk0gGys+QKVrfuGR4gjMgc6t1hClpQQ93ZPqw2N5QXKix9KMx8qL5HznNdyM86CO6
         Py4NnAEeZjkHw==
Date:   Mon, 11 Jan 2021 09:21:34 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH v3] iio: common: st_sensors: fix possible infinite loop
 in st_sensors_irq_thread
Message-ID: <20210111082134.GA2258@lore-desk>
References: <c9ec69ed349e7200c779fd7a5bf04c1aaa2817aa.1607438132.git.lorenzo@kernel.org>
 <20201213150447.119eec7c@archlinux>
 <CAJ0CqmXmFvEEnt_fQa+H9Lrsu9d-kj+zTWgVXakBF8z2KqEQYA@mail.gmail.com>
 <CAJ0CqmVJ9qMpLq-ZSVBFzQXSj3MNqeP5b4MjMpZh0b2H7mjXzg@mail.gmail.com>
 <20201230120850.6dd32cfc@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <20201230120850.6dd32cfc@archlinux>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 22 Dec 2020 11:53:57 +0100
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>=20
> > > =20

[...]

> It's a very minor gamble, so I've applied it to the fixes-togreg branch of
> iio.git.  Fingers crossed no one hits the corner case and has somehow been
> getting away with it.
>=20
> Thanks,

Hi Jonathan,

I am not able to find this commit in your tree. Am I missing something?

Regards,
Lorenzo

>=20
> Jonathan
>=20
> >=20
> > > Regards,
> > > Lorenzo
> > > =20
> > > >
> > > > It's possible we would be better falling back to interrupt free sup=
port
> > > > in that case rather than failing to probe at all.
> > > > I think that would be best done by moving the check out to the
> > > > various per type drivers so we fail in the same fashion as no irq
> > > > provided + a warning. =20
> > >
> > > =20
> > > >
> > > > thanks,
> > > >
> > > > Jonathan
> > > >
> > > > =20
> > > > > ---
> > > > > Changes since v2:
> > > > > - return -EOPNOTSUPP if the drv requests edge IRQ and the sensor =
does not support
> > > > >   status register
> > > > >
> > > > > Changes since v1:
> > > > > - return true if the sensor does not have stat_drdy register
> > > > > ---
> > > > >  .../common/st_sensors/st_sensors_trigger.c    | 31 ++++++++++---=
------
> > > > >  1 file changed, 17 insertions(+), 14 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b=
/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > > > index 0507283bd4c1..2dbd2646e44e 100644
> > > > > --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > > > +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > > > @@ -23,35 +23,31 @@
> > > > >   * @sdata: Sensor data.
> > > > >   *
> > > > >   * returns:
> > > > > - * 0 - no new samples available
> > > > > - * 1 - new samples available
> > > > > - * negative - error or unknown
> > > > > + * false - no new samples available or read error
> > > > > + * true - new samples available
> > > > >   */
> > > > > -static int st_sensors_new_samples_available(struct iio_dev *indi=
o_dev,
> > > > > -                                         struct st_sensor_data *=
sdata)
> > > > > +static bool st_sensors_new_samples_available(struct iio_dev *ind=
io_dev,
> > > > > +                                          struct st_sensor_data =
*sdata)
> > > > >  {
> > > > >       int ret, status;
> > > > >
> > > > >       /* How would I know if I can't check it? */
> > > > >       if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> > > > > -             return -EINVAL;
> > > > > +             return true;
> > > > >
> > > > >       /* No scan mask, no interrupt */
> > > > >       if (!indio_dev->active_scan_mask)
> > > > > -             return 0;
> > > > > +             return false;
> > > > >
> > > > >       ret =3D regmap_read(sdata->regmap,
> > > > >                         sdata->sensor_settings->drdy_irq.stat_drd=
y.addr,
> > > > >                         &status);
> > > > >       if (ret < 0) {
> > > > >               dev_err(sdata->dev, "error checking samples availab=
le\n");
> > > > > -             return ret;
> > > > > +             return false;
> > > > >       }
> > > > >
> > > > > -     if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mas=
k)
> > > > > -             return 1;
> > > > > -
> > > > > -     return 0;
> > > > > +     return !!(status & sdata->sensor_settings->drdy_irq.stat_dr=
dy.mask); =20
> > > >
> > > > No need for the !! as you can rely on type conversion to a boolean.
> > > > =20
> > > > >  }
> > > > >
> > > > >  /**
> > > > > @@ -180,9 +176,15 @@ int st_sensors_allocate_trigger(struct iio_d=
ev *indio_dev,
> > > > >
> > > > >       /* Tell the interrupt handler that we're dealing with edges=
 */
> > > > >       if (irq_trig =3D=3D IRQF_TRIGGER_FALLING ||
> > > > > -         irq_trig =3D=3D IRQF_TRIGGER_RISING)
> > > > > +         irq_trig =3D=3D IRQF_TRIGGER_RISING) {
> > > > > +             if (!sdata->sensor_settings->drdy_irq.stat_drdy.add=
r) {
> > > > > +                     dev_err(&indio_dev->dev,
> > > > > +                             "edge IRQ not supported w/o stat re=
gister.\n");
> > > > > +                     err =3D -EOPNOTSUPP;
> > > > > +                     goto iio_trigger_free;
> > > > > +             }
> > > > >               sdata->edge_irq =3D true;
> > > > > -     else
> > > > > +     } else {
> > > > >               /*
> > > > >                * If we're not using edges (i.e. level interrupts)=
 we
> > > > >                * just mask off the IRQ, handle one interrupt, then
> > > > > @@ -190,6 +192,7 @@ int st_sensors_allocate_trigger(struct iio_de=
v *indio_dev,
> > > > >                * interrupt handler top half again and start over.
> > > > >                */
> > > > >               irq_trig |=3D IRQF_ONESHOT;
> > > > > +     }
> > > > >
> > > > >       /*
> > > > >        * If the interrupt pin is Open Drain, by definition this =
=20
> > > > =20
> >=20
>=20

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX/wKjAAKCRA6cBh0uS2t
rFMRAP9OvDQHyDj3OvGEyCOcxw/bP8uSIfpIZn7CIpptASUnJAEAq/9Tuu6Tb6Zy
daYB8pu/dEj8GHCU/hzQr+dhglP1mwo=
=K65/
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
