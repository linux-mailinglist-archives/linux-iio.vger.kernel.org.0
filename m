Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B19A9AC2
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2019 08:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730912AbfIEGkF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 5 Sep 2019 02:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfIEGkF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 5 Sep 2019 02:40:05 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59BF2173B;
        Thu,  5 Sep 2019 06:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567665604;
        bh=CxAh6+jKn8RYI7DGhAq2k10yDzOuuusN28ZT10XbfWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKa5W0A6lkKsQpO4w8SbRfi1e6kxQSgrpSVudQzWjB72IzZM4rb+Ptij7D/aNCWCG
         Uge5pCLVc1yTf/CEkZ3t0vDX76vKql+R3x5Mw28yV1heBYn96Y9HcwWAaggJj31/Ur
         xyetX0on05wKoZabCMNkmUfHn7kGSCp2bsBPhkj4=
Date:   Thu, 5 Sep 2019 08:39:59 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v3 5/6] iio: imu: st_lsm6dsx: add motion report function
 and call from interrupt
Message-ID: <20190905063959.GB31578@localhost.localdomain>
References: <20190904091732.112281-1-sean@geanix.com>
 <20190904091732.112281-5-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Content-Disposition: inline
In-Reply-To: <20190904091732.112281-5-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Report iio motion events to iio subsystem
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  * none
>=20
> Changes since v2:
>  * none
>=20
> Should we include these new defines in device settings?

nope if are the same for all available chips..have you double checked?

>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 53 ++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 513506caa460..2114c3c78888 100644
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
> @@ -72,6 +73,12 @@
>  #define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
>  #define ST_LSM6DSX_REG_PP_OD_MASK		BIT(4)
> =20
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR		0x1B
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK	BIT(0)
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK	BIT(1)
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK	BIT(2)
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK	BIT(4)
> +
>  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] =3D {
>  	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
>  	ST_LSM6DSX_CHANNEL_ACC(IIO_ACCEL, 0x2a, IIO_MOD_Y, 1),
> @@ -1611,6 +1618,40 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(str=
uct st_lsm6dsx_hw *hw,
>  	return iio_dev;
>  }
> =20
> +int st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw, int data)

void here

> +{
> +	s64 timestamp =3D iio_get_time_ns(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +
> +	if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Z,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_Y,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK)
> +		iio_push_event(hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
> +						  0,
> +						  IIO_MOD_X,
> +						  IIO_EV_TYPE_THRESH,
> +						  IIO_EV_DIR_EITHER),
> +						  timestamp);
> +
> +	return 0;
> +}
> +
>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  {
>  	return IRQ_WAKE_THREAD;
> @@ -1620,7 +1661,19 @@ static irqreturn_t st_lsm6dsx_handler_thread(int i=
rq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw =3D private;
>  	int count =3D 0;
> +	int data, err;
> +
> +	if (hw->enable_event) {
> +		err =3D regmap_read(hw->regmap,
> +				  ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR, &data);
> +		if (err < 0)
> +			goto try_fifo;
> +
> +		if (data & ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK)
> +			st_lsm6dsx_report_motion_event(hw, data);
> +	}
> =20
> +try_fifo:
>  	if (hw->sip > 0) {
>  		mutex_lock(&hw->fifo_lock);
>  		count =3D st_lsm6dsx_read_fifo(hw);
> --=20
> 2.23.0
>=20

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXXCtvAAKCRA6cBh0uS2t
rPGRAQDaVCAyx0bBelX0Bn4m+CqAD7TjogDshwDd8fF0DwkdIgEA2fROoGpD3N7M
7Hl4ATZ7juDCtlG8nX+Z8NetDqg4UAg=
=VyRx
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
