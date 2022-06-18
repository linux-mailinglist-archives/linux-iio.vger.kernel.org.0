Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACEF550584
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 16:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbiFROpc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 10:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiFROoR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 10:44:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BFC01583E;
        Sat, 18 Jun 2022 07:44:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C766F60BBA;
        Sat, 18 Jun 2022 14:44:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1815AC3411A;
        Sat, 18 Jun 2022 14:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655563455;
        bh=+NWwe84bZUd9FsW1O64YgE40W9QbqSaTKUN8DmX4ki0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r0Jee+Y3ruwfeA7Y3xWt0vdhT09KkEpW9ry/e49Disrsu/t1qOucHt1hpswZax4aB
         ozKdBjI2VSFGK6DFphcAbJfPaEHm8xTRfmHkukUSDmU+S66XmDhyX0E5wBtOLsAoWS
         soQFUY2xn3WCkj0H79wxwtpA6qmcbYCs6OZvNL7tTTZeZxQMhp3YvF+d3tPiY+r857
         jyTTpkk70YfIqC0vnxKwPRk+T92dWLfQ1GXwRS5GUaOSN3awWpO8oU9JvKp5q1Pd7D
         QHxLkYijyIB+cvbtUaV9ZqqmclEw0sArhErWVqMfmqNAnaR5VonsAS2a2heTIgV9Zx
         uQdu2Kx4cYuoQ==
Date:   Sat, 18 Jun 2022 15:53:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 4/8] iio: magnetometer: yas530: Correct temperature
 handling
Message-ID: <20220618155331.5da93b88@jic23-huawei>
In-Reply-To: <076e87f66378be8c729723cb9be5bc9151c081ab.1655509425.git.jahau@rocketmail.com>
References: <cover.1655509425.git.jahau@rocketmail.com>
        <076e87f66378be8c729723cb9be5bc9151c081ab.1655509425.git.jahau@rocketmail.com>
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

On Sat, 18 Jun 2022 02:13:12 +0200
Jakob Hauser <jahau@rocketmail.com> wrote:

> The raw temperature value is a number of counts from a certain starting
> point. The resolution of the temperature counts is different for the YAS
> variants.
>=20
> Temperature compensation for YAS532 version AC seems to be handled differ=
ently.
> It uses the deviation from 20 degree Celsius [1] whereas YAS530 and older
> versions of YAS532 apply solely the t value as a multiplier [2][3].
>=20
> In funtion yas5xx_read_raw(), add case IIO_CHAN_INFO_PROCESSED. Remove sc=
ale
> of temperature as this isn't applied.
>=20
> Additionally correct sign of temperature channel in iio_chan_spec. It's a=
lready
> defined that way in the yas5xx_get_measure() function.
>=20
> [1] https://github.com/msm8916-mainline/android_kernel_qcom_msm8916/blob/=
GT-I9195I/drivers/iio/magnetometer/yas_mag_drv-yas532.c#L442
> [2] https://github.com/NovaFusion/android_kernel_samsung_golden/blob/cm-1=
2.1/drivers/sensor/compass/yas_mag_driver-yas530.c#L881-L883
> [3] https://github.com/LineageOS/android_kernel_samsung_msm8930-common/bl=
ob/lineage-18.1/drivers/sensors/geomagnetic/yas_mag_driver-yas53x.c#L856-L8=
58
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/magnetometer/yamaha-yas530.c | 99 ++++++++++++++++++------
>  1 file changed, 76 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magne=
tometer/yamaha-yas530.c
> index bd43b2555b73..9b45a550f31e 100644
> --- a/drivers/iio/magnetometer/yamaha-yas530.c
> +++ b/drivers/iio/magnetometer/yamaha-yas530.c
> @@ -77,6 +77,7 @@
>  #define YAS530_DATA_BITS		12
>  #define YAS530_DATA_CENTER		BIT(YAS530_DATA_BITS - 1)
>  #define YAS530_DATA_OVERFLOW		(BIT(YAS530_DATA_BITS) - 1)
> +#define YAS530_20DEGREES		182 /* Counts starting at -62 =C2=B0C */
> =20
>  #define YAS532_DEVICE_ID		0x02 /* YAS532/YAS533 (MS-3R/F) */
>  #define YAS532_VERSION_AB		0 /* YAS532/533 AB (MS-3R/F AB) */
> @@ -88,7 +89,7 @@
>  #define YAS532_DATA_BITS		13
>  #define YAS532_DATA_CENTER		BIT(YAS532_DATA_BITS - 1)
>  #define YAS532_DATA_OVERFLOW		(BIT(YAS532_DATA_BITS) - 1)
> -#define YAS532_20DEGREES		390 /* Looks like Kelvin */
> +#define YAS532_20DEGREES		390 /* Counts starting at -50 =C2=B0C */
> =20
>  /* These variant IDs are known from code dumps */
>  #define YAS537_DEVICE_ID		0x07 /* YAS537 (MS-3T) */
> @@ -314,7 +315,7 @@ static s32 yas5xx_linearize(struct yas5xx *yas5xx, u1=
6 val, int axis)

Hmm. I'm not a great fun of big hydra functions to handle differences
between devices.  This could easily all be one code flow with some
lookups into chip specific constant data (as btw could a lot of
the other switch statements in the existing driver).


>  static int yas5xx_get_measure(struct yas5xx *yas5xx, s32 *to, s32 *xo, s=
32 *yo, s32 *zo)
>  {
>  	struct yas5xx_calibration *c =3D &yas5xx->calibration;
> -	u16 t, x, y1, y2;
> +	u16 t_ref, t, x, y1, y2;
>  	/* These are "signed x, signed y1 etc */
>  	s32 sx, sy1, sy2, sy, sz;
>  	int ret;
> @@ -329,16 +330,46 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx=
, s32 *to, s32 *xo, s32 *yo,
>  	sy1 =3D yas5xx_linearize(yas5xx, y1, 1);
>  	sy2 =3D yas5xx_linearize(yas5xx, y2, 2);
> =20
> -	/*
> -	 * Temperature compensation for x, y1, y2 respectively:
> -	 *
> -	 *          Cx * t
> -	 * x' =3D x - ------
> -	 *           100
> -	 */
> -	sx =3D sx - (c->Cx * t) / 100;
> -	sy1 =3D sy1 - (c->Cy1 * t) / 100;
> -	sy2 =3D sy2 - (c->Cy2 * t) / 100;
> +	/* Set the temperature reference value (unit: counts) */
> +	switch (yas5xx->devid) {
> +	case YAS530_DEVICE_ID:
> +		t_ref =3D YAS530_20DEGREES;

One thought to simplify the divergent flow below.

		t_ref2 =3D 0;
> +		break;
> +	case YAS532_DEVICE_ID:
> +		t_ref =3D YAS532_20DEGREES;
		if (yas5xx->version =3D=3D YAS532_VERSION_AC)
			t_ref2 =3D YAS432_20DEGREES;
		else
			t_ref2 =3D 0;

Possibly with moving some of the comments below up here.
As mentioned below, this stuff would be even better if
in a chip type specific const structure rather than as code.
That is have one switch statement in probe that picks from
an array of=20

struct yas5xx_chip_info {
	/* COMMENTS ON WHAT these are.. *
	u16 tref;
	u16 tref2;
	int ref_temp_celsius;
	int min_temp_celsuis;
};
static const struct yas5xx_chip_info[] =3D {
	[ENUM value we will use to pick right on in probe] =3D {
		...

etc


> +		break;
> +	default:
> +		dev_err(yas5xx->dev, "unknown device type\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Temperature compensation for x, y1, y2 respectively */
> +	if (yas5xx->devid =3D=3D YAS532_DEVICE_ID &&
> +	    yas5xx->version =3D=3D YAS532_VERSION_AC) {
> +		/*
> +		 * YAS532 version AC uses the temperature deviation as a
> +		 * multiplier.
> +		 *
> +		 *          Cx * (t - t_ref)
> +		 * x' =3D x - ----------------
> +		 *                100
> +		 */
> +		sx =3D sx - (c->Cx * (t - t_ref)) / 100;
> +		sy1 =3D sy1 - (c->Cy1 * (t - t_ref)) / 100;
> +		sy2 =3D sy2 - (c->Cy2 * (t - t_ref)) / 100;

Use t_ref2 here and then you could drop the two paths.

> +	} else {
> +		/*
> +		 * YAS530 and YAS532 version AB use solely the t value as a
> +		 * multiplier.
> +		 *
> +		 *          Cx * t
> +		 * x' =3D x - ------
> +		 *           100
> +		 */
> +		sx =3D sx - (c->Cx * t) / 100;
> +		sy1 =3D sy1 - (c->Cy1 * t) / 100;
> +		sy2 =3D sy2 - (c->Cy2 * t) / 100;
> +	}
> =20
>  	/*
>  	 * Break y1 and y2 into y and z, y1 and y2 are apparently encoding
> @@ -347,11 +378,37 @@ static int yas5xx_get_measure(struct yas5xx *yas5xx=
, s32 *to, s32 *xo, s32 *yo,
>  	sy =3D sy1 - sy2;
>  	sz =3D -sy1 - sy2;
> =20
> -	/*
> -	 * FIXME: convert to Celsius? Just guessing this is given
> -	 * as 1/10:s of degrees so multiply by 100 to get millicentigrades.
> -	 */
> -	*to =3D t * 100;
> +	/* Process temperature readout */
> +	switch (yas5xx->devid) {
> +	case YAS530_DEVICE_ID:
> +		/*
> +		 * Raw temperature value t is the number of counts starting
> +		 * at -62 =C2=B0C. Reference value t_ref is the number of counts
> +		 * between -62 =C2=B0C and 20 =C2=B0C (82 =C2=B0C range).
Roll this info into the maths and only have the constants set in the switch
statement.  Even better if you just move them into chip specific data so
look them up directly rather than via a switch of devid.  The whole driver
would benefit from moving this stuff to const data rather than switch
statements all over the place.

	int min_temp_x10 =3D yas5xx->chip_info.min_temp_x10;
	const int ref_temp_x10 =3D 200;

	*to =3D (min_temp_x10 + ((ref_temp_x10 - min_temp_x10) * t / t_ref)) * 100;

That should make the code self explanatory and remove need for the comments.

> +		 *
> +		 * Temperature in =C2=B0C would be (82 / t_ref * t) - 62.
> +		 *
> +		 * Contrary to this, perform multiplication first and division
> +		 * second due to calculating with integers.
> +		 *
> +		 * To get a nicer result, calculate with 1/10:s degrees Celsius
> +		 * and finally multiply by 100 to return milli degrees Celsius.
> +		 */
> +		*to =3D ((820 * t / t_ref) - 620) * 100;
> +		break;
> +	case YAS532_DEVICE_ID:
> +		/*
> +		 * Actually same procedure for YAS532 but the starting point is
> +		 * at -50 =C2=B0C. Reference value t_ref is the number of counts
> +		 * between -50 =C2=B0C and 20 =C2=B0C (70 =C2=B0C range).
> +		 */
> +		*to =3D ((700 * t / t_ref) - 500) * 100;
> +		break;
> +	default:
> +		dev_err(yas5xx->dev, "unknown device type\n");
> +		return -EINVAL;
> +	}
> +
>  	/*
>  	 * Calibrate [x,y,z] with some formulas like this:
>  	 *
> @@ -384,6 +441,7 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
>  	int ret;
> =20
>  	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
>  	case IIO_CHAN_INFO_RAW:
>  		pm_runtime_get_sync(yas5xx->dev);
>  		ret =3D yas5xx_get_measure(yas5xx, &t, &x, &y, &z);
> @@ -410,11 +468,6 @@ static int yas5xx_read_raw(struct iio_dev *indio_dev,
>  		}
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		if (chan->address =3D=3D 0) {
> -			/* Temperature is unscaled */
> -			*val =3D 1;
> -			return IIO_VAL_INT;
> -		}
>  		switch (yas5xx->devid) {
>  		case YAS530_DEVICE_ID:
>  			/*
> @@ -513,7 +566,7 @@ static const struct iio_chan_spec yas5xx_channels[] =
=3D {
>  		.address =3D 0,
>  		.scan_index =3D 0,
>  		.scan_type =3D {
> -			.sign =3D 'u',
> +			.sign =3D 's',
>  			.realbits =3D 32,
>  			.storagebits =3D 32,
>  			.endianness =3D IIO_CPU,

