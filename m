Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 009FBABA70
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 16:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388994AbfIFONi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 10:13:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731142AbfIFONh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Sep 2019 10:13:37 -0400
Received: from localhost.localdomain (unknown [151.66.4.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EAD320842;
        Fri,  6 Sep 2019 14:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567779216;
        bh=p0wuS3dxO38jl+ktwE5InjhandyTmsusF62mMTKy1Ak=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Iz6RgPuojuJao+QexDY9JEFLHxR3vY4vfDSidRb29vqa8EdNeCq6SiTHjjhu0SfW+
         xNZTX0oi5L0W/y3fgyd7FbqbcznfEuCVRMBvFJe10zFlupCO+n86kTG/VnMLeb0tQl
         5P5OAoiIUku6baa6YI3baOthwrqjPLHvlHWt/6Aw=
Date:   Fri, 6 Sep 2019 16:13:30 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v4 2/6] iio: imu: st_lsm6dsx: add motion events
Message-ID: <20190906141330.GD4515@localhost.localdomain>
References: <20190906121716.66194-1-sean@geanix.com>
 <20190906121716.66194-2-sean@geanix.com>
 <20190906140238.GB4515@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Content-Disposition: inline
In-Reply-To: <20190906140238.GB4515@localhost.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sep 06, Lorenzo Bianconi wrote:
> > Add event channels that controls the creation of motion events.
> >=20
> > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > ---
> > Changes since v3:
> >  * based channel struct on newer driver
> >  * use st_lsm6dsx_reg for relevant values
> >=20
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  41 +++++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 157 +++++++++++++++++--
> >  2 files changed, 189 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 5e3cd96b0059..d04473861fba 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -12,6 +12,7 @@
> >  #define ST_LSM6DSX_H
> > =20
> >  #include <linux/device.h>
> > +#include <linux/iio/iio.h>
> > =20
> >  #define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
> >  #define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
> > @@ -54,6 +55,26 @@ enum st_lsm6dsx_hw_id {
> >  					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
> >  #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mas=
k))
> > =20
>=20
> [...]
>=20
> > @@ -508,6 +511,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.mask =3D GENMASK(5, 3),
> >  			},
> >  		},
> > +		.event_settings =3D {
> > +			.enable_reg =3D {
> > +				.addr =3D 0x58,
> > +				.mask =3D BIT(7),
> > +			},
> > +			.wakeup_reg =3D {
> > +				.addr =3D 0x5B,
> > +				.mask =3D GENMASK(5, 0),
> > +			},
> > +		},
> >  	},
> >  	{
> >  		.wai =3D 0x6c,
> > @@ -1072,18 +1085,21 @@ static int st_lsm6dsx_read_oneshot(struct st_ls=
m6dsx_sensor *sensor,
> >  	int err, delay;
> >  	__le16 data;
> > =20
> > -	err =3D st_lsm6dsx_sensor_set_enable(sensor, true);
> > -	if (err < 0)
> > -		return err;
> > +	if (!hw->enable_event) {
>=20
> I think we do not need this since it is ok if the acc is already enable r=
ight?
> Just check to not disable it
>=20
> > +		err =3D st_lsm6dsx_sensor_set_enable(sensor, true);
> > +		if (err < 0)
> > +			return err;
> > =20
> > -	delay =3D 1000000 / sensor->odr;
> > -	usleep_range(delay, 2 * delay);
> > +		delay =3D 1000000 / sensor->odr;
> > +		usleep_range(delay, 2 * delay);
> > +	}
> > =20
> >  	err =3D st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
> >  	if (err < 0)
> >  		return err;
> > =20
> > -	st_lsm6dsx_sensor_set_enable(sensor, false);
> > +	if (!hw->enable_event)
> > +		st_lsm6dsx_sensor_set_enable(sensor, false);
> > =20
> >  	*val =3D (s16)le16_to_cpu(data);
> > =20
> > @@ -1156,6 +1172,121 @@ static int st_lsm6dsx_write_raw(struct iio_dev =
*iio_dev,
> >  	return err;
> >  }
> > =20
> > +int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
> > +{
> > +	int err;
> > +	u8 enable =3D 0;

here you do something like:

	if (!hw->settings->event_settings.enable_reg.addr)
		return -ENOSUPP;

> > +
> > +	enable =3D state ? hw->settings->event_settings.enable_reg.mask : 0;
> > +
> > +	err =3D regmap_update_bits(hw->regmap,
> > +				 hw->settings->event_settings.enable_reg.addr,
> > +				 hw->settings->event_settings.enable_reg.mask,
> > +				 enable);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	enable =3D state ? hw->irq_routing.mask : 0;
> > +
> > +	/* Enable wakeup interrupt */
> > +	err =3D regmap_update_bits(hw->regmap, hw->irq_routing.addr,
> > +				 hw->irq_routing.mask,
> > +				 enable);
>=20
> return regmap_update_bits(hw->regmap, hw->irq_routing.addr,
> 			  hw->irq_routing.mask, enable);
> 			 =20
> > +
> > +	return err;
> > +}
> > +
> > +static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> > +				   const struct iio_chan_spec *chan,
> > +				   enum iio_event_type type,
> > +				   enum iio_event_direction dir,
> > +				   enum iio_event_info info,
> > +				   int *val, int *val2)
> > +{
> > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +
> > +	if (type !=3D IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	*val2 =3D 0;
> > +	*val =3D hw->event_threshold;
> > +
> > +	return IIO_VAL_INT;
> > +}
> > +
> > +static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
> > +				    const struct iio_chan_spec *chan,
> > +				    enum iio_event_type type,
> > +				    enum iio_event_direction dir,
> > +				    enum iio_event_info info,
> > +				    int val, int val2)
> > +{
> > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +	int err;
> > +
> > +	if (type !=3D IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	if (val < 0 || val > 31)
> > +		return -EINVAL;
> > +
> > +	err =3D regmap_update_bits(hw->regmap,
> > +				 hw->settings->event_settings.wakeup_reg.addr,
> > +				 hw->settings->event_settings.wakeup_reg.mask,
> > +				 val);
> > +	if (err)
> > +		return -EINVAL;
> > +
> > +	hw->event_threshold =3D val;
> > +
> > +	return 0;
> > +}
> > +
> > +static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
> > +					  const struct iio_chan_spec *chan,
> > +					  enum iio_event_type type,
> > +					  enum iio_event_direction dir)
> > +{
> > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +
> > +	if (type !=3D IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	return hw->enable_event;
> > +}
> > +
> > +static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> > +					   const struct iio_chan_spec *chan,
> > +					   enum iio_event_type type,
> > +					   enum iio_event_direction dir,
> > +					   int state)
> > +{
> > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +	int err =3D 0;
> > +
> > +	if (type !=3D IIO_EV_TYPE_THRESH)
> > +		return -EINVAL;
> > +
> > +	if (state && hw->enable_event)
> > +		return 0;
>=20
> This does not make a lot of sense to me since you just check to not enabl=
e it
> if it has been already done. Moreover you need to check if the particular
> sensor supports this event (AFAIU just one sensor does right?)
>=20
> > +
> > +	err =3D st_lsm6dsx_event_setup(hw, state);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	err =3D st_lsm6dsx_sensor_set_enable(sensor, state);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	hw->enable_event =3D state;
> > +
> > +	return 0;
> > +}
> > +
> >  int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
> >  {
> >  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > @@ -1240,6 +1371,10 @@ static const struct iio_info st_lsm6dsx_acc_info=
 =3D {
> >  	.attrs =3D &st_lsm6dsx_acc_attribute_group,
> >  	.read_raw =3D st_lsm6dsx_read_raw,
> >  	.write_raw =3D st_lsm6dsx_write_raw,
> > +	.read_event_value =3D st_lsm6dsx_read_event,
> > +	.write_event_value =3D st_lsm6dsx_write_event,
> > +	.read_event_config =3D st_lsm6dsx_read_event_config,
> > +	.write_event_config =3D st_lsm6dsx_write_event_config,
> >  	.hwfifo_set_watermark =3D st_lsm6dsx_set_watermark,
> >  };
> > =20
> > @@ -1285,9 +1420,13 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm=
6dsx_hw *hw, u8 *drdy_reg)
> >  	switch (drdy_pin) {
> >  	case 1:
> >  		*drdy_reg =3D hw->settings->int1_addr;
> > +		hw->irq_routing.addr =3D hw->settings->int1_func_addr;
> > +		hw->irq_routing.mask =3D hw->settings->int_func_mask;
> >  		break;
> >  	case 2:
> >  		*drdy_reg =3D hw->settings->int2_addr;
> > +		hw->irq_routing.addr =3D hw->settings->int2_func_addr;
> > +		hw->irq_routing.mask =3D hw->settings->int_func_mask;
> >  		break;
> >  	default:
> >  		dev_err(hw->dev, "unsupported data ready pin\n");
> > --=20
> > 2.23.0
> >=20



--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXJphwAKCRA6cBh0uS2t
rLEdAP4wYmOx/AqI1pyHWwUD7au6Ud4XBa9O0zP4ObB2DjoifwD/TlBvCL8DbQIK
d/Hhdgge8gZa/kxlWcLFA3Ydc7wB1wM=
=WCol
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
