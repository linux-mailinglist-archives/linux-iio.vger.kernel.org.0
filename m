Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A93FABA2E
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2019 16:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388583AbfIFOFH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Sep 2019 10:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388178AbfIFOFG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Sep 2019 10:05:06 -0400
Received: from localhost.localdomain (unknown [151.66.4.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5EDC20854;
        Fri,  6 Sep 2019 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567778705;
        bh=zsa6DTPqR4sqGS9krRBWVJ3pDbeLF5Ggs0paM3vGTgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KCnDp0bUuLQ0TY13W8VAusCIfaY5lxoxiYSkXHIaa0LkHivygdTQRQImpgTh6M584
         7OKQmTZPyB6DxRsnNfG3NUnA7DSlIZwhzISZp0LFt/QC8MaguBo6+AHiNUFvigm0hn
         tbc+Dmx5rUEQABg0vS7WvjQtVn1oS7iYR+x6ModQ=
Date:   Fri, 6 Sep 2019 16:04:59 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v4 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190906140459.GC4515@localhost.localdomain>
References: <20190906121716.66194-1-sean@geanix.com>
 <20190906121716.66194-5-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WplhKdTI2c8ulnbP"
Content-Disposition: inline
In-Reply-To: <20190906121716.66194-5-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--WplhKdTI2c8ulnbP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Report iio motion events to iio subsystem
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v3:
>  * added wakeup_src_reg and masks to device settings
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  5 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 51 ++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>=20

nitpick inline

> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index d04473861fba..015b837f366f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -186,6 +186,11 @@ struct st_lsm6dsx_shub_settings {
>  struct st_lsm6dsx_event_settings {
>  	struct st_lsm6dsx_reg enable_reg;
>  	struct st_lsm6dsx_reg wakeup_reg;
> +	u8 wakeup_src_reg;
> +	u8 wakeup_src_status_mask;
> +	u8 wakeup_src_z_mask;
> +	u8 wakeup_src_y_mask;
> +	u8 wakeup_src_x_mask;
>  };
> =20
>  enum st_lsm6dsx_ext_sensor_id {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index ce467308eadd..470821b54933 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -48,6 +48,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/interrupt.h>
> @@ -520,6 +521,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_s=
ensor_settings[] =3D {
>  				.addr =3D 0x5B,
>  				.mask =3D GENMASK(5, 0),
>  			},
> +			.wakeup_src_reg =3D 0x1b,
> +			.wakeup_src_status_mask =3D BIT(4),
> +			.wakeup_src_z_mask =3D BIT(0),
> +			.wakeup_src_y_mask =3D BIT(1),
> +			.wakeup_src_x_mask =3D BIT(2),
>  		},
>  	},
>  	{
> @@ -1612,6 +1618,40 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(str=
uct st_lsm6dsx_hw *hw,
>  	return iio_dev;
>  }
> =20
> +void st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)
> +{
> +	s64 timestamp =3D iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +
> +	if (data & hw->settings->event_settings.wakeup_src_z_mask)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Y,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if (data & hw->settings->event_settings.wakeup_src_x_mask)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_X,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	return;

useless

> +}
> +
>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  {
>  	return IRQ_WAKE_THREAD;
> @@ -1621,6 +1661,17 @@ static irqreturn_t st_lsm6dsx_handler_thread(int i=
rq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw =3D private;
>  	int count;
> +	int data, err;
> +
> +	if (hw->enable_event) {
> +		err =3D regmap_read(hw->regmap,
> +				  hw->settings->event_settings.wakeup_src_reg, &data);
> +		if (err < 0)
> +			return IRQ_NONE;
> +
> +		if (data & hw->settings->event_settings.wakeup_src_status_mask)
> +			st_lsm6dsx_report_motion_event(hw, data);
> +	}
> =20
>  	mutex_lock(&hw->fifo_lock);
>  	count =3D hw->settings->fifo_ops.read_fifo(hw);
> --=20
> 2.23.0
>=20

--WplhKdTI2c8ulnbP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXJniAAKCRA6cBh0uS2t
rHx9AQDrhyzT1+Sle5GIYRNJtxC3llxux7C4gypovMbytr3wswEA925lsVlFJvZw
hCx/cMTIAr/IshxmvEGDVDHqFaSyEQo=
=KY02
-----END PGP SIGNATURE-----

--WplhKdTI2c8ulnbP--
