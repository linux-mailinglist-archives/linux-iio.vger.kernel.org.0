Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EB25505AC
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiFRPTW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 11:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiFRPTV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 11:19:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602E712AD0;
        Sat, 18 Jun 2022 08:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC494B80A72;
        Sat, 18 Jun 2022 15:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291A3C3411A;
        Sat, 18 Jun 2022 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655565556;
        bh=XTw8rMPcX20aPd5ojmMpNK7qww8zUJIntwhdvoI1SMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uG1Mnw/2l5qjY1Z8HQ4A44VeV+GbO2ZAd+v6oSj+2fecYC/N8TsyFiOBDoMSWgjeJ
         CL4+lGpwjhlgJB4ijKhqqQ3Q++HX9dtTddJO4Zk2WdP8gpE6pEdDB27uTC1DdVRsZZ
         sJiGbX+TV0VGO/qydyx/mrj6U4IV18OJgw3ZekVD5jK+TGrhcDkGlC1wOHitx8QI7F
         f2k5ZKvdbM8m2cYvmvfg56/igk9GkgFIkOPtMZke75Ge84RlzYRE1JiY461gjiEZjT
         Te/r50EqAE+uLRaEsP/RIwqaEQxAqtxdt/vP5UoVl1X6nSCPjgAeS7KiDjJpKLsPmZ
         tRvML5RfA3aIA==
Date:   Sat, 18 Jun 2022 16:28:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 8/8] iio: magnetometer: yas530: Add YAS537 variant
Message-ID: <20220618162833.218dbe67@jic23-huawei>
In-Reply-To: <3bdb392bb75073bdfe10aab1739fee2d6c64f10c.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
        <3bdb392bb75073bdfe10aab1739fee2d6c64f10c.1655509425.git.jahau@rocketmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 18 Jun 2022 02:13:16 +0200
Jakob Hauser <jahau@rocketmail.com> wrote:

> This adds support for the magnetometer Yamaha YAS537. The additions are b=
ased
> on comparison of Yamaha Android kernel drivers for YAS532 [1] and YAS537 =
[2].
>=20
> In the Yamaha YAS537 Android driver, there is an overflow/underflow contr=
ol
> implemented. For regular usage, this seems not necessary. A similar overf=
low/
> underflow control of Yamaha YAS530/532 Android driver isn't integrated in=
 the
> mainline driver. It is therefore skipped for YAS537 in mainline too.
>=20
> Also in the Yamaha YAS537 Android driver, at the end of the reset_yas537()
> function, a measurement is saved in "last_after_rcoil". Later on, this is
> compared to current measurements. If the difference gets too big, a new
> reset is initialized. The difference in measurements needs to be quite bi=
g,
> it's hard to say if this is necessary for regular operation. Therefore th=
is
> isn't integrated in the mainline driver either.
>=20
> [1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/=
GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c
> [2] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/=
GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas537.c
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Various comments inline, but mostly following through from earlier feedback
that you would end up with much simpler and more readable code by using
a nice const chip_info structure the address of which you assign in a single
place in _probe()

It's a common pattern and it almost always ends up simpler for drivers that=
 end
up supporting more than one or two different device variants.

Thanks,

Jonathan

> ---
> The diff on function yas5xx_probe() is a bit confusing. Maybe better to
> understand when comparing before and after code.
> before: https://github.com/torvalds/linux/blob/v5.19-rc2/drivers/iio/magn=
etometer/yamaha-yas530.c#L873-L902
> after: https://github.com/Jakko3/linux/blob/yas537_v3/drivers/iio/magneto=
meter/yamaha-yas530.c#L1416-L1463
>=20
>  drivers/iio/magnetometer/Kconfig         |   4 +-
>  drivers/iio/magnetometer/yamaha-yas530.c | 553 +++++++++++++++++++++--
>  2 files changed, 529 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/=
Kconfig
> index 07eb619bcfe8..868128cee835 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -216,8 +216,8 @@ config YAMAHA_YAS530
>  	select IIO_TRIGGERED_BUFFER
>  	help
>  	  Say Y here to add support for the Yamaha YAS530 series of
> -	  3-Axis Magnetometers. Right now YAS530, YAS532 and YAS533 are
> -	  fully supported.
> +	  3-Axis Magnetometers. Right now YAS530, YAS532, YAS533 and
> +	  YAS537 are fully supported.
Whilst here I'd reduce this to

	  3-Axis Magnetometers. YAS530, YAS532, YAS533 and YAS537
	  are supported.

"Right now" provides no information - we are hardly likely to be talking
about code at some stage in the past or future.
"fully" isn't all that well defined and doesn't add anything over supported.

> =20
>  	  This driver can also be compiled as a module.
>  	  To compile this driver as a module, choose M here: the module
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magne=
tometer/yamaha-yas530.c
> index 72a75dc57e11..e6123d1d9383 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -17,6 +17,9 @@
>   * named "inv_compass" in the Tegra Android kernel tree.
>   * Copyright (C) 2012 InvenSense Corporation
>   *
> + * Code functions for YAS537 based on Yamaha Android kernel driver.
> + * Copyright (c) 2014 Yamaha Corporation
> + *
>   * Author: Linus Walleij <linus.walleij@linaro.org>
>   */
>  #include <linux/bitfield.h>
> @@ -56,6 +59,23 @@
>  #define YAS530_532_TEST2		0x89
>  #define YAS530_532_CAL			0x90
> =20
> +/* Registers used by YAS537 */
> +#define YAS537_MEASURE			0x81 /* Originally YAS537_REG_CMDR */
> +#define YAS537_CONFIG			0x82 /* Originally YAS537_REG_CONFR */
> +#define YAS537_MEASURE_INTERVAL		0x83 /* Originally YAS537_REG_INTRVLR */
> +#define YAS537_OFFSET_X			0x84 /* Originally YAS537_REG_OXR */
> +#define YAS537_OFFSET_Y1		0x85 /* Originally YAS537_REG_OY1R */
> +#define YAS537_OFFSET_Y2		0x86 /* Originally YAS537_REG_OY2R */
> +#define YAS537_AVR			0x87
> +#define YAS537_HCK			0x88
> +#define YAS537_LCK			0x89
> +#define YAS537_SRST			0x90
> +#define YAS537_ADCCAL			0x91
> +#define YAS537_MTC			0x93
> +#define YAS537_OC			0x9E
> +#define YAS537_TRM			0x9F
> +#define YAS537_CAL			0xC0
> +
>  /* Bits in the YAS5xx config register */
>  #define YAS5XX_CONFIG_INTON		BIT(0) /* Interrupt on? */
>  #define YAS5XX_CONFIG_INTHACT		BIT(1) /* Interrupt active high? */
> @@ -67,6 +87,7 @@
>  #define YAS5XX_MEASURE_LDTC		BIT(1)
>  #define YAS5XX_MEASURE_FORS		BIT(2)
>  #define YAS5XX_MEASURE_DLYMES		BIT(4)
> +#define YAS5XX_MEASURE_CONT		BIT(5)
> =20
>  /* Bits in the measure data register */
>  #define YAS5XX_MEASURE_DATA_BUSY	BIT(7)
> @@ -93,8 +114,15 @@
>  #define YAS532_DATA_OVERFLOW		(BIT(YAS532_DATA_BITS) - 1)
>  #define YAS532_20DEGREES		390 /* Counts starting at -50 =C2=B0C */
> =20
> -/* These variant IDs are known from code dumps */
>  #define YAS537_DEVICE_ID		0x07 /* YAS537 (MS-3T) */
> +#define YAS537_VERSION_0		0 /* Version naming unknown */
> +#define YAS537_VERSION_1		1 /* Version naming unknown */
> +#define YAS537_MAG_AVERAGE_32_MASK	GENMASK(6, 4)
> +#define YAS537_MEASURE_TIME_WORST_US	1500
> +#define YAS537_DEFAULT_SENSOR_DELAY_MS	50
> +#define YAS537_MAG_RCOIL_TIME_US	65
> +#define YAS537_20DEGREES		8120 /* Counts starting at -386 =C2=B0C */
> +
>  #define YAS539_DEVICE_ID		0x08 /* YAS539 (MS-3S) */
> =20
>  /* Turn off device regulators etc after 5 seconds of inactivity */
> @@ -267,6 +295,78 @@ static int yas530_532_measure(struct yas5xx *yas5xx,=
 u16 *t,
>  	return ret;
>  }
> =20
> +/**
> + * yas537_measure() - Make a measure from the hardware
> + * @yas5xx: The device state
> + * @t: the raw temperature measurement
> + * @x: the raw x axis measurement
> + * @y1: the y1 axis measurement
> + * @y2: the y2 axis measurement
> + * @return: 0 on success or error code
> + */
> +static int yas537_measure(struct yas5xx *yas5xx, u16 *t,
> +			  u16 *x, u16 *y1, u16 *y2)
> +{
> +	struct yas5xx_calibration *c =3D &yas5xx->calibration;
> +	unsigned int busy;
> +	u8 data[8];
> +	u16 xy1y2[3];
> +	s32 h[3], s[3];
> +	int i, ret;
> +
> +	mutex_lock(&yas5xx->lock);
> +
> +	/* Contrary to YAS530/532, also a "cont" bit is set, meaning unknown */
> +	ret =3D regmap_write(yas5xx->map, YAS537_MEASURE, YAS5XX_MEASURE_START |
> +			   YAS5XX_MEASURE_CONT);
> +	if (ret < 0)
> +		goto out_unlock;
> +
> +	/* Use same timeout like YAS530/532 but the bit is in data row 2 */
> +	ret =3D regmap_read_poll_timeout(yas5xx->map, YAS5XX_MEASURE_DATA + 2, =
busy,
> +				       !(busy & YAS5XX_MEASURE_DATA_BUSY),
> +				       500, 20000);
> +	if (ret) {
> +		dev_err(yas5xx->dev, "timeout waiting for measurement\n");
> +		goto out_unlock;
> +	}
> +
> +	ret =3D regmap_bulk_read(yas5xx->map, YAS5XX_MEASURE_DATA,
> +			       data, sizeof(data));
> +	if (ret)
> +		goto out_unlock;
> +
> +	mutex_unlock(&yas5xx->lock);
> +
> +	*t =3D get_unaligned_be16(&data[0]);
> +	xy1y2[0] =3D FIELD_GET(GENMASK(13, 0), get_unaligned_be16(&data[2]));
> +	xy1y2[1] =3D get_unaligned_be16(&data[4]);
> +	xy1y2[2] =3D get_unaligned_be16(&data[6]);
> +
> +	/* The second version of YAS537 needs to include calibration coefficien=
ts */
> +	if (yas5xx->version =3D=3D YAS537_VERSION_1) {
> +		for (i =3D 0; i < 3; i++)
> +			s[i] =3D xy1y2[i] - BIT(13);
> +		h[0] =3D (c->k *   (128 * s[0] + c->a2 * s[1] + c->a3 * s[2])) / BIT(1=
3);
> +		h[1] =3D (c->k * (c->a4 * s[0] + c->a5 * s[1] + c->a6 * s[2])) / BIT(1=
3);
> +		h[2] =3D (c->k * (c->a7 * s[0] + c->a8 * s[1] + c->a9 * s[2])) / BIT(1=
3);
> +		for (i =3D 0; i < 3; i++) {
> +			clamp_val(h[i], -BIT(13), BIT(13) - 1);
> +			xy1y2[i] =3D h[i] + BIT(13);
> +		}
> +	}
> +
> +	*x =3D xy1y2[0];
> +	*y1 =3D xy1y2[1];
> +	*y2 =3D xy1y2[2];
> +
> +	return 0;
> +
> +out_unlock:
> +	mutex_unlock(&yas5xx->lock);
> +	return ret;
> +}
> +
>  static s32 yas530_532_linearize(struct yas5xx *yas5xx, u16 val, int axis)
>  {
>  	struct yas5xx_calibration *c =3D &yas5xx->calibration;
> @@ -437,6 +537,58 @@ static int yas530_532_get_measure(struct yas5xx *yas=
5xx, s32 *to,
>  	return 0;
>  }
> =20
> +/**
> + * yas537_get_measure() - Measure a sample of all axis and process
> + * @yas5xx: The device state
> + * @to: Temperature out
> + * @xo: X axis out
> + * @yo: Y axis out
> + * @zo: Z axis out
> + * @return: 0 on success or error code
> + */
> +static int yas537_get_measure(struct yas5xx *yas5xx, s32 *to,
> +			      s32 *xo, s32 *yo, s32 *zo)
> +{
> +	u16 t_ref, t, x, y1, y2;
> +	int ret;
> +
> +	/* We first get raw data that needs to be translated to [x,y,z] */
> +	ret =3D yas537_measure(yas5xx, &t, &x, &y1, &y2);
> +	if (ret)
> +		return ret;
> +
> +	/* Set the temperature reference value (unit: counts) */
> +	t_ref =3D YAS537_20DEGREES;
> +
> +	/*
> +	 * Raw temperature value t is the number of counts. YAS537 product
> +	 * description No. PBAS537A-000-01-e mentions a temperature resolution
> +	 * of 0.05 =C2=B0C/count. A readout of the t value at ca. 20 =C2=B0C re=
turns
> +	 * approx. 8120 counts.
> +	 *
> +	 * 8120 counts x 0.05 =C2=B0C/count corresponds to a range of 406 =C2=
=B0C.
> +	 * 0 counts would be at theoretical -386 =C2=B0C.
> +	 *
> +	 * The formula used for YAS530/532 needs to be adapted to this
> +	 * theoretical starting temperature, again calculating with 1/10:s
> +	 * of degrees Celsius and finally multiplying by 100 to get milli
> +	 * degrees Celsius.
> +	 */
> +	*to =3D ((4060 * t / t_ref) - 3860) * 100;
> +
> +	/*
> +	 * Unfortunately, no linearization or temperature compensation formulas
> +	 * are known for YAS537.
> +	 */
> +
> +	/* Calculate x, y, z from x, y1, y2 */
> +	*xo =3D (x - BIT(13)) * 300;
> +	*yo =3D (y1 - y2) * 1732 / 10;
> +	*zo =3D (-y1 - y2 + BIT(14)) * 300;
> +
> +	return 0;
> +}
> +
>  static int yas5xx_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2,
> @@ -450,7 +602,18 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_PROCESSED:
>  	case IIO_CHAN_INFO_RAW:
>  		pm_runtime_get_sync(yas5xx->dev);
> -		ret =3D yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
> +		switch (yas5xx->devid) {
> +		case YAS530_DEVICE_ID:
> +		case YAS532_DEVICE_ID:
> +			ret =3D yas530_532_get_measure(yas5xx, &t, &x, &y, &z);

As below, use function pointers in a chip_info struct to avoid switch
statements like this and give shorter + more readable code.

> +			break;
> +		case YAS537_DEVICE_ID:
> +			ret =3D yas537_get_measure(yas5xx, &t, &x, &y, &z);
> +			break;
> +		default:
> +			dev_err(yas5xx->dev, "unknown device type\n");
> +			return -EINVAL;
> +		}
>  		pm_runtime_mark_last_busy(yas5xx->dev);
>  		pm_runtime_put_autosuspend(yas5xx->dev);
>  		if (ret)
> @@ -484,9 +647,10 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
>  			*val2 =3D 100000000;
>  			break;
>  		case YAS532_DEVICE_ID:
> +		case YAS537_DEVICE_ID:
>  			/*
> -			 * Raw values of YAS532 are in nanotesla. Divide by
> -			 * 100000 (10^5) to get Gauss.
> +			 * Raw values of YAS532 and YAS537 are in nanotesla.
> +			 * Divide by 100000 (10^5) to get Gauss.
>  			 */
>  			*val =3D 1;
>  			*val2 =3D 100000;
> @@ -506,7 +670,18 @@ static void yas5xx_fill_buffer(struct iio_dev *indio=
_dev)
>  	int ret;
> =20
>  	pm_runtime_get_sync(yas5xx->dev);
> -	ret =3D yas5xx_get_measure(yas5xx, &t, &x, &y, &z);

yas5xx->chip_info.get_measure()

> +	switch (yas5xx->devid) {
> +	case YAS530_DEVICE_ID:
> +	case YAS532_DEVICE_ID:
> +		ret =3D yas530_532_get_measure(yas5xx, &t, &x, &y, &z);
> +		break;
> +	case YAS537_DEVICE_ID:
> +		ret =3D yas537_get_measure(yas5xx, &t, &x, &y, &z);
> +		break;
> +	default:
> +		dev_err(yas5xx->dev, "unknown device type\n");
> +		return;
> +	}
>  	pm_runtime_mark_last_busy(yas5xx->dev);
>  	pm_runtime_put_autosuspend(yas5xx->dev);
>  	if (ret) {
> @@ -592,9 +767,34 @@ static const struct iio_info yas5xx_info =3D {
> =20
>  static bool yas5xx_volatile_reg(struct device *dev, unsigned int reg)
>  {
> -	return reg =3D=3D YAS5XX_ACTUATE_INIT_COIL ||
> -		reg =3D=3D YAS5XX_MEASURE ||
> -		(reg >=3D YAS5XX_MEASURE_DATA && reg <=3D YAS5XX_MEASURE_DATA + 7);
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct yas5xx *yas5xx =3D iio_priv(indio_dev);
> +
> +	if (reg >=3D YAS5XX_MEASURE_DATA && reg <=3D YAS5XX_MEASURE_DATA + 7)
> +		return true;
> +
> +	/*
> +	 * YAS versions share different registers on the same address,
> +	 * need to differentiate.
Better as separate functions via the chip_info structure I'm suggesting
you add.  That will end up more readable as additional devices are added
at the cost of a slightly more code in this case.

> +	 */
> +	switch (yas5xx->devid) {
> +	case YAS530_DEVICE_ID:
> +	case YAS532_DEVICE_ID:
> +		if (reg =3D=3D YAS530_532_ACTUATE_INIT_COIL ||
> +		    reg =3D=3D YAS530_532_MEASURE)
> +			return true;
> +		break;
> +	case YAS537_DEVICE_ID:
> +		if (reg =3D=3D YAS537_MEASURE)
> +			return true;
> +		break;
> +	default:
> +		dev_err(yas5xx->dev, "unknown device type\n");
> +		break;
> +		/* fall through */
> +	}
> +
> +	return false;
>  }
> =20
>  /* TODO: enable regmap cache, using mark dirty and sync at runtime resum=
e */
> @@ -749,6 +949,216 @@ static int yas532_get_calibration_data(struct yas5x=
x *yas5xx)
>  	return 0;
>  }
> =20
> +static int yas537_get_calibration_data(struct yas5xx *yas5xx)
> +{
> +	struct yas5xx_calibration *c =3D &yas5xx->calibration;
> +	u8 data[17];
> +	u32 val1, val2, val3, val4;
> +	int i, ret;
> +
> +	/* Writing SRST register, the exact meaning is unknown */
> +	ret =3D regmap_write(yas5xx->map, YAS537_SRST, BIT(1));
> +	if (ret)
> +		return ret;
> +
> +	/* Calibration readout, YAS537 needs one readout only */
> +	ret =3D regmap_bulk_read(yas5xx->map, YAS537_CAL, data, sizeof(data));
> +	if (ret)
> +		return ret;
> +	dev_dbg(yas5xx->dev, "calibration data: %17ph\n", data);
> +
> +	/* Sanity check, is this all zeroes? */
> +	if (!memchr_inv(data, 0x00, 16)) {
> +		if (FIELD_GET(GENMASK(5, 0), data[16]) =3D=3D 0)
> +			dev_warn(yas5xx->dev, "calibration is blank!\n");
> +	}
> +
> +	/* Contribute calibration data to the input pool for kernel entropy */
> +	add_device_randomness(data, sizeof(data));
> +
> +	/* Extract version information */
> +	yas5xx->version =3D FIELD_GET(GENMASK(7, 6), data[16]);
> +
> +	/* There are two versions of YAS537 behaving differently */
> +	switch (yas5xx->version) {
> +
> +	case YAS537_VERSION_0:
Seems like we might need more chip_info variants, though perhaps in this ca=
se
it is worth handling it as a switch statement as hopefully the number of
way s this is done for a given part number won't grow any further.

> +
> +		/*
> +		 * The first version simply writes data back into registers:
> +		 *
> +		 * data[0]  YAS537_MTC		0x93
> +		 * data[1]			0x94
> +		 * data[2]			0x95
> +		 * data[3]			0x96
> +		 * data[4]			0x97
> +		 * data[5]			0x98
> +		 * data[6]			0x99
> +		 * data[7]			0x9a
> +		 * data[8]			0x9b
> +		 * data[9]			0x9c
> +		 * data[10]			0x9d
> +		 * data[11] YAS537_OC		0x9e
> +		 *
> +		 * data[12] YAS537_OFFSET_X	0x84
> +		 * data[13] YAS537_OFFSET_Y1	0x85
> +		 * data[14] YAS537_OFFSET_Y2	0x86
> +		 *
> +		 * data[15] YAS537_HCK		0x88
> +		 * data[16] YAS537_LCK		0x89
> +		 */
> +
> +		for (i =3D 0; i < 17; i++) {

Reduce indent by doing this as multiple loops.
Though even better if you can use bulk writes.

		int j =3D 0;
		for (i =3D 0; i < 12; i++) {
			ret =3D regmap_write(yas5xx->map, YAS537_MTC + i,
					   data[j++])
			if (ret)
				return ret;
		}

		for (i =3D 0; i < 4; i++) {
			ret =3D regmap_write(yas5xx->map, YAS573_OFFSET_X + i,
					   data[j++]);
			if (ret)
				return ret;
		} =09

> +			if (i < 12) {
> +				ret =3D regmap_write(yas5xx->map,
> +						   YAS537_MTC + i,
> +						   data[i]);
> +				if (ret)
> +					return ret;
> +			} else if (i < 15) {
> +				ret =3D regmap_write(yas5xx->map,
> +						   YAS537_OFFSET_X + i - 12,
> +						   data[i]);
> +				if (ret)
> +					return ret;
> +				yas5xx->hard_offsets[i - 12] =3D data[i];
> +			} else {
> +				ret =3D regmap_write(yas5xx->map,
> +						   YAS537_HCK + i - 15,
> +						   data[i]);
> +				if (ret)
> +					return ret;
> +			}
> +		}
> +
> +		break;
> +
> +	case YAS537_VERSION_1:
> +
> +		/*
> +		 * The second version writes some data into registers but also
> +		 * extracts calibration coefficients.
> +		 *
> +		 * Registers being written:
> +		 *
> +		 * data[0]  YAS537_MTC			0x93
> +		 * data[1]  YAS537_MTC+1		0x94
> +		 * data[2]  YAS537_MTC+2		0x95
> +		 * data[3]  YAS537_MTC+3 (partially)	0x96
> +		 *
> +		 * data[12] YAS537_OFFSET_X		0x84
> +		 * data[13] YAS537_OFFSET_Y1		0x85
> +		 * data[14] YAS537_OFFSET_Y2		0x86
> +		 *
> +		 * data[15] YAS537_HCK (partially)	0x88
> +		 *          YAS537_LCK (partially)	0x89
> +		 * data[16] YAS537_OC  (partially)	0x9e
> +		 */
> +
> +		for (i =3D 0; i < 3; i++) {
> +			ret =3D regmap_write(yas5xx->map, YAS537_MTC + i,
> +					   data[i]);
> +			if (ret)
> +				return ret;
> +			ret =3D regmap_write(yas5xx->map, YAS537_OFFSET_X + i,
> +					   data[i + 12]);
> +			if (ret)
> +				return ret;
> +			yas5xx->hard_offsets[i] =3D data[i + 12];
> +		}
> +
> +		/*
> +		 * Visualization of partially taken data:
> +		 *
> +		 * data[3]       n 7 6 5 4 3 2 1 0
> +		 * YAS537_MTC+3    x x x 1 0 0 0 0
> +		 *
> +		 * data[15]      n 7 6 5 4 3 2 1 0
> +		 * YAS537_HCK      x x x x 0
> +		 *
> +		 * data[15]      n 7 6 5 4 3 2 1 0
> +		 * YAS537_LCK              x x x x 0
> +		 *
> +		 * data[16]      n 7 6 5 4 3 2 1 0
> +		 * YAS537_OC           x x x x x x
> +		 */
> +
> +		ret =3D regmap_write(yas5xx->map, YAS537_MTC + 3,
> +				   (data[3] & GENMASK(7, 5)) | BIT(4));

If we can give the masks meaningful names that would be great then
use FIELD_GET and FIELD_PREP with those defines (even if it puts it back
in the same place like here).  Let the compiler optimise out anything
unnecessary in the way of masks and shifts.

> +		if (ret)
> +			return ret;
> +		ret =3D regmap_write(yas5xx->map, YAS537_HCK,
> +				   FIELD_GET(GENMASK(7, 4), data[15]) << 1);

FIELD_PREP() with suitable mask defined to make it clear what field is bein=
g written.

> +		if (ret)
> +			return ret;
> +		ret =3D regmap_write(yas5xx->map, YAS537_LCK,
> +				   FIELD_GET(GENMASK(3, 0), data[15]) << 1);
> +		if (ret)
> +			return ret;
> +		ret =3D regmap_write(yas5xx->map, YAS537_OC,
> +				   FIELD_GET(GENMASK(5, 0), data[16]));
> +		if (ret)
> +			return ret;
> +
> +		/*
> +		 * For data extraction, build some blocks. Four 32-bit blocks
> +		 * look appropriate.
> +		 *
> +		 *            n    7  6  5  4  3  2  1  0
> +		 *  data[0]   0 [ Cx Cx Cx Cx Cx Cx Cx Cx ] bits 31 .. 24
> +		 *  data[1]   1 [ Cx C1 C1 C1 C1 C1 C1 C1 ] bits 23 .. 16
> +		 *  data[2]   2 [ C1 C1 C2 C2 C2 C2 C2 C2 ] bits 15 .. 8
> +		 *  data[3]   3 [ C2 C2 C2                ] bits  7 .. 0
> +		 *
> +		 *            n    7  6  5  4  3  2  1  0
> +		 *  data[3]   0 [          a2 a2 a2 a2 a2 ] bits 31 .. 24
> +		 *  data[4]   1 [ a2 a2 a3 a3 a3 a3 a3 a3 ] bits 23 .. 16
> +		 *  data[5]   2 [ a3 a4 a4 a4 a4 a4 a4 a4 ] bits 15 .. 8
> +		 *  data[6]   3 [ a4                      ] bits  7 .. 0
> +		 *
> +		 *            n    7  6  5  4  3  2  1  0
> +		 *  data[6]   0 [    a5 a5 a5 a5 a5 a5 a5 ] bits 31 .. 24
> +		 *  data[7]   1 [ a5 a5 a6 a6 a6 a6 a6 a6 ] bits 23 .. 16
> +		 *  data[8]   2 [ a6 a7 a7 a7 a7 a7 a7 a7 ] bits 15 .. 8
> +		 *  data[9]   3 [ a7                      ] bits  7 .. 0
> +		 *
> +		 *            n    7  6  5  4  3  2  1  0
> +		 *  data[9]   0 [    a8 a8 a8 a8 a8 a8 a8 ] bits 31 .. 24
> +		 *  data[10]  1 [ a9 a9 a9 a9 a9 a9 a9 a9 ] bits 23 .. 16
> +		 *  data[11]  2 [ a9  k  k  k  k  k  k  k ] bits 15 .. 8
> +		 *  data[12]  3 [                         ] bits  7 .. 0
> +		 */
> +
> +		/* Get data into these four blocks val1 to val4 */
> +		val1 =3D get_unaligned_be32(&data[0]);
> +		val2 =3D get_unaligned_be32(&data[3]);
> +		val3 =3D get_unaligned_be32(&data[6]);
> +		val4 =3D get_unaligned_be32(&data[9]);
> +
> +		/* Extract calibration coefficients and modify */
> +		c->Cx  =3D FIELD_GET(GENMASK(31, 23), val1) - 256;
> +		c->Cy1 =3D FIELD_GET(GENMASK(22, 14), val1) - 256;
> +		c->Cy2 =3D FIELD_GET(GENMASK(13,  5), val1) - 256;
> +		c->a2  =3D FIELD_GET(GENMASK(28, 22), val2) -  64;
> +		c->a3  =3D FIELD_GET(GENMASK(21, 15), val2) -  64;
> +		c->a4  =3D FIELD_GET(GENMASK(14,  7), val2) - 128;
> +		c->a5  =3D FIELD_GET(GENMASK(30, 22), val3) - 112;
> +		c->a6  =3D FIELD_GET(GENMASK(21, 15), val3) -  64;
> +		c->a7  =3D FIELD_GET(GENMASK(14,  7), val3) - 128;
> +		c->a8  =3D FIELD_GET(GENMASK(30, 24), val4) -  64;
> +		c->a9  =3D FIELD_GET(GENMASK(23, 15), val4) - 112;
> +		c->k   =3D FIELD_GET(GENMASK(14,  8), val4);
> +
> +		break;
> +
> +	default:
> +		dev_err(yas5xx->dev, "unknown version of YAS537\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static void yas530_532_dump_calibration(struct yas5xx *yas5xx)
>  {
>  	struct yas5xx_calibration *c =3D &yas5xx->calibration;
> @@ -772,6 +1182,26 @@ static void yas530_532_dump_calibration(struct yas5=
xx *yas5xx)
>  	dev_dbg(yas5xx->dev, "dck =3D %d\n", c->dck);
>  }
> =20
> +static void yas537_dump_calibration(struct yas5xx *yas5xx)
> +{
> +	struct yas5xx_calibration *c =3D &yas5xx->calibration;
> +
> +	if (yas5xx->version =3D=3D YAS537_VERSION_1) {
> +		dev_dbg(yas5xx->dev, "Cx =3D %d\n", c->Cx);
> +		dev_dbg(yas5xx->dev, "Cy1 =3D %d\n", c->Cy1);
> +		dev_dbg(yas5xx->dev, "Cy2 =3D %d\n", c->Cy2);
> +		dev_dbg(yas5xx->dev, "a2 =3D %d\n", c->a2);
> +		dev_dbg(yas5xx->dev, "a3 =3D %d\n", c->a3);
> +		dev_dbg(yas5xx->dev, "a4 =3D %d\n", c->a4);
> +		dev_dbg(yas5xx->dev, "a5 =3D %d\n", c->a5);
> +		dev_dbg(yas5xx->dev, "a6 =3D %d\n", c->a6);
> +		dev_dbg(yas5xx->dev, "a7 =3D %d\n", c->a7);
> +		dev_dbg(yas5xx->dev, "a8 =3D %d\n", c->a8);
> +		dev_dbg(yas5xx->dev, "a9 =3D %d\n", c->a9);
> +		dev_dbg(yas5xx->dev, "k =3D %d\n", c->k);
> +	}
> +}
> +
>  static int yas530_532_set_offsets(struct yas5xx *yas5xx, s8 ox, s8 oy1, =
s8 oy2)
>  {
>  	int ret;
> @@ -888,6 +1318,45 @@ static int yas530_532_power_on(struct yas5xx *yas5x=
x)
>  	return regmap_write(yas5xx->map, YAS530_532_MEASURE_INTERVAL, 0);
>  }
> =20
> +static int yas537_power_on(struct yas5xx *yas5xx)
> +{
> +	int ret;
> +	u8 intrvl;
> +
> +	/* Write registers according to Android driver */
> +	ret =3D regmap_write(yas5xx->map, YAS537_ADCCAL, GENMASK(1, 0));
> +	if (ret)
> +		return ret;
> +	ret =3D regmap_write(yas5xx->map, YAS537_ADCCAL+1, GENMASK(7, 3));
Spaces around the +=20

> +	if (ret)
> +		return ret;
> +	ret =3D regmap_write(yas5xx->map, YAS537_TRM, GENMASK(7, 0));
> +	if (ret)
> +		return ret;
> +
> +	/* The interval value is static in regular operation */
> +	intrvl =3D (YAS537_DEFAULT_SENSOR_DELAY_MS * 1000
> +		 - YAS537_MEASURE_TIME_WORST_US) / 4100;
> +	ret =3D regmap_write(yas5xx->map, YAS537_MEASURE_INTERVAL, intrvl);
> +	if (ret)
> +		return ret;
> +
> +	/* The average value is also static in regular operation */
> +	ret =3D regmap_write(yas5xx->map, YAS537_AVR, YAS537_MAG_AVERAGE_32_MAS=
K);
> +	if (ret)
> +		return ret;
> +
> +	/* Perform the "rcoil" part but skip the "last_after_rcoil" read */
> +	ret =3D regmap_write(yas5xx->map, YAS537_CONFIG, BIT(3));
> +	if (ret)
> +		return ret;
> +
> +	/* Wait until the coil has ramped up */
> +	usleep_range(YAS537_MAG_RCOIL_TIME_US, YAS537_MAG_RCOIL_TIME_US + 100);
> +
> +	return 0;
> +}
> +
>  static int yas5xx_probe(struct i2c_client *i2c,
>  			const struct i2c_device_id *id)
>  {
Hopefully I conveyed the point in earlier review, but I'd expcte
a simple switch statement in here based on id and version
to set yas5xx->chip_info to appropriate static const structure
which includes both data and function pointers to flatten
all the device specific switches into simple assignments or
calls of function pointers.
=20
> @@ -946,35 +1415,53 @@ static int yas5xx_probe(struct i2c_client *i2c,
> =20

Below becomes something like
	ret =3D yas5xx->chip_info.get_calib_data(yas5xx);
	if (ret)
		goto assert_reset;

	yas5xx->chip_info.dump_calibration(yas5xx);
	yas5xx->chip_info.power_on(yas5xx)
	if (yas5xx->chip_info.measure_offsets) {
		ret =3D yas5xx->chip_info.measure_offsets(yas5xx);
		if (ret)
			got asert_reset;
	}
	Which is a lot more readable and less code at the expense
	of static const data (a good trade off in most cases).

>  	switch (yas5xx->devid) {
>  	case YAS530_DEVICE_ID:
> -		ret =3D yas530_get_calibration_data(yas5xx);
> +	case YAS532_DEVICE_ID:
> +
> +		if (yas5xx->devid =3D=3D YAS530_DEVICE_ID) {
> +			ret =3D yas530_get_calibration_data(yas5xx);



> +			if (ret)
> +				goto assert_reset;
> +			dev_info(dev, "detected YAS530 MS-3E %s",
> +				 yas5xx->version ? "B" : "A");
> +			strncpy(yas5xx->name, "yas530", sizeof(yas5xx->name));

Indirection as suggested below and this is already part of
yas5xx->chip_info

> +		} else {
> +			ret =3D yas532_get_calibration_data(yas5xx);
> +			if (ret)
> +				goto assert_reset;
> +			dev_info(dev, "detected YAS532/YAS533 MS-3R/F %s",
> +				 yas5xx->version ? "AC" : "AB");
> +			strncpy(yas5xx->name, "yas532", sizeof(yas5xx->name));
> +		}
> +
> +		yas530_532_dump_calibration(yas5xx);
> +		ret =3D yas530_532_power_on(yas5xx);
> +		if (ret)
> +			goto assert_reset;
> +		ret =3D yas530_532_measure_offsets(yas5xx);
>  		if (ret)
>  			goto assert_reset;
> -		dev_info(dev, "detected YAS530 MS-3E %s",
> -			 yas5xx->version ? "B" : "A");
> -		strncpy(yas5xx->name, "yas530", sizeof(yas5xx->name));
>  		break;
> -	case YAS532_DEVICE_ID:
> -		ret =3D yas532_get_calibration_data(yas5xx);
> +
> +	case YAS537_DEVICE_ID:
> +		ret =3D yas537_get_calibration_data(yas5xx);
> +		if (ret)
> +			goto assert_reset;
> +		dev_info(dev, "detected YAS537 MS-3T version %s",
> +			 yas5xx->version ? "1" : "0");
> +		strncpy(yas5xx->name, "yas537", sizeof(yas5xx->name));
> +
> +		yas537_dump_calibration(yas5xx);
> +		ret =3D yas537_power_on(yas5xx);
>  		if (ret)
>  			goto assert_reset;
> -		dev_info(dev, "detected YAS532/YAS533 MS-3R/F %s",
> -			 yas5xx->version ? "AC" : "AB");
> -		strncpy(yas5xx->name, "yas532", sizeof(yas5xx->name));
>  		break;
> +
>  	default:
>  		ret =3D -ENODEV;
>  		dev_err(dev, "unhandled device ID %02x\n", yas5xx->devid);
>  		goto assert_reset;
>  	}
> =20
> -	yas530_532_dump_calibration(yas5xx);
> -	ret =3D yas530_532_power_on(yas5xx);
> -	if (ret)
> -		goto assert_reset;
> -	ret =3D yas530_532_measure_offsets(yas5xx);
> -	if (ret)
> -		goto assert_reset;
> -
>  	indio_dev->info =3D &yas5xx_info;
>  	indio_dev->available_scan_masks =3D yas5xx_scan_masks;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> @@ -1070,7 +1557,19 @@ static int __maybe_unused yas5xx_runtime_resume(st=
ruct device *dev)
>  	usleep_range(31000, 40000);
>  	gpiod_set_value_cansleep(yas5xx->reset, 0);
> =20
> -	ret =3D yas5xx_power_on(yas5xx);
> +	switch (yas5xx->devid) {
> +	case YAS530_DEVICE_ID:
> +	case YAS532_DEVICE_ID:
> +		ret =3D yas530_532_power_on(yas5xx);

After you've added that device type specific structure I keep talking about
it can have a function pointer and this switch statement becomes as simple
bit of indirection to a constant data.


	yas5xx->chip_info.power_on(yas5xx);=20

> +		break;
> +	case YAS537_DEVICE_ID:
> +		ret =3D yas537_power_on(yas5xx);
> +		break;
> +	default:
> +		dev_err(yas5xx->dev, "unknown device type\n");
> +		ret =3D -EINVAL;
> +		break;
> +	}
>  	if (ret) {
>  		dev_err(dev, "cannot power on\n");
>  		goto out_reset;

