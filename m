Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAAF191F4A
	for <lists+linux-iio@lfdr.de>; Mon, 19 Aug 2019 10:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfHSIrT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Aug 2019 04:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfHSIrS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Aug 2019 04:47:18 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CBB2082C;
        Mon, 19 Aug 2019 08:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566204437;
        bh=R4Bv45WzicJAIMf86CYqZmlqMme1I+ru9KfyMBvptsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zxv2X7xCbaqmU5C/k+eW4gkW2gHQvxyj1pLRxCf3F+GRorUMycJimgn0mSSvjNWea
         pBywzxePyI8CLkqu/BDgo+oB5gWQ16FpCZCHdc7/gcyR/e801PTpRPNhD1u8JazVMa
         s9Osp4+ng+ablu5HpY1FBqYhfbOHJzUGap/d40MM=
Date:   Mon, 19 Aug 2019 10:47:10 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: imu: st_lsm6sdx: move register definitions
 to sensor_settings struct
Message-ID: <20190819084710.GA17835@localhost.localdomain>
References: <20190813073533.8007-1-martin.kepplinger@puri.sm>
 <20190813073533.8007-2-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20190813073533.8007-2-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--45Z9DzgjV8m4Oswq
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

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  6 ++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 31 ++++++++++++++------
>  2 files changed, 28 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st=
_lsm6dsx/st_lsm6dsx.h
> index 4e8e67ae1632..c8f333902eb7 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -200,6 +200,9 @@ struct st_lsm6dsx_ext_dev_settings {
>  /**
>   * struct st_lsm6dsx_settings - ST IMU sensor settings
>   * @wai: Sensor WhoAmI default value.
> + * @int1_addr: Control Register address for INT1
> + * @int2_addr: Control Register address for INT2
> + * @reset_addr: register address for reset/reboot
>   * @max_fifo_size: Sensor max fifo length in FIFO words.
>   * @id: List of hw id/device name supported by the driver configuration.
>   * @channels: IIO channels supported by the device.
> @@ -213,6 +216,9 @@ struct st_lsm6dsx_ext_dev_settings {
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
> index 85824d6739ee..56e1c5262a2c 100644
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
>  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] =3D {
>  	ST_LSM6DSX_CHANNEL(IIO_ACCEL, 0x28, IIO_MOD_X, 0),
> @@ -78,6 +73,9 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_chann=
els[] =3D {
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
> @@ -186,6 +184,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
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
> @@ -294,6 +295,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
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
> @@ -411,6 +415,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
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
> @@ -540,6 +547,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
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
> @@ -640,6 +650,9 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_se=
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
> @@ -1166,10 +1179,10 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6=
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
> @@ -1269,7 +1282,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx=
_hw *hw)
>  	int err;
> =20
>  	/* device sw reset */
> -	err =3D regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> +	err =3D regmap_update_bits(hw->regmap, hw->settings->reset_addr,
>  				 ST_LSM6DSX_REG_RESET_MASK,
>  				 FIELD_PREP(ST_LSM6DSX_REG_RESET_MASK, 1));
>  	if (err < 0)
> @@ -1278,7 +1291,7 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx=
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

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXVpiCwAKCRA6cBh0uS2t
rCQzAQCTY3lH6Z9kanC2WwOlC23pp4bh/UZmgL3L0TpWwjcMJwEArACu/ihDmU+C
y5LVhGXoawOT7f6hcV1qAznkHvgTpQA=
=yYKY
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
