Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 707444AB91
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 22:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfFRUVu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 16:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730232AbfFRUVu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 16:21:50 -0400
Received: from localhost.localdomain (unknown [151.66.61.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0625620873;
        Tue, 18 Jun 2019 20:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560889308;
        bh=KVhTynZp9S/J194XnHz1hmpKfsCBqp88VIcjn3DdXos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0VUAC5KtZE9h4++TuqykpXBSG8KOEmM/oItNZT3GGJWuDT/2Hgqc5PBgTGQmw16To
         qh4Va4M/zIpXb0RWMdKOjsp946RQaZ3lbONZ8NGMwoobppBrfgnPUZGFzrfqs4s6TO
         h39uEf5q5hx/qFtLgxNFqrHi8G8wPYwOceZo1vDk=
Date:   Tue, 18 Jun 2019 22:21:43 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH 2/5] iio: imu: st_lsm6dsx: add motion events
Message-ID: <20190618202142.GA930@localhost.localdomain>
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-3-sean@geanix.com>
 <20190618154928.GB20044@localhost.localdomain>
 <e41ada28-a8b5-2911-7dd0-d8833debdcee@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <e41ada28-a8b5-2911-7dd0-d8833debdcee@geanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 18, Sean Nyekjaer wrote:
>=20
>=20
> On 18/06/2019 17.49, Lorenzo Bianconi wrote:
> > > Add event channels that controls the creation of motion events.
> > >=20
> > > Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> > > ---
> > >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |   2 +
> > >   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 148 ++++++++++++++++=
++-
> > >   2 files changed, 144 insertions(+), 6 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/im=
u/st_lsm6dsx/st_lsm6dsx.h
> > > index a5e373680e9c..966cc6e91c7f 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > > @@ -155,6 +155,8 @@ struct st_lsm6dsx_hw {
> > >   	u8 enable_mask;
> > >   	u8 ts_sip;
> > >   	u8 sip;
> > > +	u8 event_threshold;
> > > +	bool enable_event;
> > >   	u8 *buff;
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index b5d3fa354de7..351c46f01662 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -78,6 +78,17 @@
> > >   #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
> > >   #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> > > +#define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
> > > +#define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
> > > +#define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK	GENMASK(6, 5)
> > > +
> > > +#define ST_LSM6DSX_DEFAULT_WAKE_THRESH		0
> > > +#define ST_LSM6DSX_REG_WAKE_UP_THS_ADDR		0x5B
> > > +#define ST_LSM6DSX_REG_WAKE_UP_THS_THRES_MASK	GENMASK(5, 0)
> >=20
> > Could you please verify this registermap is used for all supported devi=
ces?
> > (e.g. LSM6DS3 or LSM6DS3H)
>=20
> They have the same registers and the bits meaning the same.
> But I can't test on those devices...

I do think so since BIT(7) of 0x58 TAP_CFG in LSM6DS3/LSM6DS3H is used to
enable hw timestamp...moreover I think there are other differences

>=20
> >=20
> > > +
> > > +#define ST_LSM6DSX_REG_MD1_CFG_ADDR		0x5E
> > > +#define ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK	BIT(5)
> > > +
> > >   #define ST_LSM6DSX_ACC_FS_2G_GAIN		IIO_G_TO_M_S_2(61)
> > >   #define ST_LSM6DSX_ACC_FS_4G_GAIN		IIO_G_TO_M_S_2(122)
> > >   #define ST_LSM6DSX_ACC_FS_8G_GAIN		IIO_G_TO_M_S_2(244)
> > > @@ -303,6 +314,13 @@ static const struct st_lsm6dsx_settings st_lsm6d=
sx_sensor_settings[] =3D {
> > >   	},
> > >   };
> > > +static const struct iio_event_spec st_lsm6dsx_event =3D {
> > > +	.type =3D IIO_EV_TYPE_THRESH,
> > > +	.dir =3D IIO_EV_DIR_EITHER,
> > > +	.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> > > +			 BIT(IIO_EV_INFO_ENABLE)
> > > +};
> > > +
> > >   #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
> > >   {									\
> > >   	.type =3D chan_type,						\
> > > @@ -319,6 +337,8 @@ static const struct st_lsm6dsx_settings st_lsm6ds=
x_sensor_settings[] =3D {
> > >   		.storagebits =3D 16,					\
> > >   		.endianness =3D IIO_LE,					\
> > >   	},								\
> > > +	.event_spec =3D &st_lsm6dsx_event,				\
> > > +	.num_event_specs =3D 1,						\
> > >   }
> >=20
> > ST_LSM6DSX_CHANNEL is used even for sensor-hub so I do not think you ca=
n use in
> > this way
>=20
> I see, will need to come up with a solution to avoid the event channels on
> the gyro.
>=20
> >=20
> > >   static const struct iio_chan_spec st_lsm6dsx_acc_channels[] =3D {
> > > @@ -435,6 +455,20 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_=
sensor *sensor, u16 odr)
> > >   				  ST_LSM6DSX_SHIFT_VAL(val, reg->mask));
> > >   }
> > > +static int st_lsm6dsx_set_event_threshold(struct st_lsm6dsx_hw *hw, =
u8 threshold)
> > > +{
> > > +	int err =3D 0;
> > > +
> > > +	err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_WAKE_UP_THS_A=
DDR,
> > > +				 ST_LSM6DSX_REG_WAKE_UP_THS_THRES_MASK,
> > > +				 threshold);
> > > +
> > > +	if (!err)
> > > +		hw->event_threshold =3D threshold;
> > > +
> > > +	return err;
> >=20
> > I think we can just move this configuration in st_lsm6dsx_write_event()
>=20
> We could, should I then call st_lsm6dsx_write_event() from the probe
> function?

nope, just run regmap_update_bits() in st_lsm6dsx_write_event (You do not n=
eed
to call st_lsm6dsx_set_event_threshold during the probe since the default v=
alue
is already 0)

>=20
> >=20
> > > +}
> > > +
> > >   int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
> > >   {
> > >   	int err;
> > > @@ -472,18 +506,21 @@ static int st_lsm6dsx_read_oneshot(struct st_ls=
m6dsx_sensor *sensor,
> > >   	int err, delay;
> > >   	__le16 data;
> > > -	err =3D st_lsm6dsx_sensor_enable(sensor);
> > > -	if (err < 0)
> > > -		return err;
> > > +	if (!hw->enable_event) {
> > > +		err =3D st_lsm6dsx_sensor_enable(sensor);
> > > +		if (err < 0)
> > > +			return err;
> > > -	delay =3D 1000000 / sensor->odr;
> > > -	usleep_range(delay, 2 * delay);
> > > +		delay =3D 1000000 / sensor->odr;
> > > +		usleep_range(delay, 2 * delay);
> > > +	}
> > >   	err =3D regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
> > >   	if (err < 0)
> > >   		return err;
> > > -	st_lsm6dsx_sensor_disable(sensor);
> > > +	if (!hw->enable_event)
> > > +		st_lsm6dsx_sensor_disable(sensor);
> > >   	*val =3D (s16)le16_to_cpu(data);
> > > @@ -556,6 +593,75 @@ static int st_lsm6dsx_write_raw(struct iio_dev *=
iio_dev,
> > >   	return err;
> > >   }
> > > +static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> > > +				   const struct iio_chan_spec *chan,
> > > +				   enum iio_event_type type,
> > > +				   enum iio_event_direction dir,
> > > +				   enum iio_event_info info,
> > > +				   int *val, int *val2)
> > > +{
> > > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > > +
> > > +	*val2 =3D 0;
> > > +	*val =3D sensor->hw->event_threshold;
> > > +
> > > +	return IIO_VAL_INT;
> > > +}
> > > +
> > > +static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
> > > +				    const struct iio_chan_spec *chan,
> > > +				    enum iio_event_type type,
> > > +				    enum iio_event_direction dir,
> > > +				    enum iio_event_info info,
> > > +				    int val, int val2)
> > > +{
> > > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > > +
> > > +	if (!hw->enable_event)
> > > +		return -EBUSY;
> > > +
> > > +	if ((val < 0) || (val > 31))
> >=20
> > unnecessary brackets
>=20
> Will remove them :-)
>=20
> >=20
> > > +		return -EINVAL;
> > > +
> > > +	if (st_lsm6dsx_set_event_threshold(sensor->hw, val))
> > > +		return -EINVAL;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
> > > +					  const struct iio_chan_spec *chan,
> > > +					  enum iio_event_type type,
> > > +					  enum iio_event_direction dir)
> > > +{
> > > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > > +
> > > +	return hw->enable_event;
> > > +}
> > > +
> > > +static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> > > +					   const struct iio_chan_spec *chan,
> > > +					   enum iio_event_type type,
> > > +					   enum iio_event_direction dir,
> > > +					   int state)
> > > +{
> > > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > > +
> > > +	if (state && hw->enable_event)
> > > +		return 0;
> > > +
> > > +	hw->enable_event =3D state;
> > > +	if (state)
> > > +		st_lsm6dsx_sensor_enable(sensor);
> >=20
> > please correct me if I am wrong but in this way we break normal operati=
on (e.g.
> > if we are reading acc data from the FIFO). You need to check enabled_ma=
sk.
>=20
> Will change to the enabled_mask
>=20
> > Moreover we should check event type
>=20
> Do we, we only have one type?

for the moment...

>=20
> >=20
> > > +	else
> > > +		st_lsm6dsx_sensor_disable(sensor);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >   static int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsign=
ed int val)
> > >   {
> > >   	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > > @@ -632,6 +738,10 @@ static const struct iio_info st_lsm6dsx_acc_info=
 =3D {
> > >   	.attrs =3D &st_lsm6dsx_acc_attribute_group,
> > >   	.read_raw =3D st_lsm6dsx_read_raw,
> > >   	.write_raw =3D st_lsm6dsx_write_raw,
> > > +	.read_event_value =3D st_lsm6dsx_read_event,
> > > +	.write_event_value =3D st_lsm6dsx_write_event,
> > > +	.read_event_config =3D st_lsm6dsx_read_event_config,
> > > +	.write_event_config =3D st_lsm6dsx_write_event_config,
> > >   	.hwfifo_set_watermark =3D st_lsm6dsx_set_watermark,
> > >   };
> > > @@ -761,6 +871,8 @@ static int st_lsm6dsx_init_device(struct st_lsm6d=
sx_hw *hw)
> > >   	if (err < 0)
> > >   		return err;
> > > +	st_lsm6dsx_set_event_threshold(hw, ST_LSM6DSX_DEFAULT_WAKE_THRESH);
> >=20
> > we do not need this since default value is already 0
>=20
> I actually think we do need it, if we come up from a reboot we don't know
> the value stored in the register.

Nope, we perform a sw reset during probe since the default value are loaded

>=20
> >=20
> > > +
> > >   	return st_lsm6dsx_init_hw_timer(hw);
> > >   }
> > > @@ -811,6 +923,27 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(s=
truct st_lsm6dsx_hw *hw,
> > >   	return iio_dev;
> > >   }
> > > +int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw)
> > > +{
> > > +	int err;
> > > +
> > > +	/* Enable inactivity function - low power ACC, GYRO powered-down */
> > > +	err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_TAP_CFG_ADDR,
> > > +				 ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
> > > +				 ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK,
> > > +				 ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK |
> > > +				 ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK);
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	/* Enable wakeup interrupt */
> > > +	err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_MD1_CFG_ADDR,
> > > +				 ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK,
> > > +				 ST_LSM6DSX_REG_MD1_CFG_INT1_WU_MASK);
> > > +
> > > +	return err;
> > > +}
> > > +
> > >   static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> > >   {
> > >   	struct st_lsm6dsx_hw *hw =3D private;
> > > @@ -932,6 +1065,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq=
, int hw_id, const char *name,
> > >   		err =3D st_lsm6dsx_fifo_setup(hw);
> > >   		if (err < 0)
> > >   			return err;
> > > +		err =3D st_lsm6dsx_event_setup(hw);
> > > +		if (err < 0)
> > > +			return err;
> > >   	}
> > >   	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
> > > --=20
> > > 2.22.0
> > >=20

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQlH0wAKCRA6cBh0uS2t
rNy1APwILJZ0AzBGZna5FiEGXVKPvKARhL8s50ovAP0PaGYdeQD+J4fUMlhL3/I8
Z+wtOdGfUb+2Zg+cteAygWDX3DmQugM=
=TFyz
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
