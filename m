Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99C7B300C
	for <lists+linux-iio@lfdr.de>; Sun, 15 Sep 2019 15:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbfIONFP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Sep 2019 09:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbfIONFP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Sep 2019 09:05:15 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.2.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FB192077C;
        Sun, 15 Sep 2019 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568552713;
        bh=WjxFpPQxW5I76e1AOtsXLlflxCXspoe5qz9o7taxO90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TY2ehCDU5QLdgy+KCMTmy4Sis1/Gt4ZPS7cMlWVqT2BSDMZJb62Gj09uz4ZwgugoN
         aj1M6EimZ6S5CqysxcBqXA4wKcYSbFbOoX623iSp8Wdrw6TpKZQULUjLef8Tg/FLg/
         XR0HC9LkkaqMgHi5jRhggztosPmjH/F2VXH6ve2A=
Date:   Sun, 15 Sep 2019 15:05:08 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v8 5/5] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190915130508.GB15634@lore-desk-wlan.lan>
References: <20190913090708.1442057-1-sean@geanix.com>
 <20190913090708.1442057-6-sean@geanix.com>
 <20190915133040.0953ef1a@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <20190915133040.0953ef1a@archlinux>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 13 Sep 2019 11:07:08 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
>=20
> > Report iio motion events to iio subsystem
> >=20
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> I got to the earlier thread rather late so hadn't replied to your
> question on filtering events that haven't been enabled.

IIUC, how is possible to filter events? it seems not currently supported in
hw, right?

>=20
> Hence I think it's just that change outstanding
> + I want to give Lorenzo time for a final look.

Jonathan the series seems fine to me now, there are some leftover nitpicks =
we can
cover with some follow-up patches.

Regards,
Lorenzo

>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> > Changes since v4:
> >  * Updated bitmask as pr Jonathans comments
> >=20
> > Changes since v5:
> >  * None
> >=20
> > Changes since v6:
> >  * None
> >=20
> > Changes since v7:
> >  * None
> >=20
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 70 ++++++++++++++++++++
> >  2 files changed, 75 insertions(+)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 449c2798f7ed..7c50fac7b85c 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -186,6 +186,11 @@ struct st_lsm6dsx_shub_settings {
> >  struct st_lsm6dsx_event_settings {
> >  	struct st_lsm6dsx_reg enable_reg;
> >  	struct st_lsm6dsx_reg wakeup_reg;
> > +	u8 wakeup_src_reg;
> > +	u8 wakeup_src_status_mask;
> > +	u8 wakeup_src_z_mask;
> > +	u8 wakeup_src_y_mask;
> > +	u8 wakeup_src_x_mask;
> >  };
> > =20
> >  enum st_lsm6dsx_ext_sensor_id {
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 80a94335175f..66700c20920d 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -48,6 +48,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/delay.h>
> > +#include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/interrupt.h>
> > @@ -287,6 +288,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.addr =3D 0x5B,
> >  				.mask =3D GENMASK(5, 0),
> >  			},
> > +			.wakeup_src_reg =3D 0x1b,
> > +			.wakeup_src_status_mask =3D BIT(3),
> > +			.wakeup_src_z_mask =3D BIT(0),
> > +			.wakeup_src_y_mask =3D BIT(1),
> > +			.wakeup_src_x_mask =3D BIT(2),
> >  		},
> >  	},
> >  	{
> > @@ -412,6 +418,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.addr =3D 0x5B,
> >  				.mask =3D GENMASK(5, 0),
> >  			},
> > +			.wakeup_src_reg =3D 0x1b,
> > +			.wakeup_src_status_mask =3D BIT(3),
> > +			.wakeup_src_z_mask =3D BIT(0),
> > +			.wakeup_src_y_mask =3D BIT(1),
> > +			.wakeup_src_x_mask =3D BIT(2),
> >  		},
> >  	},
> >  	{
> > @@ -550,6 +561,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.addr =3D 0x5B,
> >  				.mask =3D GENMASK(5, 0),
> >  			},
> > +			.wakeup_src_reg =3D 0x1b,
> > +			.wakeup_src_status_mask =3D BIT(3),
> > +			.wakeup_src_z_mask =3D BIT(0),
> > +			.wakeup_src_y_mask =3D BIT(1),
> > +			.wakeup_src_x_mask =3D BIT(2),
> >  		},
> >  	},
> >  	{
> > @@ -816,6 +832,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.addr =3D 0x5B,
> >  				.mask =3D GENMASK(5, 0),
> >  			},
> > +			.wakeup_src_reg =3D 0x1b,
> > +			.wakeup_src_status_mask =3D BIT(3),
> > +			.wakeup_src_z_mask =3D BIT(0),
> > +			.wakeup_src_y_mask =3D BIT(1),
> > +			.wakeup_src_x_mask =3D BIT(2),
> >  		},
> >  	},
> >  	{
> > @@ -970,6 +991,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.addr =3D 0x5B,
> >  				.mask =3D GENMASK(5, 0),
> >  			},
> > +			.wakeup_src_reg =3D 0x1b,
> > +			.wakeup_src_status_mask =3D BIT(3),
> > +			.wakeup_src_z_mask =3D BIT(0),
> > +			.wakeup_src_y_mask =3D BIT(1),
> > +			.wakeup_src_x_mask =3D BIT(2),
> >  		}
> >  	},
> >  };
> > @@ -1715,6 +1741,38 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(s=
truct st_lsm6dsx_hw *hw,
> >  	return iio_dev;
> >  }
> > =20
> > +void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
> > +{
> > +	s64 timestamp =3D iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > +
> > +	if (data & hw->settings->event_settings.wakeup_src_z_mask)
> > +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> > +						  0,
> > +						  IIO_MOD_Z,
> > +						  IIO_EV_TYPE_THRESH,
> > +						  IIO_EV_DIR_EITHER),
> > +						  timestamp);
> > +
> > +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> > +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> > +						  0,
> > +						  IIO_MOD_Y,
> > +						  IIO_EV_TYPE_THRESH,
> > +						  IIO_EV_DIR_EITHER),
> > +						  timestamp);
> > +
> > +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> > +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> > +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> > +						  0,
> > +						  IIO_MOD_X,
> > +						  IIO_EV_TYPE_THRESH,
> > +						  IIO_EV_DIR_EITHER),
> > +						  timestamp);
> > +}
> > +
> >  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> >  {
> >  	return IRQ_WAKE_THREAD;
> > @@ -1724,6 +1782,18 @@ static irqreturn_t st_lsm6dsx_handler_thread(int=
 irq, void *private)
> >  {
> >  	struct st_lsm6dsx_hw *hw =3D private;
> >  	int count;
> > +	int data, err;
> > +
> > +	if (hw->enable_event) {
> > +		err =3D regmap_read(hw->regmap,
> > +				  hw->settings->event_settings.wakeup_src_reg,
> > +				  &data);
> > +		if (err < 0)
> > +			return IRQ_NONE;
> > +
> > +		if (data & hw->settings->event_settings.wakeup_src_status_mask)
> > +			st_lsm6dsx_report_motion_event(hw, data);
> > +	}
> > =20
> >  	mutex_lock(&hw->fifo_lock);
> >  	count =3D hw->settings->fifo_ops.read_fifo(hw);
>=20

--NMuMz9nt05w80d4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXX43AAAKCRA6cBh0uS2t
rPomAQD3jiMCXxt0w0kPLOdqzJZV1cAsesLgWDZGpFoyjVbgoQEA6RIGVFC4LFH6
zU+BQmrj4lNMjHPS2uPhzqf7vdC2YwA=
=mTlq
-----END PGP SIGNATURE-----

--NMuMz9nt05w80d4+--
