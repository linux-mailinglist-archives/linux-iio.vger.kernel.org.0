Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170C7AD69C
	for <lists+linux-iio@lfdr.de>; Mon,  9 Sep 2019 12:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730231AbfIIKVY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Sep 2019 06:21:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730195AbfIIKVY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 06:21:24 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DE92089F;
        Mon,  9 Sep 2019 10:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568024483;
        bh=syio9yMjNJF3NTQtvUQzQHKHKV0xWo9bg47DiSgXd3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LOmTejr5AFUCGwsC2WeD6OARmBjQ5hvle2QJXvS4NUGl1m5jR7Rq9zTWNHubw3k/I
         4dSC5R6kste/WVOAfOxA6jJYktUDPtQ1/9xSBo/ehp1dXNfj7n3NcnFaOlWPEhiO73
         ZZqsFqEnHeSIDZ91XSNoaCVQFBFRlOuU63Dv915A=
Date:   Mon, 9 Sep 2019 12:21:17 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v5 2/6] iio: imu: st_lsm6dsx: add motion events
Message-ID: <20190909102117.GA2990@localhost.localdomain>
References: <20190909094506.51792-1-sean@geanix.com>
 <20190909094506.51792-2-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <20190909094506.51792-2-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add event channels that controls the creation of motion events.
> Tested on ISM330DLC
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v4:
>  * Added check for event support
>  * Added registers for more devices that support this event
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  41 ++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 214 ++++++++++++++++++-
>  2 files changed, 251 insertions(+), 4 deletions(-)
>=20

still someting wrong here:

drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:955:5: error: =E2=80=98struct =
st_lsm6dsx_event_settings=E2=80=99 has no member named =E2=80=98wakeup_src_=
y_mask=E2=80=99
  955 |    .wakeup_src_y_mask =3D BIT(1),
      |     ^~~~~~~~~~~~~~~~~
In file included from ./include/linux/bitops.h:5,
                 from ./include/linux/kernel.h:12,
                 from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:48:
=2E/include/linux/bits.h:8:19: warning: excess elements in struct initializ=
er
    8 | #define BIT(nr)   (UL(1) << (nr))
      |                   ^
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:955:25: note: in expansion of =
macro =E2=80=98BIT=E2=80=99
  955 |    .wakeup_src_y_mask =3D BIT(1),
      |                         ^~~
=2E/include/linux/bits.h:8:19: note: (near initialization for =E2=80=98st_l=
sm6dsx_sensor_settings[6].event_settings=E2=80=99)
    8 | #define BIT(nr)   (UL(1) << (nr))
      |                   ^
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:955:25: note: in expansion of =
macro =E2=80=98BIT=E2=80=99
  955 |    .wakeup_src_y_mask =3D BIT(1),
      |                         ^~~
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:956:5: error: =E2=80=98struct =
st_lsm6dsx_event_settings=E2=80=99 has no member named =E2=80=98wakeup_src_=
x_mask=E2=80=99
  956 |    .wakeup_src_x_mask =3D BIT(2),
      |     ^~~~~~~~~~~~~~~~~
In file included from ./include/linux/bitops.h:5,
                 from ./include/linux/kernel.h:12,
                 from drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:48:


You defined wakeup_src_{w,y,z}_mask in patch 5/6 and you are using them her=
e. Please do not do so since you are breaking 'git bisect'

Regards,
Lorenzo


> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 5e3cd96b0059..d04473861fba 100644
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
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
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
>  {									\
>  	.type =3D chan_type,						\
> @@ -162,6 +183,11 @@ struct st_lsm6dsx_shub_settings {
>  	u8 batch_en;
>  };
> =20
> +struct st_lsm6dsx_event_settings {
> +	struct st_lsm6dsx_reg enable_reg;
> +	struct st_lsm6dsx_reg wakeup_reg;
> +};
> +
>  enum st_lsm6dsx_ext_sensor_id {
>  	ST_LSM6DSX_ID_MAGN,
>  };
> @@ -223,6 +249,9 @@ struct st_lsm6dsx_settings {
>  	u8 wai;
>  	u8 int1_addr;
>  	u8 int2_addr;
> +	u8 int1_func_addr;
> +	u8 int2_func_addr;
> +	u8 int_func_mask;
>  	u8 reset_addr;
>  	u16 max_fifo_size;
>  	struct {
> @@ -240,6 +269,7 @@ struct st_lsm6dsx_settings {
>  	struct st_lsm6dsx_fifo_ops fifo_ops;
>  	struct st_lsm6dsx_hw_ts_settings ts_settings;
>  	struct st_lsm6dsx_shub_settings shub_settings;
> +	struct st_lsm6dsx_event_settings event_settings;
>  };
> =20
>  enum st_lsm6dsx_sensor_id {
> @@ -320,6 +350,10 @@ struct st_lsm6dsx_hw {
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
> @@ -327,6 +361,13 @@ struct st_lsm6dsx_hw {
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
> index d0bcbbfb6297..fb83076d8f17 100644
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
> @@ -168,6 +168,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  		.wai =3D 0x69,
>  		.int1_addr =3D 0x0d,
>  		.int2_addr =3D 0x0e,
> +		.int1_func_addr =3D 0x5e,
> +		.int2_func_addr =3D 0x5f,
> +		.int_func_mask =3D BIT(5),
>  		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 1365,
>  		.id =3D {
> @@ -275,11 +278,25 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  				.mask =3D GENMASK(5, 3),
>  			},
>  		},
> +		.event_settings =3D {
> +			.wakeup_reg =3D {
> +				.addr =3D 0x5B,
> +				.mask =3D GENMASK(5, 0),
> +			},
> +			.wakeup_src_reg =3D 0x1b,
> +			.wakeup_src_status_mask =3D BIT(3),
> +			.wakeup_src_z_mask =3D BIT(0),
> +			.wakeup_src_y_mask =3D BIT(1),
> +			.wakeup_src_x_mask =3D BIT(2),
> +		},
>  	},
>  	{
>  		.wai =3D 0x69,
>  		.int1_addr =3D 0x0d,
>  		.int2_addr =3D 0x0e,
> +		.int1_func_addr =3D 0x5e,
> +		.int2_func_addr =3D 0x5f,
> +		.int_func_mask =3D BIT(5),
>  		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 682,
>  		.id =3D {
> @@ -387,11 +404,25 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  				.mask =3D GENMASK(5, 3),
>  			},
>  		},
> +		.event_settings =3D {
> +			.wakeup_reg =3D {
> +				.addr =3D 0x5B,
> +				.mask =3D GENMASK(5, 0),
> +			},
> +			.wakeup_src_reg =3D 0x1b,
> +			.wakeup_src_status_mask =3D BIT(3),
> +			.wakeup_src_z_mask =3D BIT(0),
> +			.wakeup_src_y_mask =3D BIT(1),
> +			.wakeup_src_x_mask =3D BIT(2),
> +		},
>  	},
>  	{
>  		.wai =3D 0x6a,
>  		.int1_addr =3D 0x0d,
>  		.int2_addr =3D 0x0e,
> +		.int1_func_addr =3D 0x5e,
> +		.int2_func_addr =3D 0x5f,
> +		.int_func_mask =3D BIT(5),
>  		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 682,
>  		.id =3D {
> @@ -508,6 +539,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.mask =3D GENMASK(5, 3),
>  			},
>  		},
> +		.event_settings =3D {
> +			.enable_reg =3D {
> +				.addr =3D 0x58,
> +				.mask =3D BIT(7),
> +			},
> +			.wakeup_reg =3D {
> +				.addr =3D 0x5B,
> +				.mask =3D GENMASK(5, 0),
> +			},
> +		},
>  	},
>  	{
>  		.wai =3D 0x6c,
> @@ -646,6 +687,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  		.wai =3D 0x6b,
>  		.int1_addr =3D 0x0d,
>  		.int2_addr =3D 0x0e,
> +		.int1_func_addr =3D 0x5e,
> +		.int2_func_addr =3D 0x5f,
> +		.int_func_mask =3D BIT(5),
>  		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 512,
>  		.id =3D {
> @@ -745,11 +789,29 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_=
sensor_settings[] =3D {
>  				.mask =3D GENMASK(7, 6),
>  			},
>  		},
> +		.event_settings =3D {
> +			.enable_reg =3D {
> +				.addr =3D 0x58,
> +				.mask =3D BIT(7),
> +			},
> +			.wakeup_reg =3D {
> +				.addr =3D 0x5B,
> +				.mask =3D GENMASK(5, 0),
> +			},
> +			.wakeup_src_reg =3D 0x1b,
> +			.wakeup_src_status_mask =3D BIT(3),
> +			.wakeup_src_z_mask =3D BIT(0),
> +			.wakeup_src_y_mask =3D BIT(1),
> +			.wakeup_src_x_mask =3D BIT(2),
> +		},
>  	},
>  	{
>  		.wai =3D 0x6b,
>  		.int1_addr =3D 0x0d,
>  		.int2_addr =3D 0x0e,
> +		.int1_func_addr =3D 0x5e,
> +		.int2_func_addr =3D 0x5f,
> +		.int_func_mask =3D BIT(5),
>  		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 512,
>  		.id =3D {
> @@ -877,6 +939,21 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  			.slv0_addr =3D 0x15,
>  			.dw_slv0_addr =3D 0x21,
>  			.batch_en =3D BIT(3),
> +		},
> +		.event_settings =3D {
> +			.enable_reg =3D {
> +				.addr =3D 0x58,
> +				.mask =3D BIT(7),
> +			},
> +			.wakeup_reg =3D {
> +				.addr =3D 0x5B,
> +				.mask =3D GENMASK(5, 0),
> +			},
> +			.wakeup_src_reg =3D 0x1b,
> +			.wakeup_src_status_mask =3D BIT(3),
> +			.wakeup_src_z_mask =3D BIT(0),
> +			.wakeup_src_y_mask =3D BIT(1),
> +			.wakeup_src_x_mask =3D BIT(2),
>  		}
>  	},
>  };
> @@ -1083,7 +1160,8 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6ds=
x_sensor *sensor,
>  	if (err < 0)
>  		return err;
> =20
> -	st_lsm6dsx_sensor_set_enable(sensor, false);
> +	if (!hw->enable_event)
> +		st_lsm6dsx_sensor_set_enable(sensor, false);
> =20
>  	*val =3D (s16)le16_to_cpu(data);
> =20
> @@ -1156,6 +1234,126 @@ static int st_lsm6dsx_write_raw(struct iio_dev *i=
io_dev,
>  	return err;
>  }
> =20
> +int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw, int state)
> +{
> +	int err;
> +	u8 enable =3D 0;

useless initialization

> +
> +	if (!hw->settings->int1_func_addr)
> +		return -ENOTSUPP;
> +
> +	enable =3D state ? hw->settings->event_settings.enable_reg.mask : 0;
> +
> +	err =3D regmap_update_bits(hw->regmap,
> +				 hw->settings->event_settings.enable_reg.addr,
> +				 hw->settings->event_settings.enable_reg.mask,
> +				 enable);
> +	if (err < 0)
> +		return err;
> +
> +	enable =3D state ? hw->irq_routing.mask : 0;
> +
> +	/* Enable wakeup interrupt */
> +	return regmap_update_bits(hw->regmap, hw->irq_routing.addr,
> +				  hw->irq_routing.mask,
> +				  enable);
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
> +				 hw->settings->event_settings.wakeup_reg.addr,
> +				 hw->settings->event_settings.wakeup_reg.mask,
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
> +	if (hw->fifo_mode !=3D ST_LSM6DSX_FIFO_BYPASS)
> +		return -EBUSY;
> +
> +	/* do not enable events if they are already enabled */
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
> @@ -1240,6 +1438,10 @@ static const struct iio_info st_lsm6dsx_acc_info =
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
> @@ -1285,9 +1487,13 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6d=
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

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXYnmwAKCRA6cBh0uS2t
rPu6AP9l/BS3TqU94rJmWJMnpcKbDAdUKUOXp6tuBBtfvJnKUwD/VvYJpcXLR0N/
dnvUik7WYOwPQWXlbYZdZDm0mQi0VAE=
=aQ8K
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
