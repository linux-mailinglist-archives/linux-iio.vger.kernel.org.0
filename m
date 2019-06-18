Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06C394A5EC
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2019 17:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbfFRPze (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Jun 2019 11:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729246AbfFRPze (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 18 Jun 2019 11:55:34 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A339920873;
        Tue, 18 Jun 2019 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560873333;
        bh=Ywi8PDV5uzrsD6mxjASgt3nebZaP9+Y6OwBqYvnfnCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vw5Jg3sYic2shyy8eKW51F/W3Eb2OV5Hd1Qjmk9kqI90DJZqEH69J4f25sMF4gzfx
         i0vLdPRg5VDGH7TNXVsnXKap44jfgYFpWxEQ5ex1Rmh9R9Kx5vAjGZ94NFMOFiRuSB
         NtmAfjCaogDIKzWzaIixqPL/ZIqrg4ac6rKfL5gw=
Date:   Tue, 18 Jun 2019 17:55:27 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com, martin@geanix.com
Subject: Re: [PATCH 4/5] iio: imu: st_lsm6dsx: always enter interrupt thread
Message-ID: <20190618155527.GD20044@localhost.localdomain>
References: <20190618125939.105903-1-sean@geanix.com>
 <20190618125939.105903-5-sean@geanix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sgneBHv3152wZ8jf"
Content-Disposition: inline
In-Reply-To: <20190618125939.105903-5-sean@geanix.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--sgneBHv3152wZ8jf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The interrupt source can come from multiple sources, fifo and wake interr=
upts.
> Enter interrupt thread to check which interrupt that has fired.
>=20
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++-----
>  1 file changed, 23 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 59a34894e495..76aec5024d83 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -78,6 +78,12 @@
>  #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
>  #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
> =20
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR		0x1B
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Z_WU_MASK	BIT(0)
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_Y_WU_MASK	BIT(1)
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_X_WU_MASK	BIT(2)
> +#define ST_LSM6DSX_REG_WAKE_UP_SRC_WU_MASK	BIT(4)
> +
>  #define ST_LSM6DSX_REG_TAP_CFG_ADDR		0x58
>  #define ST_LSM6DSX_REG_TAP_CFG_INT_EN_MASK	BIT(7)
>  #define ST_LSM6DSX_REG_TAP_CFG_INACT_EN_MASK	GENMASK(6, 5)
> @@ -946,19 +952,29 @@ int st_lsm6dsx_event_setup(struct st_lsm6dsx_hw *hw)
> =20
>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
>  {
> -	struct st_lsm6dsx_hw *hw =3D private;
> -
> -	return hw->sip > 0 ? IRQ_WAKE_THREAD : IRQ_NONE;
> +	return IRQ_WAKE_THREAD;

I guess this will break shared interrupt, isn't it?

>  }
> =20
>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw =3D private;
> -	int count;
> +	int count =3D 0;
> +	int data, err;
> +
> +	if (hw->enable_event) {
> +		err =3D regmap_read(hw->regmap,
> +				  ST_LSM6DSX_REG_WAKE_UP_SRC_ADDR, &data);
> +		if (err < 0)
> +			goto try_fifo;

You can simplify this just doing something like:

		if (err < 0 && !hw->sip)
			return IRQ_NONE;

> +
> +	}
> =20
> -	mutex_lock(&hw->fifo_lock);
> -	count =3D st_lsm6dsx_read_fifo(hw);
> -	mutex_unlock(&hw->fifo_lock);
> +try_fifo:
> +	if (hw->sip > 0) {
> +		mutex_lock(&hw->fifo_lock);
> +		count =3D st_lsm6dsx_read_fifo(hw);
> +		mutex_unlock(&hw->fifo_lock);
> +	}
> =20
>  	return !count ? IRQ_NONE : IRQ_HANDLED;
>  }
> --=20
> 2.22.0
>=20

--sgneBHv3152wZ8jf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQkJbAAKCRA6cBh0uS2t
rPr2AQC3aXD1+T84LqwstDz0G4zXwab238pxkSSI8yM347sdmwEAtnLLojwDkCzF
JqAG+sLQEEbzDnP3QiMGZauaA0OF3wU=
=yHa4
-----END PGP SIGNATURE-----

--sgneBHv3152wZ8jf--
