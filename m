Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414386A58C
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2019 11:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbfGPJoF (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 16 Jul 2019 05:44:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387484AbfGPJoE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jul 2019 05:44:04 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1655217F9;
        Tue, 16 Jul 2019 09:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563270243;
        bh=Fts1c/GBCIq2omt/GxprKpRhx5TA1RP0D2JVUXG239o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=akLetOSNhaa2pXHR/MrcMSSgqaTOvOpog8k2rU4hIz38Y9JEhHLDlj4QqPh2Qj5Rm
         vN4PrwXZ2AkKV1xfYAwGlu0N7mD7CiR1ZYjAeg9LXpiLvxdFyKlb4TvobCvvGLxb3z
         Zgy7l9llWVpeTYFAoUf0moSjIsmm2xcej6IZ+7ec=
Date:   Tue, 16 Jul 2019 11:43:58 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv2 1/3] iio: imu: st_lsm6sdx: move register definitions to
 sensor_settings struct
Message-ID: <20190716094358.GC13440@localhost.localdomain>
References: <20190716093325.7683-1-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20190716093325.7683-1-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Move some register definitions to the per-device array of struct
> st_lsm6dsx_sensor_settings in order to simplify adding new sensor
> devices to the driver.
>=20
> Also, remove completely unused register definitions.
>=20
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>=20

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> This is already based on Lorenzo's recent changes:
> https://lore.kernel.org/linux-iio/853f216a-7814-cb79-180b-078ac5e8a359@pu=
ri.sm/T/#u
> https://lore.kernel.org/linux-iio/501b0db9-63cb-905c-c09b-682eb73f1ff3@pu=
ri.sm/T/#u
>=20
> revision history:
> v2: improve variable names, thanks Lorenzo
>=20
> thanks
>                        martin
>=20
>=20
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  6 ++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++------
>  2 files changed, 28 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index ab1c66615d67..3c47f5d27d30 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -198,6 +198,9 @@ struct st_lsm6dsx_ext_dev_settings {
>  /**
>   * struct st_lsm6dsx_settings - ST IMU sensor settings
>   * @wai: Sensor WhoAmI default value.
> + * @int1_addr: Control Register address for INT1
> + * @int2_addr: Control Register address for INT2
> + * @reset_addr: register address for reset/reboot
>   * @max_fifo_size: Sensor max fifo length in FIFO words.
>   * @id: List of hw id/device name supported by the driver configuration.
>   * @odr_table: Hw sensors odr table (Hz + val).
> @@ -210,6 +213,9 @@ struct st_lsm6dsx_ext_dev_settings {
>   */
>  struct st_lsm6dsx_settings {
>  	u8 wai;
> +	u8 int1_addr;
> +	u8 int2_addr;
> +	u8 reset_addr;
>  	u16 max_fifo_size;
>  	struct {
>  		enum st_lsm6dsx_hw_id hw_id;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 9aa109428a52..e0d2149625cc 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -49,17 +49,12 @@
> =20
>  #include "st_lsm6dsx.h"
> =20
> -#define ST_LSM6DSX_REG_INT1_ADDR		0x0d
> -#define ST_LSM6DSX_REG_INT2_ADDR		0x0e
>  #define ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK	BIT(3)
>  #define ST_LSM6DSX_REG_WHOAMI_ADDR		0x0f
> -#define ST_LSM6DSX_REG_RESET_ADDR		0x12
>  #define ST_LSM6DSX_REG_RESET_MASK		BIT(0)
>  #define ST_LSM6DSX_REG_BOOT_MASK		BIT(7)
>  #define ST_LSM6DSX_REG_BDU_ADDR			0x12
>  #define ST_LSM6DSX_REG_BDU_MASK			BIT(6)
> -#define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
> -#define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
> =20
>  #define ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR		0x28
>  #define ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR		0x2a
> @@ -72,6 +67,9 @@
>  static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] =3D=
 {
>  	{
>  		.wai =3D 0x69,
> +		.int1_addr =3D 0x0d,
> +		.int2_addr =3D 0x0e,
> +		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 1365,
>  		.id =3D {
>  			{
> @@ -170,6 +168,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  	},
>  	{
>  		.wai =3D 0x69,
> +		.int1_addr =3D 0x0d,
> +		.int2_addr =3D 0x0e,
> +		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 682,
>  		.id =3D {
>  			{
> @@ -268,6 +269,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  	},
>  	{
>  		.wai =3D 0x6a,
> +		.int1_addr =3D 0x0d,
> +		.int2_addr =3D 0x0e,
> +		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 682,
>  		.id =3D {
>  			{
> @@ -375,6 +379,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  	},
>  	{
>  		.wai =3D 0x6c,
> +		.int1_addr =3D 0x0d,
> +		.int2_addr =3D 0x0e,
> +		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 512,
>  		.id =3D {
>  			{
> @@ -494,6 +501,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  	},
>  	{
>  		.wai =3D 0x6b,
> +		.int1_addr =3D 0x0d,
> +		.int2_addr =3D 0x0e,
> +		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 512,
>  		.id =3D {
>  			{
> @@ -584,6 +594,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
nsor_settings[] =3D {
>  	},
>  	{
>  		.wai =3D 0x6b,
> +		.int1_addr =3D 0x0d,
> +		.int2_addr =3D 0x0e,
> +		.reset_addr =3D 0x12,
>  		.max_fifo_size =3D 512,
>  		.id =3D {
>  			{
> @@ -1117,10 +1130,10 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6=
dsx_hw *hw, u8 *drdy_reg)
> =20
>  	switch (drdy_pin) {
>  	case 1:
> -		*drdy_reg =3D ST_LSM6DSX_REG_INT1_ADDR;
> +		*drdy_reg =3D hw->settings->int1_addr;
>  		break;
>  	case 2:
> -		*drdy_reg =3D ST_LSM6DSX_REG_INT2_ADDR;
> +		*drdy_reg =3D hw->settings->int2_addr;
>  		break;
>  	default:
>  		dev_err(hw->dev, "unsupported data ready pin\n");
> @@ -1220,7 +1233,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx=
_hw *hw)
>  	int err;
> =20
>  	/* device sw reset */
> -	err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> +	err =3D regmap_update_bits(hw->regmap, hw->settings->reset_addr,
>  				 ST_LSM6DSX_REG_RESET_MASK,
>  				 FIELD_PREP(ST_LSM6DSX_REG_RESET_MASK, 1));
>  	if (err < 0)
> @@ -1229,7 +1242,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx=
_hw *hw)
>  	msleep(50);
> =20
>  	/* reload trimming parameter */
> -	err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> +	err =3D regmap_update_bits(hw->regmap, hw->settings->reset_addr,
>  				 ST_LSM6DSX_REG_BOOT_MASK,
>  				 FIELD_PREP(ST_LSM6DSX_REG_BOOT_MASK, 1));
>  	if (err < 0)
> --=20
> 2.20.1
>=20

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXS2cWwAKCRA6cBh0uS2t
rPCiAP9ZSYRWVjF/NQsyE0/XMhEB+B/jKxlgh2QWGQNVwt3ZbAD/VnSyeT+Vdboh
oVhejxk+BT5WBkrA7hnTjCo6ZI+yPgY=
=YeZb
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
