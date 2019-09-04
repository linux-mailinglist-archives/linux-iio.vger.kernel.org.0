Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFAC8A8D89
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2019 21:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbfIDRL7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Sep 2019 13:11:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:45828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731456AbfIDRL7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Sep 2019 13:11:59 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA77621726;
        Wed,  4 Sep 2019 17:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567617118;
        bh=VR2fN6w8J6hbRXfEU1ljZGlEBttXGiVDf2EhREDP20M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cd8vscX20cQMAAQvQkRwR9lcogA22BTPYvv2rhCPpnO+IP/aXZBbp/owIEII+VEOx
         In/yyxaf/P0DHKwBJ9kvmljXx9e3h8JnewwlqW6aE1moYf9I8T7eigANhgy+HIF4Io
         ZtXfYkzknXbTSwtQbagYopNGmUIAVXaVGIuYYZr8=
Date:   Wed, 4 Sep 2019 19:11:53 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: Re: [PATCH v3 1/6] iio: imu: st_lsm6dsx: move interrupt thread to
 core
Message-ID: <20190904171153.GB2058@localhost.localdomain>
References: <20190904091732.112281-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
In-Reply-To: <20190904091732.112281-1-sean@geanix.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This prepares the interrupt to be used for other stuff than
> fifo reading + event readings.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  * none
> Changes since v2:
>  * none
>=20
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 78 +---------------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 88 +++++++++++++++++++
>  2 files changed, 89 insertions(+), 77 deletions(-)

Hi Sean,

just a couple of nitpick inline (they can be addressed even in a follow up
patch)

Regards,
Lorenzo

>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index b0f3da1976e4..ef579650fd52 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -30,8 +30,6 @@
>   * Denis Ciocca <denis.ciocca@st.com>
>   */
>  #include <linux/module.h>
> -#include <linux/interrupt.h>
> -#include <linux/irq.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -42,10 +40,6 @@
> =20
>  #include "st_lsm6dsx.h"

[...]

> +static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> +{
> +	struct st_lsm6dsx_hw *hw =3D private;
> +
> +	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> +}
> +
> +static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
> +{
> +	struct st_lsm6dsx_hw *hw =3D private;
> +	int count;
> +
> +	mutex_lock(&hw->fifo_lock);
> +	count =3D hw->settings->fifo_ops.read_fifo(hw);
> +	mutex_unlock(&hw->fifo_lock);
> +
> +	return count ? IRQ_HANDLED : IRQ_NONE;
> +}
> +
> +int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)

it can be static

> +{
> +	struct st_sensors_platform_data *pdata;
> +	struct device_node *np =3D hw->dev->of_node;
> +	unsigned long irq_type;
> +	bool irq_active_low;
> +	int err;
> +
> +	irq_type =3D irqd_get_trigger_type(irq_get_irq_data(hw->irq));
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_HIGH:
> +	case IRQF_TRIGGER_RISING:
> +		irq_active_low =3D false;
> +		break;
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_FALLING:
> +		irq_active_low =3D true;
> +		break;
> +	default:
> +		dev_info(hw->dev, "mode %lx unsupported\n", irq_type);
> +		return -EINVAL;
> +	}
> +
> +	err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_ADDR,
> +				 ST_LSM6DSX_REG_HLACTIVE_MASK,
> +				 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
> +					    irq_active_low));
> +	if (err < 0)
> +		return err;
> +
> +	pdata =3D (struct st_sensors_platform_data *)hw->dev->platform_data;
> +	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
> +	    (pdata && pdata->open_drain)) {
> +		err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_ADDR,
> +					 ST_LSM6DSX_REG_PP_OD_MASK,
> +					 FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
> +						    1));
> +		if (err < 0)
> +			return err;
> +
> +		irq_type |=3D IRQF_SHARED;
> +	}
> +
> +	err =3D devm_request_threaded_irq(hw->dev, hw->irq,
> +					st_lsm6dsx_handler_irq,
> +					st_lsm6dsx_handler_thread,
> +					irq_type | IRQF_ONESHOT,
> +					"lsm6dsx", hw);
> +	if (err) {
> +		dev_err(hw->dev, "failed to request trigger irq %d\n",
> +			hw->irq);
> +		return err;
> +	}
> +
> +	return err;

return 0 here or remove the previous one

> +}
> +
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap)
>  {
> @@ -1514,6 +1598,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, =
int hw_id,
>  	}
> =20
>  	if (hw->irq > 0) {
> +		err =3D st_lsm6dsx_irq_setup(hw);
> +		if (err < 0)
> +			return err;
> +
>  		err =3D st_lsm6dsx_fifo_setup(hw);
>  		if (err < 0)
>  			return err;
> --=20
> 2.23.0
>=20

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXW/wVgAKCRA6cBh0uS2t
rDV/AQDYl3h2Qny0fwPv8OkZyZmRD3oOoNwus0nLJ2hbUkr1SgEAjOEM4WACUmF1
KcC8Xa7pIDb5jVO+xGY/VxT5H2pldgU=
=SA2/
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--
