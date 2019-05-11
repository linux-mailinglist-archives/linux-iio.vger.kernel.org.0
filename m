Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B6F1A7CB
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 14:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfEKMbC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 08:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfEKMbC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 08:31:02 -0400
Received: from localhost.localdomain (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE2E22173B;
        Sat, 11 May 2019 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557577861;
        bh=Hcyu+viM7h7fg1KqjpVcZDwtv+M4qckuDfqZOrE+ssw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8ADU4ciJ2UmC2OwTea9caKZ9+i8WaeaywLHaNdaAeHPtVG1QVZ2LikHYGNzhYWQe
         /8fnslqOJIT4ZBMp3Z/LWl4IwGvB3Wh2jYa/z5nHdRI2sYjFJQ9Bc54/RUpILzF31U
         S1vnBxKMMuQKMt9+G7VM6IuwzYTsy+RxwGHH1gYU=
Date:   Sat, 11 May 2019 14:30:56 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        martin@geanix.com, Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis CIOCCA <denis.ciocca@st.com>
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: add iio trigger and buffer
 support
Message-ID: <20190511123054.GA14837@localhost.localdomain>
References: <20190507080225.108000-1-sean@geanix.com>
 <20190507080225.108000-2-sean@geanix.com>
 <20190511123755.2d220233@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <20190511123755.2d220233@archlinux>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue,  7 May 2019 10:02:25 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
>=20
> > This adds support for using iio triggers, this is needed because
> > our hardware guys forgot to connect the irq pins from imu device
> > to the SoC.
> >=20
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> Hi Sean
>=20
> A small question on the size of the buffer needed inline.  Otherwise looks
> good to me.

Hi Sean,

this patch does not make sense to me since running st_lsm6dsx_read_oneshot
you need to wait to power up the device (and you will power it down at the
end). I guess you will not be able to read at a given ODR (e.g. 416Hz).
Moreover you can't read from the hw fifo without the irq line since
you need to read a full pattern from it in order to maintain the alignment.
=46rom my point of view you have 2 possibility:
- poll the output registers from userspace (this is what you are actually
  doing from inside the kernel, what is the advantage of doing so?)
- fix the hw bug

Moreover if I read the patch correctly it has a NULL pointer dereference bug
since hw->iio_devs[i] can be NULL (e.g. if sensor hub is disabled)

Regards,
Lorenzo

> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 37 ++++++++++++++++++++
> >  1 file changed, 37 insertions(+)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 1ca69598678f..65ab853202de 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -40,8 +40,11 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/delay.h>
> > +#include <linux/iio/buffer.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> >  #include <linux/pm.h>
> >  #include <linux/regmap.h>
> >  #include <linux/bitfield.h>
> > @@ -945,6 +948,30 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6=
dsx_hw *hw)
> >  	return 0;
> >  }
> > =20
> > +static irqreturn_t st_lsm6dsx_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf =3D p;
> > +	struct iio_dev *indio_dev =3D pf->indio_dev;
> > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(indio_dev);
> > +	u16 buffer[4 * sizeof(s64)/sizeof(u16)];
> The size may well be correct, but that particular way of expressing it do=
esn't make
> it terribly clear.
>=20
> It seems a bit large... You need the space for the timestamp, so it needs=
 to be
> padded to a u64, but that would still require your other channels to need
> more than 2*sizeof(s64)/sizeof(u16) u16s which is 9 or more of them.
>=20
> > +	int tmp, bit;
> > +
> > +	memset(buffer, 0, sizeof(buffer));
> > +
> > +	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklen=
gth) {
> > +		st_lsm6dsx_read_oneshot(sensor,
> > +					indio_dev->channels[bit].address, &tmp);
> > +		buffer[bit] =3D tmp;
> > +	}
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
> > +					   iio_get_time_ns(indio_dev));
> > +
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> >  {
> >  	u8 drdy_int_reg;
> > @@ -1093,6 +1120,16 @@ int st_lsm6dsx_probe(struct device *dev, int irq=
, int hw_id, const char *name,
> >  		err =3D st_lsm6dsx_fifo_setup(hw);
> >  		if (err < 0)
> >  			return err;
> > +	} else {
> > +		for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
> > +			err =3D devm_iio_triggered_buffer_setup(hw->dev,
> > +					hw->iio_devs[i], NULL,
> > +					st_lsm6dsx_trigger_handler, NULL);

I guess hw->iio_devs[i] can be NULL here

> > +			if (err < 0) {
> > +				dev_err(hw->dev, "iio triggered buffer setup failed\n");
> > +				return err;
> > +			}
> > +		}
> >  	}
> > =20
> >  	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
>=20


--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXNbAewAKCRA6cBh0uS2t
rBsfAQCi5z6ccIaB7pHJw1ORErOG5sj3dNumpurE48ii4JHYQAD8DODPpGpLaIsy
EGRk0peTcWexOKPfbFreKVS+a9c2nAE=
=lqDW
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
