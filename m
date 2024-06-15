Return-Path: <linux-iio+bounces-6307-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 320D690995B
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 19:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE321C21064
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A445F26AE7;
	Sat, 15 Jun 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIEHPaa3"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784C60263;
	Sat, 15 Jun 2024 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473684; cv=none; b=cj31Xbx5BRom8zqst/I/VmR9M7iM1hCm5V9EfBd9phliGDIs+bGaGeLPbpJDTNPLQDiwD2Si7XgalvpNyB/BTDMLortNy4w4H7CAs98tE2dCqoLdVKEWcvb5ASZUNRJe0GY6rJQ5Zv9W8pcataTh8aHvRuXayaKW1I0jJLB67i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473684; c=relaxed/simple;
	bh=wo107lY8IJHyvfGV3lqTbuCNyuUSie5YvzpDVzIE5QA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dJPqVGaf4oi8JqPIStJfUndlKt0M8EsA9gmv3NtEC59GqPCVqujuhA/bEntWl0e0lOT5hdxZLMocD0c6vyXQZo2j3gf/Wd5oMxPFarMn5VqLQ9ug8OD6ko/TMKZdbamrN+NEk44IeJpaHoZJ00CGQRrDUQjPNKYvcQjNLeVRaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIEHPaa3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F46C116B1;
	Sat, 15 Jun 2024 17:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718473683;
	bh=wo107lY8IJHyvfGV3lqTbuCNyuUSie5YvzpDVzIE5QA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tIEHPaa3Yh6ZGk5JKtrVkpejOnPhlKaQxsKUVxmQxfk+6LSfo8IzxZVsIgWzsCSHx
	 5VwN/+RO0UOQdKxWjS3E/rbRG8NfFmW2PYqm05/GWC4nflpZ2kER+GPRqi3x/7ROV9
	 2A95R875qnyBCw4uG5DdulsMOh8CLEhxyaaqM67u0HXLc1RpfqvFO4WENAtI6EAhaY
	 lKe4GIZQ/OKgJNj/eGSufbqHddeJ3DPaUsRI9jow3Wj/1zjdTs0Ik212C42ru13D2O
	 WweU5uIo4xmNsKSI/TpgKoR6fPtcyUiLJ0cK0qvnEkpo5ZSy3iXTFPCfTMTMoyeqzN
	 eSlaw6Z2YCyQw==
Date: Sat, 15 Jun 2024 18:47:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bu27034: ROHM BU27034NUC to BU27034ANUC
Message-ID: <20240615184757.2148f7d7@jic23-huawei>
In-Reply-To: <d43500621a2ad0811f58c8c7c87cbdc7b2abb8c1.1718013518.git.mazziesaccount@gmail.com>
References: <cover.1718013518.git.mazziesaccount@gmail.com>
	<d43500621a2ad0811f58c8c7c87cbdc7b2abb8c1.1718013518.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 10 Jun 2024 13:01:23 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The ROHM BU27034NUC was cancelled and BU27034ANUC is replacing this
> sensor. Use the BU27034NUC driver to support the new BU27034ANUC.
>=20
> According to ROHM, the BU27034NUC was never mass-produced. Hence dropping
> the BU27034NUC support and using this driver to support BU27034ANUC
> should not be a problem to users.
>=20
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")

This is an odd case.  I don't think a fixes tag is appropriate and I
don't think we can use the original compatible.  I don't mind breaking
support for the non existent port going forwards and indeed dropping
all indication it ever existed, but the old kernel's are out there and
even getting this into stable is far from a guarantee there won't be
a kernel run on a board that has this compatible but has the old
driver.  It's also too big really to be stable material.

So I think the path forwards is a new compatible and drop the old
one from the dt bindings and driver.  Thus any new dts for a board
that actually has this device will use the new compatible and avoid
any risk of encountering the old driver.

Maybe we can be more relaxed - what actually happens if you use the
existing driver with the new part?

I'm trusting you copied the maths right for the computed
channels (that take too long to review!)  So everything inline is
formatting type stuff.

> ---
>  drivers/iio/light/rohm-bu27034.c | 321 +++++++------------------------
>  1 file changed, 68 insertions(+), 253 deletions(-)
>=20
> diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu=
27034.c
> index bf3de853a811..51acad2cafbd 100644
> --- a/drivers/iio/light/rohm-bu27034.c
> +++ b/drivers/iio/light/rohm-bu27034.c

...

>  /*
> - * Available scales with gain 1x - 4096x, timings 55, 100, 200, 400 mS
> + * Available scales with gain 1x - 1024x, timings 55, 100, 200, 400 mS
>   * Time impacts to gain: 1x, 2x, 4x, 8x.
>   *
> - * =3D> Max total gain is HWGAIN * gain by integration time (8 * 4096) =
=3D 32768
> + * =3D> Max total gain is HWGAIN * gain by integration time (8 * 1024) =
=3D 8192
> + * if 1x gain is scale 1, scale for 2x gain is 0.5, 4x =3D> 0.25,
> + * ... 8192x =3D> 0.0001220703125 =3D> 122070.3125 nanos
>   *
> - * Using NANO precision for scale we must use scale 64x corresponding ga=
in 1x
> - * to avoid precision loss. (32x would result scale 976 562.5(nanos).
> + * Using NANO precision for scale, we must use scale 16x corresponding g=
ain 1x
> + * to avoid precision loss. (8x would result scale 976 562.5(nanos).
>   */
> -#define BU27034_SCALE_1X	64
> +#define BU27034_SCALE_1X	16

...

> -#define BU27034_CHAN_DATA(_name, _ch2)					\
> +#define BU27034_CHAN_DATA(_name)					\
>  {									\
>  	.type =3D IIO_INTENSITY,						\
>  	.channel =3D BU27034_CHAN_##_name,				\
> -	.channel2 =3D (_ch2),						\
> +	.channel2 =3D IIO_MOD_LIGHT_CLEAR,				\
>  	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |			\
>  			      BIT(IIO_CHAN_INFO_SCALE),			\
>  	.info_mask_separate_available =3D BIT(IIO_CHAN_INFO_SCALE),	\
> @@ -195,13 +182,12 @@ static const struct iio_chan_spec bu27034_channels[=
] =3D {
>  	/*
>  	 * The BU27034 DATA0 and DATA1 channels are both on the visible light
>  	 * area (mostly). The data0 sensitivity peaks at 500nm, DATA1 at 600nm.
> -	 * These wave lengths are pretty much on the border of colours making
> -	 * these a poor candidates for R/G/B standardization. Hence they're both
> -	 * marked as clear channels
> +	 * These wave lengths are cyan(ish) and orange(ish), making these
> +	 * sub-optiomal candidates for R/G/B standardization. Hence they're
> +	 * both marked as clear channels.

I think just indexing them and not giving a modifier is probably better than
claiming they are clear.  Leave it more vague basically.

>  	 */
> -	BU27034_CHAN_DATA(DATA0, IIO_MOD_LIGHT_CLEAR),
> -	BU27034_CHAN_DATA(DATA1, IIO_MOD_LIGHT_CLEAR),
> -	BU27034_CHAN_DATA(DATA2, IIO_MOD_LIGHT_IR),
> +	BU27034_CHAN_DATA(DATA0),
> +	BU27034_CHAN_DATA(DATA1),
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };

> @@ -281,39 +261,15 @@ static int bu27034_get_gain_sel(struct bu27034_data=
 *data, int chan)
>  {
>  	int ret, val;
> =20
Probably no blank line here.

> -	switch (chan) {
> -	case BU27034_CHAN_DATA0:
> -	case BU27034_CHAN_DATA1:
> -	{
> -		int reg[] =3D {
> -			[BU27034_CHAN_DATA0] =3D BU27034_REG_MODE_CONTROL2,
> -			[BU27034_CHAN_DATA1] =3D BU27034_REG_MODE_CONTROL3,
> -		};
> -		ret =3D regmap_read(data->regmap, reg[chan], &val);
> -		if (ret)
> -			return ret;
> -
> -		return FIELD_GET(BU27034_MASK_D01_GAIN, val);
> -	}
> -	case BU27034_CHAN_DATA2:
> -	{
> -		int d2_lo_bits =3D fls(BU27034_MASK_D2_GAIN_LO);
> -
> -		ret =3D regmap_read(data->regmap, BU27034_REG_MODE_CONTROL2, &val);
> -		if (ret)
> -			return ret;
> +	int reg[] =3D {
> +		[BU27034_CHAN_DATA0] =3D BU27034_REG_MODE_CONTROL2,
> +		[BU27034_CHAN_DATA1] =3D BU27034_REG_MODE_CONTROL3,
> +	};
blank line here

> +	ret =3D regmap_read(data->regmap, reg[chan], &val);
> +	if (ret)
> +		return ret;

...

> =20
>  struct bu27034_lx_coeff {
> @@ -887,21 +710,16 @@ static int bu27034_fixp_calc_lx(unsigned int ch0, u=
nsigned int ch1,
>  {
>  	static const struct bu27034_lx_coeff coeff[] =3D {
>  		{
> -			.A =3D 31265280,		/* 3.126528 */
> -			.B =3D 1157400832,	/*115.7400832 */
> -			.C =3D 681982976,		/* -68.1982976 */
> -			.is_neg =3D {false, false, true},
> +			.A =3D 4780800,		/* -0.47808 */
> +			.B =3D 64400000,		/*6.44 */


/* 6.44 */
It was odd before but might as well tidy that up!

> +			.C =3D 190880000,		/* 19.088 */
> +			.is_neg =3D {true, false, false},
{ true, false, false }
Tidy that up as well.
>  		}, {
> -			.A =3D 3489024,		/* 0.3489024 */
> -			.B =3D 137210309,		/* 13.721030912 */
> -			.C =3D 226606476,		/* 22.66064768 */
> +			.A =3D 0,			/* 0 */
> +			.B =3D 19123200,		/* 1.91232 */
> +			.C =3D 305408000,		/* 30.5408 */
>  			/* All terms positive */
> -		}, {
> -			.A =3D 453120,		/* -0.045312 */
> -			.B =3D 7068160,		/* -0.706816 */
> -			.C =3D 374809600,		/* 37.48096 */
> -			.is_neg =3D {true, true, false},
> -		}
> +		},
>  	};

...

> @@ -1065,12 +882,10 @@ static int bu27034_get_single_result(struct bu2703=
4_data *data, int chan,
>   * D1 =3D data1/ch1_gain/meas_time_ms * 25600
>   *
>   * Then:
> - * if (D1/D0 < 0.87)
> - *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 0.87) * 3.45 + =
1)
> - * else if (D1/D0 < 1)
> - *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 0.87) * 0.385 +=
 1)
> - * else
> - *	lx =3D (0.001331 * D0 + 0.0000354 * D1) * ((D1 / D0 - 2) * -0.05 + 1)
> + * If (D1/D0 < 1.5)
> + *    lx =3D (0.001193 * D0 + (-0.0000747) * D1) * ((D1/D0 =E2=80=93 1.5=
) * (0.25) + 1)

Brackets around 0.25 odd.  The negative one might be justified if the code
is such that   you can't just do D0 - 0.0000747 instead.

> + * Else
> + *    lx =3D (0.001193* D0 + (-0.0000747) * D1)
Space between 3 and *

>   *
>   * We use it here. Users who have for example some colored lens
>   * need to modify the calculation but I hope this gives a starting point=
 for
> @@ -1139,7 +954,7 @@ static int bu27034_calc_mlux(struct bu27034_data *da=
ta, __le16 *res, int *val)
> =20
>  static int bu27034_get_mlux(struct bu27034_data *data, int chan, int *va=
l)
>  {
> -	__le16 res[3];
> +	__le16 res[BU27034_NUM_HW_DATA_CHANS];
>  	int ret;
> =20
>  	ret =3D bu27034_meas_set(data, true);


