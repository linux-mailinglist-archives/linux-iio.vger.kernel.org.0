Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F645B304B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 15:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfIONlT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 09:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfIONlT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 09:41:19 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FBAD20650;
        Sun, 15 Sep 2019 13:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568554877;
        bh=g9VM+jYrLqadIqIgrV4oLjFxa6CX+K0umDwo5C57hsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bi5zEs5TNmXlcdgAUOI9OjXqXX5aSmr3vLYVDZaUX20HOGoIHu/TvZKSlvrU4Z9ln
         j6rJiZGNInRahcHRl5zPLoHgZu+e5HulJBmXlroHAG9VTScm0kfc16u67dxn+t1DH9
         v6tTHjK9P4bgwcx9paUE5tQGJ4yeJavzf6bioNH0=
Date:   Sun, 15 Sep 2019 15:41:11 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v8 5/5] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190915134111.GD15634@lore-desk-wlan.lan>
References: <20190913090708.1442057-1-sean@geanix.com>
 <20190913090708.1442057-6-sean@geanix.com>
 <20190915133040.0953ef1a@archlinux>
 <20190915130508.GB15634@lore-desk-wlan.lan>
 <20190915141808.6ca04f0f@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <20190915141808.6ca04f0f@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sun, 15 Sep 2019 15:05:08 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > > On Fri, 13 Sep 2019 11:07:08 +0200
> > > Sean Nyekjaer <sean@geanix.com> wrote:
> > >  =20
> > > > Report iio motion events to iio subsystem
> > > >=20
> > > > Signed-off-by: Sean Nyekjaer <sean@geanix.com> =20
> > > I got to the earlier thread rather late so hadn't replied to your
> > > question on filtering events that haven't been enabled. =20
> >=20
> > IIUC, how is possible to filter events? it seems not currently supporte=
d in
> > hw, right?
> Filter them in software on their way to userspace.  So you'll get an inte=
rrupt
> either way, but no need to tell userspace about event's it's not interest=
ed
> in.

ack

> >=20
> > >=20
> > > Hence I think it's just that change outstanding
> > > + I want to give Lorenzo time for a final look. =20
> >=20
> > Jonathan the series seems fine to me now, there are some leftover nitpi=
cks we can
> > cover with some follow-up patches.
>=20
> Acks/Reviewed-bys?  Let's do this formally!

I will look at v9 and then I will add my acked-by.

Regards,
Lorenzo

>=20
> Jonathan
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan
> > >  =20
> > > > ---
> > > > Changes since v4:
> > > >  * Updated bitmask as pr Jonathans comments
> > > >=20
> > > > Changes since v5:
> > > >  * None
> > > >=20
> > > > Changes since v6:
> > > >  * None
> > > >=20
> > > > Changes since v7:
> > > >  * None
> > > >=20
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++=
++++
> > > >  2 files changed, 75 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/=
imu/st_lsm6dsx/st_lsm6dsx.h
> > > > index 449c2798f7ed..7c50fac7b85c 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > > @@ -186,6 +186,11 @@ struct st_lsm6dsx_shub_settings {
> > > >  struct st_lsm6dsx_event_settings {
> > > >  	struct st_lsm6dsx_reg enable_reg;
> > > >  	struct st_lsm6dsx_reg wakeup_reg;
> > > > +	u8 wakeup_src_reg;
> > > > +	u8 wakeup_src_status_mask;
> > > > +	u8 wakeup_src_z_mask;
> > > > +	u8 wakeup_src_y_mask;
> > > > +	u8 wakeup_src_x_mask;
> > > >  };
> > > > =20
> > > >  enum st_lsm6dsx_ext_sensor_id {
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 80a94335175f..66700c20920d 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -48,6 +48,7 @@
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/delay.h>
> > > > +#include <linux/iio/events.h>
> > > >  #include <linux/iio/iio.h>
> > > >  #include <linux/iio/sysfs.h>
> > > >  #include <linux/interrupt.h>
> > > > @@ -287,6 +288,11 @@ static const struct st_lsm6dsx_settings st_lsm=
6dsx_sensor_settings[] =3D {
> > > >  				.addr =3D 0x5B,
> > > >  				.mask =3D GENMASK(5, 0),
> > > >  			},
> > > > +			.wakeup_src_reg =3D 0x1b,
> > > > +			.wakeup_src_status_mask =3D BIT(3),
> > > > +			.wakeup_src_z_mask =3D BIT(0),
> > > > +			.wakeup_src_y_mask =3D BIT(1),
> > > > +			.wakeup_src_x_mask =3D BIT(2),
> > > >  		},
> > > >  	},
> > > >  	{
> > > > @@ -412,6 +418,11 @@ static const struct st_lsm6dsx_settings st_lsm=
6dsx_sensor_settings[] =3D {
> > > >  				.addr =3D 0x5B,
> > > >  				.mask =3D GENMASK(5, 0),
> > > >  			},
> > > > +			.wakeup_src_reg =3D 0x1b,
> > > > +			.wakeup_src_status_mask =3D BIT(3),
> > > > +			.wakeup_src_z_mask =3D BIT(0),
> > > > +			.wakeup_src_y_mask =3D BIT(1),
> > > > +			.wakeup_src_x_mask =3D BIT(2),
> > > >  		},
> > > >  	},
> > > >  	{
> > > > @@ -550,6 +561,11 @@ static const struct st_lsm6dsx_settings st_lsm=
6dsx_sensor_settings[] =3D {
> > > >  				.addr =3D 0x5B,
> > > >  				.mask =3D GENMASK(5, 0),
> > > >  			},
> > > > +			.wakeup_src_reg =3D 0x1b,
> > > > +			.wakeup_src_status_mask =3D BIT(3),
> > > > +			.wakeup_src_z_mask =3D BIT(0),
> > > > +			.wakeup_src_y_mask =3D BIT(1),
> > > > +			.wakeup_src_x_mask =3D BIT(2),
> > > >  		},
> > > >  	},
> > > >  	{
> > > > @@ -816,6 +832,11 @@ static const struct st_lsm6dsx_settings st_lsm=
6dsx_sensor_settings[] =3D {
> > > >  				.addr =3D 0x5B,
> > > >  				.mask =3D GENMASK(5, 0),
> > > >  			},
> > > > +			.wakeup_src_reg =3D 0x1b,
> > > > +			.wakeup_src_status_mask =3D BIT(3),
> > > > +			.wakeup_src_z_mask =3D BIT(0),
> > > > +			.wakeup_src_y_mask =3D BIT(1),
> > > > +			.wakeup_src_x_mask =3D BIT(2),
> > > >  		},
> > > >  	},
> > > >  	{
> > > > @@ -970,6 +991,11 @@ static const struct st_lsm6dsx_settings st_lsm=
6dsx_sensor_settings[] =3D {
> > > >  				.addr =3D 0x5B,
> > > >  				.mask =3D GENMASK(5, 0),
> > > >  			},
> > > > +			.wakeup_src_reg =3D 0x1b,
> > > > +			.wakeup_src_status_mask =3D BIT(3),
> > > > +			.wakeup_src_z_mask =3D BIT(0),
> > > > +			.wakeup_src_y_mask =3D BIT(1),
> > > > +			.wakeup_src_x_mask =3D BIT(2),
> > > >  		}
> > > >  	},
> > > >  };
> > > > @@ -1715,6 +1741,38 @@ static struct iio_dev *st_lsm6dsx_alloc_iiod=
ev(struct st_lsm6dsx_hw *hw,
> > > >  	return iio_dev;
> > > >  }
> > > > =20
> > > > +void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int =
data)
> > > > +{
> > > > +	s64 timestamp =3D iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]=
);
> > > > +
> > > > +	if (data & hw->settings->event_settings.wakeup_src_z_mask)
> > > > +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > > > +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> > > > +						  0,
> > > > +						  IIO_MOD_Z,
> > > > +						  IIO_EV_TYPE_THRESH,
> > > > +						  IIO_EV_DIR_EITHER),
> > > > +						  timestamp);
> > > > +
> > > > +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> > > > +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > > > +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> > > > +						  0,
> > > > +						  IIO_MOD_Y,
> > > > +						  IIO_EV_TYPE_THRESH,
> > > > +						  IIO_EV_DIR_EITHER),
> > > > +						  timestamp);
> > > > +
> > > > +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> > > > +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > > > +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> > > > +						  0,
> > > > +						  IIO_MOD_X,
> > > > +						  IIO_EV_TYPE_THRESH,
> > > > +						  IIO_EV_DIR_EITHER),
> > > > +						  timestamp);
> > > > +}
> > > > +
> > > >  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> > > >  {
> > > >  	return IRQ_WAKE_THREAD;
> > > > @@ -1724,6 +1782,18 @@ static irqreturn_t st_lsm6dsx_handler_thread=
(int irq, void *private)
> > > >  {
> > > >  	struct st_lsm6dsx_hw *hw =3D private;
> > > >  	int count;
> > > > +	int data, err;
> > > > +
> > > > +	if (hw->enable_event) {
> > > > +		err =3D regmap_read(hw->regmap,
> > > > +				  hw->settings->event_settings.wakeup_src_reg,
> > > > +				  &data);
> > > > +		if (err < 0)
> > > > +			return IRQ_NONE;
> > > > +
> > > > +		if (data & hw->settings->event_settings.wakeup_src_status_mask)
> > > > +			st_lsm6dsx_report_motion_event(hw, data);
> > > > +	}
> > > > =20
> > > >  	mutex_lock(&hw->fifo_lock);
> > > >  	count =3D hw->settings->fifo_ops.read_fifo(hw); =20
> > >  =20
>=20

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXX4/dQAKCRA6cBh0uS2t
rEq9AP4+GsfBqz6NCDCift1IgnLaWmyVD8Lh3jtyJTgCTe58cwD/QxD9xFTKc8AZ
BouKRE0WVOwEjnQlt/xiLflf3C6ZGw4=
=ebh1
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
