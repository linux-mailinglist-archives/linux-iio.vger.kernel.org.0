Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D62A8DA5
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2019 21:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbfIDRYH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Sep 2019 13:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731447AbfIDRYG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Sep 2019 13:24:06 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4216C2087E;
        Wed,  4 Sep 2019 17:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567617846;
        bh=v+R15tvDoAdWhoE88OjToZjlrGNhooxQY+IN3wLFoZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CAF5XN6y3VcD8az8sW7um+rEmyXU5bY0TJaLJoSlV3YmnBPDTRqv78ISOZCMZX/1i
         JBIlkjdfZsGb+eej8ni5gEUXK6GIMlTSEsJ6kkh3tMT+nKpY4gkYkn5LMWNMbsFR0R
         xjSqbBfYsCms0cuO44U7UShD0Xiwc0MiH/WkZDDU=
Date:   Wed, 4 Sep 2019 19:24:00 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v3 2/6] iio: imu: st_lsm6dsx: add motion events
Message-ID: <20190904172400.GC2058@localhost.localdomain>
References: <20190904091732.112281-1-sean@geanix.com>
 <20190904091732.112281-2-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <20190904091732.112281-2-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add event channels that controls the creation of motion events.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  * added handling of LSM6
>  * added CHANNEL info with events for ACC
>  * removed st_lsm6dsx_set_event_threshold function
>  * added check of event type to event channels
>=20
> Changes since v2:
>  * added devices specific registers to st_lsm6dsx_sensor_settings
>  * allow to write threshold when the events are disabled
>=20
> How do we use the existing macro's when I want to expand them with
> events for the accelerometer only?
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  43 +++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 156 +++++++++++++++++--
>  2 files changed, 190 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 5e3cd96b0059..10f3191e8695 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -12,6 +12,7 @@
>  #define ST_LSM6DSX_H
> =20
>  #include <linux/device.h>
> +#include <linux/iio/iio.h>
> =20
>  #define ST_LSM6DS3_DEV_NAME	"lsm6ds3"
>  #define ST_LSM6DS3H_DEV_NAME	"lsm6ds3h"
> @@ -54,6 +55,26 @@ enum st_lsm6dsx_hw_id {
>  					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
>  #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
> =20
> +#define ST_LSM6DSX_CHANNEL_ACC(chan_type, addr, mod, scan_idx)		\
> +{									\
> +	.type =3D chan_type,						\
> +	.address =3D addr,						\
> +	.modified =3D 1,							\
> +	.channel2 =3D mod,						\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),	\


This patch is based on a old driver version:

commit 48cceecfa7625e700ed9c57392bd17923c4832c0
iio: imu: st_lsm6dsx: make IIO_CHAN_INFO_SCALE shared by type

> +	.scan_index =3D scan_idx,						\
> +	.scan_type =3D {							\
> +		.sign =3D 's',						\
> +		.realbits =3D 16,						\
> +		.storagebits =3D 16,					\
> +		.endianness =3D IIO_LE,					\
> +	},								\
> +	.event_spec =3D &st_lsm6dsx_event,				\
> +	.num_event_specs =3D 1,						\
> +}
> +
>  #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\

I guess you can rename ST_LSM6DSX_CHANNEL in ST_LSM6DSX_CHANNEL_GYRO now

>  {									\
>  	.type =3D chan_type,						\
> @@ -162,6 +183,13 @@ struct st_lsm6dsx_shub_settings {
>  	u8 batch_en;
>  };
> =20
> +struct st_lsm6dsx_event_settings {
> +	u8 enable_addr;
> +	u8 enable_mask;
> +	u8 wakeup_addr;
> +	u8 wakeup_thres_mask;

you can rely on struct st_lsm6dsx_reg for them

> +};
> +
>  enum st_lsm6dsx_ext_sensor_id {
>  	ST_LSM6DSX_ID_MAGN,
>  };
> @@ -223,6 +251,9 @@ struct st_lsm6dsx_settings {
>  	u8 wai;
>  	u8 int1_addr;
>  	u8 int2_addr;
> +	u8 int1_func_addr;
> +	u8 int2_func_addr;
> +	u8 int_func_mask;
>  	u8 reset_addr;
>  	u16 max_fifo_size;
>  	struct {
> @@ -240,6 +271,7 @@ struct st_lsm6dsx_settings {
>  	struct st_lsm6dsx_fifo_ops fifo_ops;
>  	struct st_lsm6dsx_hw_ts_settings ts_settings;
>  	struct st_lsm6dsx_shub_settings shub_settings;
> +	struct st_lsm6dsx_event_settings event_settings;
>  };
> =20
>  enum st_lsm6dsx_sensor_id {
> @@ -320,6 +352,10 @@ struct st_lsm6dsx_hw {
>  	u8 ts_sip;
>  	u8 sip;
> =20
> +	u8 event_threshold;
> +	bool enable_event;
> +	struct st_lsm6dsx_reg irq_routing;
> +
>  	u8 *buff;
> =20
>  	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
> @@ -327,6 +363,13 @@ struct st_lsm6dsx_hw {
>  	const struct st_lsm6dsx_settings *settings;
>  };
> =20
> +static const struct iio_event_spec st_lsm6dsx_event =3D {
> +	.type =3D IIO_EV_TYPE_THRESH,
> +	.dir =3D IIO_EV_DIR_EITHER,
> +	.mask_separate =3D BIT(IIO_EV_INFO_VALUE) |
> +			 BIT(IIO_EV_INFO_ENABLE)
> +};
> +
>  static const unsigned long st_lsm6dsx_available_scan_masks[] =3D {0x7, 0=
x0};
>  extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
> =20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 8e0da5eb4283..d4d6ba934b6d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -73,9 +73,9 @@
>  #define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
> =20
>  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] =3D {
> -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> -	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
> +	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> +	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> +	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2c, IIO_MOD_Z, 2),
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
> =20
> @@ -392,6 +392,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  		.wai =3D 0x6a,
>  		.int1_addr =3D 0x0d,
>  		.int2_addr =3D 0x0e,
> +		.int1_func_addr =3D 0x5e,
> +		.int2_func_addr =3D 0x5f,
> +		.int_func_mask =3D BIT(5),
>  		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 682,
>  		.id =3D {
> @@ -508,6 +511,12 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.mask =3D GENMASK(5, 3),
>  			},
>  		},
> +		.event_settings =3D {
> +			.enable_addr =3D 0x58,
> +			.enable_mask =3D BIT(7),
> +			.wakeup_addr =3D 0x5B,
> +			.wakeup_thres_mask =3D GENMASK(5, 0),
> +		},
>  	},
>  	{
>  		.wai =3D 0x6c,
> @@ -1072,18 +1081,21 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6=
dsx_sensor *sensor,
>  	int err, delay;
>  	__le16 data;
> =20
> -	err =3D st_lsm6dsx_sensor_set_enable(sensor, true);
> -	if (err < 0)
> -		return err;
> +	if (!hw->enable_event) {
> +		err =3D st_lsm6dsx_sensor_set_enable(sensor, true);
> +		if (err < 0)
> +			return err;
> =20
> -	delay =3D 1000000 / sensor->odr;
> -	usleep_range(delay, 2 * delay);
> +		delay =3D 1000000 / sensor->odr;
> +		usleep_range(delay, 2 * delay);
> +	}
> =20
>  	err =3D st_lsm6dsx_read_locked(hw, addr, &data, sizeof(data));
>  	if (err < 0)
>  		return err;
> =20
> -	st_lsm6dsx_sensor_set_enable(sensor, false);
> +	if (!hw->enable_event)
> +		st_lsm6dsx_sensor_set_enable(sensor, false);
> =20
>  	*val =3D (s16)le16_to_cpu(data);
> =20
> @@ -1156,6 +1168,124 @@ static int st_lsm6dsx_write_raw(struct iio_dev *i=
io_dev,
>  	return err;
>  }
> =20
> +int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
> +{
> +	int err;
> +	u8 enable =3D 0;
> +
> +	if (state)
> +		enable =3D hw->settings->event_settings.enable_mask;

enable =3D state ? hw->settings->event_settings.enable_mask : 0
> +
> +	err =3D regmap_update_bits(hw->regmap,
> +				 hw->settings->event_settings.enable_addr,
> +				 hw->settings->event_settings.enable_mask,
> +				 enable);
> +	if (err < 0)
> +		return err;
> +
> +	enable =3D 0;
> +	if (state)
> +		enable =3D hw->irq_routing.mask;

this is pretty ugly, why not doing:

enable =3D state ? hw->irq_routing.mask : 0

> +
> +	/* Enable wakeup interrupt */
> +	err =3D regmap_update_bits(hw->regmap, hw->irq_routing.addr,
> +				 hw->irq_routing.mask,
> +				 enable);
> +
> +	return err;
> +}
> +
> +static int st_lsm6dsx_read_event(struct iio_dev *iio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +
> +	if (type !=3D IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	*val2 =3D 0;
> +	*val =3D hw->event_threshold;
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int st_lsm6dsx_write_event(struct iio_dev *iio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +	int err;
> +
> +	if (type !=3D IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	if (val < 0 || val > 31)
> +		return -EINVAL;
> +
> +	err =3D regmap_update_bits(hw->regmap,
> +				 hw->settings->event_settings.wakeup_addr,
> +				 hw->settings->event_settings.wakeup_thres_mask,
> +				 val);
> +	if (err)
> +		return -EINVAL;
> +
> +	hw->event_threshold =3D val;
> +
> +	return 0;
> +}
> +
> +static int st_lsm6dsx_read_event_config(struct iio_dev *iio_dev,
> +					  const struct iio_chan_spec *chan,
> +					  enum iio_event_type type,
> +					  enum iio_event_direction dir)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +
> +	if (type !=3D IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	return hw->enable_event;
> +}
> +
> +static int st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
> +					   const struct iio_chan_spec *chan,
> +					   enum iio_event_type type,
> +					   enum iio_event_direction dir,
> +					   int state)
> +{
> +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> +	int err =3D 0;
> +
> +	if (type !=3D IIO_EV_TYPE_THRESH)
> +		return -EINVAL;
> +
> +	if (state && hw->enable_event)
> +		return 0;
> +
> +	err =3D st_lsm6dsx_event_setup(hw, state);
> +	if (err < 0)
> +		return err;
> +
> +	err =3D st_lsm6dsx_sensor_set_enable(sensor, state);
> +	if (err < 0)
> +		return err;
> +
> +	hw->enable_event =3D state;
> +
> +	return 0;
> +}
> +
>  int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
>  {
>  	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> @@ -1240,6 +1370,10 @@ static const struct iio_info st_lsm6dsx_acc_info =
=3D {
>  	.attrs =3D &st_lsm6dsx_acc_attribute_group,
>  	.read_raw =3D st_lsm6dsx_read_raw,
>  	.write_raw =3D st_lsm6dsx_write_raw,
> +	.read_event_value =3D st_lsm6dsx_read_event,
> +	.write_event_value =3D st_lsm6dsx_write_event,
> +	.read_event_config =3D st_lsm6dsx_read_event_config,
> +	.write_event_config =3D st_lsm6dsx_write_event_config,
>  	.hwfifo_set_watermark =3D st_lsm6dsx_set_watermark,
>  };
> =20
> @@ -1285,9 +1419,13 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6d=
sx_hw *hw, u8 *drdy_reg)
>  	switch (drdy_pin) {
>  	case 1:
>  		*drdy_reg =3D hw->settings->int1_addr;
> +		hw->irq_routing.addr =3D hw->settings->int1_func_addr;
> +		hw->irq_routing.mask =3D hw->settings->int_func_mask;
>  		break;
>  	case 2:
>  		*drdy_reg =3D hw->settings->int2_addr;
> +		hw->irq_routing.addr =3D hw->settings->int2_func_addr;
> +		hw->irq_routing.mask =3D hw->settings->int_func_mask;
>  		break;
>  	default:
>  		dev_err(hw->dev, "unsupported data ready pin\n");
> --=20
> 2.23.0
>=20

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXW/zLQAKCRA6cBh0uS2t
rElAAQDL23T6ODb07P1XF6ad71SZDndIAPxRRVTx8pi+NhLnNQEAhtmw2l8UyV4x
jVmzgJV6QTr1GhtpnuFKbPvlKK0rCgU=
=4D5l
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
